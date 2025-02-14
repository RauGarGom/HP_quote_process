CREATE TABLE IF NOT EXISTS suppliers(
    supplier_id serial PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    supplier_email VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS products(
    product_id serial PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS suppliers_products(
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    PRIMARY KEY (supplier_id, product_id)
);

CREATE TABLE IF NOT EXISTS inquiries(
    inquiry_id serial PRIMARY KEY,
    inquiry_text TEXT NOT NULL,
    product_id INT,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    material VARCHAR(255),
    finishing VARCHAR(255),
    shape VARCHAR(255),
    product_length FLOAT,
    product_width FLOAT,
    product_height FLOAT,
    inquiry_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS suppliers_quotes(
    supplier_quote_id serial PRIMARY KEY,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    inquiry_id INT NOT NULL,
    cost_average DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    number_days INT,
    distance INT,
    quote_performance FLOAT,
    supplier_performance FLOAT,
    quality_item_performance FLOAT,
    accepted BOOLEAN,
    query_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (inquiry_id) REFERENCES inquiries(inquiry_id),
    UNIQUE (supplier_id, inquiry_id)
);