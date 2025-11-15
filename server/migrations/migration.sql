-- migration.sql
password TEXT NOT NULL,
role TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS customer (
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT,
points INTEGER DEFAULT 0
);


CREATE TABLE IF NOT EXISTS product (
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
price NUMERIC NOT NULL,
stock INTEGER NOT NULL DEFAULT 0,
supplier_id TEXT,
promo_price NUMERIC
);


CREATE TABLE IF NOT EXISTS supplier (
id TEXT PRIMARY KEY,
name TEXT,
contact TEXT
);


CREATE TABLE IF NOT EXISTS sale (
id TEXT PRIMARY KEY,
employee_id TEXT,
customer_id TEXT,
date TIMESTAMP WITH TIME ZONE,
total NUMERIC,
FOREIGN KEY (employee_id) REFERENCES employee(id),
FOREIGN KEY (customer_id) REFERENCES customer(id)
);


CREATE TABLE IF NOT EXISTS sale_item (
id SERIAL PRIMARY KEY,
sale_id TEXT,
product_id TEXT,
qty INTEGER,
price NUMERIC,
FOREIGN KEY (sale_id) REFERENCES sale(id),
FOREIGN KEY (product_id) REFERENCES product(id)
);


CREATE TABLE IF NOT EXISTS payment (
id TEXT PRIMARY KEY,
sale_id TEXT,
method TEXT,
amount NUMERIC,
date TIMESTAMP WITH TIME ZONE,
FOREIGN KEY (sale_id) REFERENCES sale(id)
);


CREATE TABLE IF NOT EXISTS promotion (
id TEXT PRIMARY KEY,
product_id TEXT,
discount_rate NUMERIC,
start_date TIMESTAMP WITH TIME ZONE,
end_date TIMESTAMP WITH TIME ZONE,
active BOOLEAN DEFAULT FALSE
);


-- seed an admin user placeholder (replace password blob later or create via API)
INSERT INTO employee(id, username, password, role)
SELECT 'emp_admin','admin', 'REPLACE_ME_WITH_HASHED_PASSWORD', 'manager'
WHERE NOT EXISTS (SELECT 1 FROM employee WHERE username='admin');
