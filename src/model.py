import os
import numpy as np
from dotenv import load_dotenv, find_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from pydantic import BaseModel, Field
from typing import Optional
import psycopg2
from psycopg2.extras import DictCursor
import pickle
import pandas as pd


load_dotenv(find_dotenv())
os.environ["LANGCHAIN_PROJECT"] = "hp_poc"
os.environ["LANGCHAIN_TRACING_V2"] = "true"


class inquiry(BaseModel):
    text: str = Field(description="The original inquiry text, without any changes")
    product: str = Field(description="The product name out of the following options: notebook, sticker, business card",enumerate=["notebook","sticker","business card"])
    quantity: int = Field(description="The quantity of the product")
    material: Optional[str] = Field(description="The material of the product", default=None)
    finishing: Optional[str] = Field(description="The finishing of the product", default=None)
    shape: Optional[str] = Field(description="The shape of the product", default=None)
    length: Optional[float] = Field(description="The length of the product", default=None)
    width: Optional[float] = Field(description="The width of the product", default=None)
    height: Optional[float] = Field(description="The height of the product", default=None)


#####################
#DB functions
#####################

def db_connect():
    host = os.getenv("DB_HOST", "localhost")  ### Change to llm-db.c9egi4wa8bqm.eu-west-1.rds.amazonaws.com for production, localhost for local
    username = os.getenv("DB_USER", "postgres")
    password = os.getenv("DB_PASSWORD", "") ### Change to POSTGRE_PASS for production, LOCAL_POSTGRE_PASS for local.
    port = os.getenv("DB_PORT", 5432)
    database = os.getenv("DB_NAME", "postgres")
    try:
        conn = psycopg2.connect(
            host=host,
            port=port,
            dbname=database,
            user=username,
            password=password,
            cursor_factory=DictCursor
        )
        cursor = conn.cursor()
        return conn, cursor
    except psycopg2.Error as e:
        print(f"Error connecting to the database: {e}")
        return None, None

def db_get_product_id(product_name):
    conn, cursor = db_connect()
    cursor.execute('''
    SELECT product_id FROM products WHERE product_name = %s
    ''',
    (product_name,)
    )
    result = cursor.fetchone()
    if result is None:
        return None
    product_id = result[0]
    return product_id

def db_insert_values(inquiry):
    product_id = db_get_product_id(inquiry["product"])
    conn, cursor = db_connect()
    cursor.execute('''
    INSERT INTO inquiries (inquiry_text, product_id, product_name, quantity, material, finishing, shape, product_length, product_width, product_height)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''',
    (inquiry["text"], product_id, inquiry["product"], inquiry["quantity"], inquiry["material"], inquiry["finishing"], inquiry["shape"], inquiry["length"], inquiry["width"], inquiry["height"])
    )
    conn.commit()
    conn.close()

#####################
#Main functions
#####################


def inquiry_classifier(input: str) -> inquiry:
    tagging_prompt = ChatPromptTemplate.from_template('''Extract the desired information from the text {input} and return it in a valid Pydantic object. If any information is not provided, return None.''')
    prompt = tagging_prompt.invoke({"input":input})
    model = ChatGoogleGenerativeAI(model="gemini-2.0-flash",temperature=0).with_structured_output(inquiry)
    response = model.invoke(prompt).model_dump()
    db_insert_values(response)
    return response

def classifier_and_suppliers(input: str):
    response = inquiry_classifier(input)
    print(f"This is the information gathered: {response}")
    print("="*50)
    suppliers, ids = get_suppliers(response['product'])
    print(f"The inquiry will be sent to the following suppliers:")
    for supplier in suppliers:
        print(supplier)
    return response, suppliers

def best_offer(inquiry_id:int):
    model_path = os.path.join('models', 'acceptance_predictor.pkl')
    with open(model_path, 'rb') as f:
        dtc = pickle.load(f)
    df_supplier_quotes = pd.read_csv('data/csv/supplier_quotes.csv')
    sel_quotes = df_supplier_quotes[df_supplier_quotes['inquiry_id']==inquiry_id].copy()
    features = ["cost_average", "cost_price", "number_days", "distance", "quote_performance", "supplier_performance"]
    sel_quotes['accept_probability'] = dtc.predict_proba(sel_quotes[features])[:,1].round(2)
    best_quote = sel_quotes.sort_values(['accept_probability','cost_average','number_days','distance'],ascending=[False,True,True,True]).iloc[0,:]
    answer = (f'''The best offer of inquiry {inquiry_id} is the one by supplier {best_quote['supplier_id']}, with a normalized cost of {best_quote['cost_average']}. They can deliver the product in {best_quote['number_days']} days and the acceptance probability of the quote by the customer is {best_quote['accept_probability']*100} %.''')
    return answer

def quote_acceptance(cost_average, cost_price, number_days, distance, quote_performance, supplier_performance):
    model_path = os.path.join('models', 'acceptance_predictor.pkl')
    with open(model_path, 'rb') as f:
        dtc = pickle.load(f)
    pred = dtc.predict_proba(np.array([[cost_average, cost_price, number_days, distance, quote_performance, supplier_performance]]))
    return pred[0][1]

#####################
#Auxiliary functions
#####################

def get_suppliers(product_name):
    conn, cursor = db_connect()
    product_id = db_get_product_id(product_name)
    cursor.execute('''
    SELECT supplier_id FROM suppliers_products WHERE product_id = %s
    ''', (product_id,))
    
    supplier_ids = cursor.fetchall()
    if not supplier_ids:
        return [], []
        
    # Create placeholders for the IN clause
    placeholders = ','.join(['%s'] * len(supplier_ids))
    supplier_ids_tuple = tuple(sid[0] for sid in supplier_ids)
    
    # Use the placeholders in the query
    cursor.execute(f'''
    SELECT supplier_name, supplier_email 
    FROM suppliers 
    WHERE supplier_id IN ({placeholders})
    ''', supplier_ids_tuple)
    
    supplier_info = cursor.fetchall()
    conn.close()
    return supplier_info, supplier_ids_tuple

