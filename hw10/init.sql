CREATE DATABASE shop_db;
USE shop_db;

CREATE TABLE IF NOT EXISTS products
(
    id              INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    name            VARCHAR(255)                            NOT NULL,
    description     VARCHAR(1000)                           NOT NULL,
    category_id     INT UNSIGNED                            NOT NULL REFERENCES category (category_id),
    supplier_id     INT UNSIGNED                            NOT NULL REFERENCES supplier (supplier_id),
    manufacturer_id INT UNSIGNED                            NOT NULL REFERENCES manufacturer (manufacturer_id),
    specifications  JSON DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS categories
(
    category_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    name        VARCHAR(255)                            NOT NULL
);

CREATE TABLE IF NOT EXISTS manufacturers
(
    manufacturer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    name            VARCHAR(255)                            NOT NULL,
    address         VARCHAR(255),
    phone           VARCHAR(20),
    email           VARCHAR(32) UNIQUE
);

CREATE TABLE IF NOT EXISTS suppliers
(
    supplier_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    name        VARCHAR(255)                            NOT NULL,
    address     VARCHAR(255),
    phone       VARCHAR(20),
    email       VARCHAR(32) UNIQUE
);

CREATE TABLE purchases
(
    purchase_id   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    product_id    INT UNSIGNED                            NOT NULL REFERENCES product (product_id),
    customer_id   INT UNSIGNED                            NOT NULL REFERENCES customer (customer_id),
    purchase_date DATE                                    NOT NULL,
    price_id      INT UNSIGNED                            NOT NULL REFERENCES price (price_id),
    quantity      INT                                     NOT NULL CHECK (quantity > 0)
);

CREATE TABLE IF NOT EXISTS customers
(
    customer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    name        VARCHAR(255)                            NOT NULL,
    address     VARCHAR(255),
    phone       VARCHAR(20),
    email       VARCHAR(32) UNIQUE
);

CREATE TABLE IF NOT EXISTS prices
(
    price_id   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    product_id INT UNSIGNED                            NOT NULL REFERENCES product (product_id),
    price      numeric CHECK (price > 0),
    start_date DATE                                    NOT NULL,
    end_date   DATE                                    NOT NULL CHECK (start_date < end_date)
);
