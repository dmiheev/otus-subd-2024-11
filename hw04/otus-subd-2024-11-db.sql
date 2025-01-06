CREATE DATABASE shop_db;

select * from pg_database;

create tablespace primary_ts location '/var/lib/postgresql/prim_ts';
create tablespace secondary_ts location '/var/lib/postgresql/sec_ts';

select * from pg_tablespace;

DROP SCHEMA IF EXISTS shop;
CREATE SCHEMA shop;

DROP TABLE IF EXISTS shop.products CASCADE;
CREATE TABLE shop.products(
    id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    manufacturer_id BIGINT NOT NULL,
    supplier_id BIGINT NOT NULL,
    CONSTRAINT PK_products_id PRIMARY KEY (id)
) TABLESPACE primary_ts;
COMMENT ON COLUMN shop.products.id IS 'ID продукта';
COMMENT ON COLUMN shop.products.category_id IS 'ID категории продукта';
COMMENT ON COLUMN shop.products.name IS 'Наименование продукта';
COMMENT ON COLUMN shop.products.description IS 'Описание продукта';
COMMENT ON COLUMN shop.products.manufacturer_id IS 'ID производителя';
COMMENT ON COLUMN shop.products.supplier_id IS 'ID поставщика';

CREATE INDEX IDX_products_name ON shop.products(name);
CREATE INDEX IDX_products_category_id_name ON shop.products(category_id,name);
CREATE INDEX IDX_products_supplier_id_name ON shop.products(supplier_id,name);
CREATE INDEX IDX_products_manufacturer_id_name ON shop.products(manufacturer_id,name);
CREATE INDEX IDX_products_supplier_id_manufacturer_id_category_id ON shop.products(supplier_id,manufacturer_id,category_id);
CREATE INDEX IDX_products_supplier_id_manufacturer_id_name ON shop.products(supplier_id,manufacturer_id,name);
CREATE INDEX IDX_products_supplier_id_category_id_name ON shop.products(supplier_id,category_id,name);


DROP TABLE IF EXISTS shop.categories CASCADE;
CREATE TABLE shop.categories(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT PK_categories_id PRIMARY KEY (id)
) TABLESPACE secondary_ts;
COMMENT ON COLUMN shop.categories.id IS 'ID категории';
COMMENT ON COLUMN shop.categories.name IS 'Наименование категории';

CREATE INDEX IDX_categories_name ON shop.categories(name);


DROP TABLE IF EXISTS shop.manufacturers CASCADE;
CREATE TABLE shop.manufacturers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_manufacturers_id PRIMARY KEY (id)
) TABLESPACE secondary_ts;
COMMENT ON COLUMN shop.manufacturers.id IS 'ID производителя';
COMMENT ON COLUMN shop.manufacturers.name IS 'Наименование производителя';
COMMENT ON COLUMN shop.manufacturers.address IS 'Адрес';
COMMENT ON COLUMN shop.manufacturers.phone IS 'Телефон';
COMMENT ON COLUMN shop.manufacturers.email IS 'E-mail';

CREATE INDEX IDX_manufacturers_name ON shop.manufacturers(name);
CREATE INDEX IDX_manufacturers_address ON shop.manufacturers(address);
CREATE INDEX IDX_manufacturers_phone ON shop.manufacturers(phone);
CREATE INDEX IDX_manufacturers_email ON shop.manufacturers(email);


DROP TABLE IF EXISTS shop.suppliers CASCADE;
CREATE TABLE shop.suppliers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_suppliers_id PRIMARY KEY (id)
) TABLESPACE secondary_ts;
COMMENT ON COLUMN shop.suppliers.id IS 'ID поставщика';
COMMENT ON COLUMN shop.suppliers.name IS 'Наименование поставщика';
COMMENT ON COLUMN shop.suppliers.address IS 'Адрес';
COMMENT ON COLUMN shop.suppliers.phone IS 'Телефон';
COMMENT ON COLUMN shop.suppliers.email IS 'E-mail';

CREATE INDEX IDX_suppliers_name ON shop.suppliers(name);
CREATE INDEX IDX_suppliers_address ON shop.suppliers(address);
CREATE INDEX IDX_suppliers_phone ON shop.suppliers(phone);
CREATE INDEX IDX_suppliers_email ON shop.suppliers(email);


