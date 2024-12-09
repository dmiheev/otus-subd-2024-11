## **Домашнее задание**

**Добавляем в модель данных дополнительные индексы и ограничения**

Описание/Пошаговая инструкция выполнения домашнего задания:

1. Проводим анализ возможных запросов\отчетов\поиска данных.
2. Предполагаем возможную кардинальность поля.
3. Создаем дополнительные индексы - простые или композитные.
4. На каждый индекс пишем краткое описание зачем он нужен (почему по этому полю\полям).
5. Думаем какие логические ограничения в БД нужно добавить - например какие поля должны быть уникальны, в какие нужно добавить условия, чтобы не нарушить бизнес логику. Пример - нельзя провести операцию по переводу средств на отрицательную сумму.
6. Создаем ограничения по выбранным полям.

**Критерии оценки:**
* 10 - реализованы сущности и схема  
* плюс 2 балла за очень интересный проект  
* минус 2 балла, если работа выполнена, но имеются недостатки и студент не хочет их устранять

## **Описание таблиц и полей**

* Продукты (`products`)
	* `id` - ID продукта
	* `category_id` - ID категории продукта
	* `name` - Наименование продукта
	* `description` - Описание продукта
	* `manufacturer_id` - ID производителя
	* `supplier_id` - ID поставщика
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_products_id` - первичный ключ на столбец `ID`
	+ `FK_products_supplier_id` - внешний ключ на `supplier_id`
	+ `FK_products_category_id` - внешний ключ на `category_id`
	+ `FK_products_manufacturer_id` - внешний ключ на `manufacturer_id`
	+ `IDX_products_name` - индекс на `name`
	+ `IDX_products_category_id_name` - индекс на `category_id`, `name`
	+ `IDX_products_supplier_id_name` - индекс на `supplier_id`, `name`
	+ `IDX_products_manufacturer_id_name` - индекс на `manufacturer_id`, `name`
	+ `IDX_products_supplier_id_manufacturer_id_category_id` - индекс на `supplier_id`, `manufacturer_id`, `category_id`
	+ `IDX_products_supplier_id_manufacturer_id_name` - индекс на `supplier_id`, `manufacturer_id`, `name`
	+ `IDX_products_supplier_id_category_id_name` - индекс на `supplier_id`, `category_id`, `name`


* Категории продуктов (`categories`)
	* `id` - ID категории
	* `name` - Наименование категории
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_categories_id` - первичный ключ на столбец `ID`
	+ `IDX_categories_name` - индекс на `name`


* Цены (`prices`)
	* `id` - ID цены
	* `product_id` - ID продукта
	* `price` - Цена
	* `start_date` - Дата начала действия цены
	* `end_date` - Дата окончания действия цены
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_prices_id` - первичный ключ на столбец `ID`
	+ `FK_prices_product_id` - внешний ключ на `product_id`
	+ `IDX_prices_product_id_start_date_end_date` - индекс на `product_id`, `start_date`, `end_date`
	+ `IDX_prices_price` - индекс на `price`
	+ `IDX_prices_start_date` - индекс на `start_date`
	+ `IDX_prices_end_date` - индекс на `end_date`
	
	**Проверки:**
	+ `price` - стоимость должна быть положительным значением (`price < 0`)
	+ `start_date`, `end_date` - дата начала должна быть меньше даты окончания (`start_date < end_date`)


* Поставщики (`suppliers`)
	* `id` - ID поставщика
	* `name` - Наименование поставщика
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_suppliers_id` - первичный ключ на столбец `ID`
	+ `IDX_suppliers_name` - индекс на `name`
	+ `IDX_suppliers_address` - индекс на `address`
	+ `IDX_suppliers_phone` - индекс на `phone`
	+ `IDX_suppliers_email` - индекс на `email`


* Производители (`manufacturers`)
	* `id` - ID производителя
	* `name` - Наименование производителя
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_manufacturers_id` - первичный ключ на столбец `ID`
	+ `IDX_manufacturers_name` - индекс на `name`
	+ `IDX_manufacturers_address` - индекс на `address`
	+ `IDX_manufacturers_phone` - индекс на `phone`
	+ `IDX_manufacturers_email` - индекс на `email`


* Покупатели (`customers`)
	* `id` - ID покупателя
	* `name` - Наименование покупателя
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_customers_id` - первичный ключ на столбец `ID`
	+ `IDX_customers_name` - индекс на `name`
	+ `IDX_customers_address` - индекс на `address`
	+ `IDX_customers_phone` - индекс на `phone`
	+ `IDX_customers_email` - индекс на `email`


