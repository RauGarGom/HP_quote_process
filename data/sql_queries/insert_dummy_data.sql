-- Insert suppliers
INSERT INTO suppliers (supplier_name, supplier_email) VALUES
    ('Office Supply Co', 'contact@officesupply.com'),
    ('Print Masters', 'sales@printmasters.com'),
    ('Stationery Plus', 'info@stationeryplus.com'),
    ('Paper World', 'orders@paperworld.com'),
    ('Quality Prints', 'support@qualityprints.com'),
    ('Creative Solutions', 'hello@creativesol.com'),
    ('Supply Chain Pro', 'business@supplychain.com'),
    ('Eco Supplies', 'green@ecosupplies.com'),
    ('Global Stationers', 'info@globalstat.com'),
    ('Local Print Shop', 'shop@localprint.com');

-- Insert products
INSERT INTO products (product_name) VALUES
    ('notebooks'),
    ('stickers'),
    ('business cards');

-- Create supplier-product relationships
-- Let's assume some suppliers provide multiple products
INSERT INTO suppliers_products (supplier_id, product_id) VALUES
    (1, 1), -- Office Supply Co provides notebooks
    (1, 2), -- Office Supply Co provides stickers
    (2, 3), -- Print Masters provides business cards
    (3, 1), -- Stationery Plus provides notebooks
    (4, 1), -- Paper World provides notebooks
    (4, 2), -- Paper World provides stickers
    (5, 3), -- Quality Prints provides business cards
    (6, 2), -- Creative Solutions provides stickers
    (6, 3), -- Creative Solutions provides business cards
    (7, 1), -- Supply Chain Pro provides notebooks
    (8, 2), -- Eco Supplies provides stickers
    (9, 3), -- Global Stationers provides business cards
    (10, 1), -- Local Print Shop provides notebooks
    (10, 3)  -- Local Print Shop provides business cards
ON CONFLICT (supplier_id, product_id) DO NOTHING;

-- Insert suppliers_quotes with correlated data
WITH RECURSIVE generate_quotes AS (
    SELECT 
        generate_series(1, 400) as n,
        random() as r1,
        random() as r2,
        random() as r3
)
INSERT INTO suppliers_quotes (
    supplier_id,
    product_id,
    inquiry_id,
    cost_average,
    cost_price,
    number_days,
    distance,
    quote_performance,
    supplier_performance,
    quality_item_performance,
    accepted
)
SELECT 
    sp.supplier_id,
    sp.product_id,
    (floor(random() * 20) + 1)::int as inquiry_id,
    ROUND(CAST(0.4 + (gq.r1 * 0.6) AS DECIMAL(10,2)), 2) as cost_average,
    ROUND(CAST(0.3 + (gq.r1 * 0.6) + (random() * 0.2) AS DECIMAL(10,2)), 2) as cost_price,
    5 + (gq.r1 * 25)::INT as number_days,
    (50 + (gq.r2 * 950))::INT as distance,
    ROUND(CAST((1 - gq.r1 * 0.7 + random() * 0.3) AS DECIMAL(10,2)), 2) as quote_performance,
    ROUND(CAST((1 - gq.r2 * 0.7 + random() * 0.3) AS DECIMAL(10,2)), 2) as supplier_performance,
    ROUND(CAST(
        70 + 
        (1 - gq.r1) * 20 +
        (1 - gq.r2) * 10 +
        gq.r3 * 20 - 15
    AS DECIMAL(10,2)), 2) as quality_item_performance,
    CASE 
        WHEN (70 + (1 - gq.r1) * 20 + (1 - gq.r2) * 10 + gq.r3 * 20 - 15) > 75 THEN true
        ELSE false
    END as accepted
FROM 
    generate_quotes gq
    CROSS JOIN (
        SELECT supplier_id, product_id, 
               row_number() OVER () as rn
        FROM suppliers_products
    ) sp 
WHERE (gq.n - 1) % (SELECT COUNT(*) FROM suppliers_products) = sp.rn - 1
ON CONFLICT (supplier_id, inquiry_id) DO NOTHING;