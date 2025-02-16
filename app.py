from fastapi import FastAPI, HTTPException, Request
from dotenv import load_dotenv, find_dotenv
from pydantic import BaseModel, Field
from decimal import Decimal
from typing import Optional
from src import model as md
import uvicorn

app = FastAPI()

load_dotenv(find_dotenv())


class SuppliersQuote(BaseModel):
    cost_average: Optional[Decimal] = Field(None, decimal_places=2)
    cost_price: Optional[Decimal] = Field(None, decimal_places=2)
    number_days: Optional[int] = None
    distance: Optional[int] = None
    quote_performance: Optional[float] = None
    supplier_performance: Optional[float] = None

    class Config:
        from_attributes = True

@app.get('/')
async def home():
    return "HelloPrint Quote Manager PoC by Raúl García"

@app.post('/classify', description='Takes the string input of the user and classifies it in some closed values. Then it stores the results in a SQL database')
async def classifier(user_text: str):
    try:
        answer = md.inquiry_classifier(user_text)
        return {"status": "success", "content": answer}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error when classifying {user_text}: {e}")
    
@app.post('/best-offer', description='Predicts the best offer of a given inquiry_id, and shows the main values')
async def best_offer(inquiry_id:int):
    try:
        answer = md.best_offer(inquiry_id)
        return {"status": "success", "content": answer}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error when retrieving the best offer: {e}")

@app.post('/quote-acceptance', description='Predicts the acceptance probability of any offer, when given the main parameters')
async def quote_acceptance(data:SuppliersQuote):
    try:
        answer = md.quote_acceptance(data.cost_average, data.cost_price, data.number_days,data.distance, data.quote_performance,data.supplier_performance)
        return {"status": "success", "acceptance_probability": answer}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error when calculating acceptance for given quote: {e}")

@app.post('/suppliers', description='Follow-up of /classify: it also returns the suppliers suitable for the inquiry')
async def classifier_suppliers(user_text:str):
    try:
        response, suppliers = md.classifier_and_suppliers(user_text)
        return {"status": "success", "content": {"response":response, "suppliers":suppliers}}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error retrieving suppliers for input {user_text}: {e}")





if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)