* Покупки (`purchases`)
	* `id` - ID покупки
	* `product_id` - ID продукта
	* `customer_id` - ID продукта
	* `purchase_date` - Дата покупки
	* `price_id` - ID цены
	* `quantity` - Количество
	
	**Индексы для ускорения выполнения запросов и фильтра информации:**
	+ `PK_purchases_id` - первичный ключ на столбец `ID`
	+ `FK_purchases_price_id` - внешний ключ на `price_id`
	+ `FK_purchases_product_id` - внешний ключ на `product_id`
	+ `FK_purchases_customer_id` - внешний ключ на `customer_id`
	+ `IDX_purchases_customer_id_purchase_date` - индекс на `customer_id`, `purchase_date`
	+ `IDX_purchases_product_id` - индекс на `product_id`
	+ `IDX_purchases_price_id` - индекс на `price_id`
	+ `IDX_purchases_purchase_date` - индекс на `purchase_date`


## **Скрипт генерации объектов**

```sql
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products(
    id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    manufacturer_id BIGINT NOT NULL,
    supplier_id BIGINT NOT NULL,
    CONSTRAINT PK_products_id PRIMARY KEY (id)
);
COMMENT ON COLUMN products.id IS 'ID продукта';
COMMENT ON COLUMN products.category_id IS 'ID категории продукта';
COMMENT ON COLUMN products.name IS 'Наименование продукта';
COMMENT ON COLUMN products.description IS 'Описание продукта';
COMMENT ON COLUMN products.manufacturer_id IS 'ID производителя';
COMMENT ON COLUMN products.supplier_id IS 'ID поставщика';

CREATE INDEX IDX_products_name ON products(name);
CREATE INDEX IDX_products_category_id_name ON products(category_id,name);
CREATE INDEX IDX_products_supplier_id_name ON products(supplier_id,name);
CREATE INDEX IDX_products_manufacturer_id_name ON products(manufacturer_id,name);
CREATE INDEX IDX_products_supplier_id_manufacturer_id_category_id ON products(supplier_id,manufacturer_id,category_id);
CREATE INDEX IDX_products_supplier_id_manufacturer_id_name ON products(supplier_id,manufacturer_id,name);
CREATE INDEX IDX_products_supplier_id_category_id_name ON products(supplier_id,category_id,name);


DROP TABLE IF EXISTS categories CASCADE;
CREATE TABLE categories(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT PK_categories_id PRIMARY KEY (id)
);
COMMENT ON COLUMN categories.id IS 'ID категории';
COMMENT ON COLUMN categories.name IS 'Наименование категории';

CREATE INDEX IDX_categories_name ON categories(name);


DROP TABLE IF EXISTS manufacturers CASCADE;
CREATE TABLE manufacturers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_manufacturers_id PRIMARY KEY (id)
);
COMMENT ON COLUMN manufacturers.id IS 'ID производителя';
COMMENT ON COLUMN manufacturers.name IS 'Наименование производителя';
COMMENT ON COLUMN manufacturers.address IS 'Адрес';
COMMENT ON COLUMN manufacturers.phone IS 'Телефон';
COMMENT ON COLUMN manufacturers.email IS 'E-mail';

CREATE INDEX IDX_manufacturers_name ON manufacturers(name);
CREATE INDEX IDX_manufacturers_address ON manufacturers(address);
CREATE INDEX IDX_manufacturers_phone ON manufacturers(phone);
CREATE INDEX IDX_manufacturers_email ON manufacturers(email);


DROP TABLE IF EXISTS suppliers CASCADE;
CREATE TABLE suppliers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_suppliers_id PRIMARY KEY (id)
);
COMMENT ON COLUMN suppliers.id IS 'ID поставщика';
COMMENT ON COLUMN suppliers.name IS 'Наименование поставщика';
COMMENT ON COLUMN suppliers.address IS 'Адрес';
COMMENT ON COLUMN suppliers.phone IS 'Телефон';
COMMENT ON COLUMN suppliers.email IS 'E-mail';

CREATE INDEX IDX_suppliers_name ON suppliers(name);
CREATE INDEX IDX_suppliers_address ON suppliers(address);
CREATE INDEX IDX_suppliers_phone ON suppliers(phone);
CREATE INDEX IDX_suppliers_email ON suppliers(email);


DROP TABLE IF EXISTS purchases CASCADE;
CREATE TABLE purchases(
    id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    purchase_date DATE NOT NULL,
    price_id BIGINT NOT NULL,
    quantity BIGINT NOT NULL CHECK (quantity > 0),
    CONSTRAINT PK_purchases_id PRIMARY KEY (id)
);
COMMENT ON COLUMN purchases.product_id IS 'ID продукта';
COMMENT ON COLUMN purchases.customer_id IS 'ID покупателя';
COMMENT ON COLUMN purchases.purchase_date IS 'Дата покупки';
COMMENT ON COLUMN purchases.price_id IS 'ID цены';
COMMENT ON COLUMN purchases.quantity IS 'Количество';

CREATE INDEX IDX_purchases_customer_id_purchase_date ON purchases(customer_id,purchase_date,product_id);
CREATE INDEX IDX_purchases_product_id ON purchases(product_id);
CREATE INDEX IDX_purchases_price_id ON purchases(price_id);
CREATE INDEX IDX_purchases_purchase_date ON purchases(purchase_date);


DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers(
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PK_customers_id PRIMARY KEY (id)
);
COMMENT ON COLUMN customers.id IS 'ID Покупателя';
COMMENT ON COLUMN customers.name IS 'Наименование покупателя';
COMMENT ON COLUMN customers.address IS 'Адрес';
COMMENT ON COLUMN customers.phone IS 'Телефон';
COMMENT ON COLUMN customers.email IS 'E-Mail';

CREATE INDEX IDX_customers_name ON customers(name);
CREATE INDEX IDX_customers_address ON customers(address);
CREATE INDEX IDX_customers_phone ON customers(phone);
CREATE INDEX IDX_customers_email ON customers(email);


DROP TABLE IF EXISTS prices CASCADE;
CREATE TABLE prices(
    id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    price BIGINT NOT NULL CHECK (price > 0),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (start_date < end_date),
    CONSTRAINT PK_prices_id PRIMARY KEY (id)
);
COMMENT ON COLUMN prices.id IS 'ID цены';
COMMENT ON COLUMN prices.product_id IS 'ID продукта';
COMMENT ON COLUMN prices.price IS 'Цена';
COMMENT ON COLUMN prices.start_date IS 'Дата начала действия цены';
COMMENT ON COLUMN prices.end_date IS 'Дата окончания действия цены';

CREATE INDEX IDX_prices_product_id_start_date_end_date ON prices(product_id,start_date,end_date);
CREATE INDEX IDX_prices_price ON prices(price);
CREATE INDEX IDX_prices_start_date ON prices(start_date);
CREATE INDEX IDX_prices_end_date ON prices(end_date);


ALTER TABLE purchases 
    ADD CONSTRAINT FK_purchases_price_id
    FOREIGN KEY(price_id) 
    REFERENCES prices(id);
    
ALTER TABLE purchases
    ADD CONSTRAINT FK_purchases_product_id
    FOREIGN KEY(product_id)
    REFERENCES products(id);

ALTER TABLE purchases
    ADD CONSTRAINT FK_purchases_customer_id
    FOREIGN KEY(customer_id)
    REFERENCES customers(id);

ALTER TABLE products
    ADD CONSTRAINT FK_products_supplier_id
    FOREIGN KEY(supplier_id)
    REFERENCES suppliers(id);

ALTER TABLE products
    ADD CONSTRAINT FK_products_category_id
    FOREIGN KEY(category_id) 
    REFERENCES categories(id);

ALTER TABLE products
    ADD CONSTRAINT FK_products_manufacturer_id
    FOREIGN KEY(manufacturer_id)
    REFERENCES manufacturers(id);

ALTER TABLE prices 
    ADD CONSTRAINT FK_prices_product_id
    FOREIGN KEY(product_id)
    REFERENCES products(id);
```