DROP TABLE IF EXISTS shop.purchases CASCADE;
CREATE TABLE shop.purchases(
    id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    purchase_date DATE NOT NULL,
    price_id BIGINT NOT NULL,
    quantity BIGINT NOT NULL CHECK (quantity > 0),
    CONSTRAINT PK_purchases_id PRIMARY KEY (id)
) TABLESPACE primary_ts;
COMMENT ON COLUMN shop.purchases.product_id IS 'ID продукта';
COMMENT ON COLUMN shop.purchases.customer_id IS 'ID покупателя';
COMMENT ON COLUMN shop.purchases.purchase_date IS 'Дата покупки';
COMMENT ON COLUMN shop.purchases.price_id IS 'ID цены';
COMMENT ON COLUMN shop.purchases.quantity IS 'Количество';

CREATE INDEX IDX_purchases_customer_id_purchase_date ON shop.purchases(customer_id,purchase_date,product_id);
CREATE INDEX IDX_purchases_product_id ON shop.purchases(product_id);
CREATE INDEX IDX_purchases_price_id ON shop.purchases(price_id);
CREATE INDEX IDX_purchases_purchase_date ON shop.purchases(purchase_date);


DROP TABLE IF EXISTS shop.customers CASCADE;
CREATE TABLE shop.customers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_customers_id PRIMARY KEY (id)
) TABLESPACE secondary_ts;
COMMENT ON COLUMN shop.customers.id IS 'ID Покупателя';
COMMENT ON COLUMN shop.customers.name IS 'Наименование покупателя';
COMMENT ON COLUMN shop.customers.address IS 'Адрес';
COMMENT ON COLUMN shop.customers.phone IS 'Телефон';
COMMENT ON COLUMN shop.customers.email IS 'E-Mail';

CREATE INDEX IDX_customers_name ON shop.customers(name);
CREATE INDEX IDX_customers_address ON shop.customers(address);
CREATE INDEX IDX_customers_phone ON shop.customers(phone);
CREATE INDEX IDX_customers_email ON shop.customers(email);


DROP TABLE IF EXISTS shop.prices CASCADE;
CREATE TABLE shop.prices(
    id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    price BIGINT NOT NULL CHECK (price > 0),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (start_date < end_date),
    CONSTRAINT PK_prices_id PRIMARY KEY (id)
) TABLESPACE primary_ts;
COMMENT ON COLUMN shop.prices.id IS 'ID цены';
COMMENT ON COLUMN shop.prices.product_id IS 'ID продукта';
COMMENT ON COLUMN shop.prices.price IS 'Цена';
COMMENT ON COLUMN shop.prices.start_date IS 'Дата начала действия цены';
COMMENT ON COLUMN shop.prices.end_date IS 'Дата окончания действия цены';

CREATE INDEX IDX_prices_product_id_start_date_end_date ON shop.prices(product_id,start_date,end_date);
CREATE INDEX IDX_prices_price ON shop.prices(price);
CREATE INDEX IDX_prices_start_date ON shop.prices(start_date);
CREATE INDEX IDX_prices_end_date ON shop.prices(end_date);


ALTER TABLE shop.purchases 
    ADD CONSTRAINT FK_purchases_price_id
    FOREIGN KEY(price_id) 
    REFERENCES shop.prices(id);
    
ALTER TABLE shop.purchases
    ADD CONSTRAINT FK_purchases_product_id
    FOREIGN KEY(product_id)
    REFERENCES shop.products(id);

ALTER TABLE shop.purchases
    ADD CONSTRAINT FK_purchases_customer_id
    FOREIGN KEY(customer_id)
    REFERENCES shop.customers(id);

ALTER TABLE shop.products
    ADD CONSTRAINT FK_products_supplier_id
    FOREIGN KEY(supplier_id)
    REFERENCES shop.suppliers(id);

ALTER TABLE shop.products
    ADD CONSTRAINT FK_products_category_id
    FOREIGN KEY(category_id) 
    REFERENCES shop.categories(id);

ALTER TABLE shop.products
    ADD CONSTRAINT FK_products_manufacturer_id
    FOREIGN KEY(manufacturer_id)
    REFERENCES shop.manufacturers(id);

ALTER TABLE shop.prices 
    ADD CONSTRAINT FK_prices_product_id
    FOREIGN KEY(product_id)
    REFERENCES shop.products(id);
    

CREATE ROLE readonly WITH PASSWORD '111';
GRANT CONNECT ON DATABASE shop_db TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA shop TO "readonly";
ALTER DEFAULT PRIVILEGES GRANT SELECT ON TABLES TO readonly;

select rolname, rolcanlogin from pg_roles;