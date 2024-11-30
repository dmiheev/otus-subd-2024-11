
## **Домашнее задание**

Разработка проекта базы данных интернет магазина для дипломного проекта.

**Цель:**
Спроектировать свою первую базу данных на курсе.

**Описание/Пошаговая инструкция выполнения домашнего задания:**
Реализуйте сущности продукты, категории продуктов, цены, поставщики, производители, покупатели и покупки.  
Свои решения для этой схемы приветствуются.

**В проекте должны быть:**
- схема
- описание таблиц и полей
- примеры бизнес-задач которые решает база

**Критерии оценки:**
* 10 - реализованы сущности и схема  
* плюс 2 балла за очень интересный проект  
* минус 2 балла, если работа выполнена, но имеются недостатки и студент не хочет их устранять

## **Схема**

![[drawSQL-image-export-2024-11-30.png]]


## **Описание таблиц и полей**

* Продукты (`products`)
	* `id` - ID продукта
	* `category_id` - ID категории продукта
	* `name` - Наименование продукта
	* `description` - Описание продукта
	* `manufacturer_id` - ID производителя
	* `supplier_id` - ID поставщика
* Категории продуктов (`categories`)
	* `id` - ID категории
	* `name` - Наименование категории
* Цены (`prices`)
	* `id` - ID цены
	* `product_id` - ID продукта
	* `price` - Цена
	* `start_date` - Дата начала действия цены
	* `end_date` - Дата окончания действия цены
* Поставщики (`suppliers`)
	* `id` - ID поставщика
	* `name` - Наименование поставщика
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
* Производители (`manufacturers`)
	* `id` - ID производителя
	* `name` - Наименование производителя
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
* Покупатели (`customers`)
	* `id` - ID покупателя
	* `name` - Наименование покупателя
	* `address` - Адрес
	* `phone` - Телефон
	* `email` - E-mail
* Покупки (`purchases`)
	* `id` - ID покупки
	* `product_id` - ID продукта
	* `customer_id` - ID продукта
	* `purchase_date` - Дата покупки
	* `price_id` - ID цены
	* `quantity` - Количество


## **Скрипт генерации объектов**

```sql
CREATE TABLE "products"(
    "id" BIGINT NOT NULL,
    "category_id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "manufacturer_id" BIGINT NOT NULL,
    "supplier_id" BIGINT NOT NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "products"."id" IS 'ID продукта';
COMMENT
ON COLUMN
    "products"."category_id" IS 'ID категории продукта';
COMMENT
ON COLUMN
    "products"."name" IS 'Наименование продукта';
COMMENT
ON COLUMN
    "products"."description" IS 'Описание продукта';
COMMENT
ON COLUMN
    "products"."manufacturer_id" IS 'ID производителя';
COMMENT
ON COLUMN
    "products"."supplier_id" IS 'ID поставщика';
CREATE TABLE "categories"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "categories" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "categories"."id" IS 'ID категории';
COMMENT
ON COLUMN
    "categories"."name" IS 'Наименование категории';
CREATE TABLE "manufacturers"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "manufacturers" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "manufacturers"."id" IS 'ID производителя';
COMMENT
ON COLUMN
    "manufacturers"."name" IS 'Наименование производителя';
COMMENT
ON COLUMN
    "manufacturers"."address" IS 'Адрес';
COMMENT
ON COLUMN
    "manufacturers"."phone" IS 'Телефон';
COMMENT
ON COLUMN
    "manufacturers"."email" IS 'E-mail';
CREATE TABLE "suppliers"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "suppliers" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "suppliers"."id" IS 'ID поставщика';
COMMENT
ON COLUMN
    "suppliers"."name" IS 'Наименование поставщика';
COMMENT
ON COLUMN
    "suppliers"."address" IS 'Адрес';
COMMENT
ON COLUMN
    "suppliers"."phone" IS 'Телефон';
COMMENT
ON COLUMN
    "suppliers"."email" IS 'E-mail';
CREATE TABLE "purchases"(
    "id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "customer_id" BIGINT NOT NULL,
    "purchase_date" DATE NOT NULL,
    "price_id" BIGINT NOT NULL,
    "quantity" BIGINT NOT NULL
);
ALTER TABLE
    "purchases" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "purchases"."product_id" IS 'ID продукта';
COMMENT
ON COLUMN
    "purchases"."customer_id" IS 'ID покупателя';
COMMENT
ON COLUMN
    "purchases"."purchase_date" IS 'Дата покупки';
COMMENT
ON COLUMN
    "purchases"."price_id" IS 'ID цены';
COMMENT
ON COLUMN
    "purchases"."quantity" IS 'Количество';
CREATE TABLE "customers"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "customers" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "customers"."id" IS 'ID Покупателя';
COMMENT
ON COLUMN
    "customers"."name" IS 'Наименование покупателя';
COMMENT
ON COLUMN
    "customers"."address" IS 'Адрес';
COMMENT
ON COLUMN
    "customers"."phone" IS 'Телефон';
COMMENT
ON COLUMN
    "customers"."email" IS 'E-Mail';
CREATE TABLE "prices"(
    "id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "price" BIGINT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL
);
ALTER TABLE
    "prices" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "prices"."id" IS 'ID цены';
COMMENT
ON COLUMN
    "prices"."product_id" IS 'ID продукта';
COMMENT
ON COLUMN
    "prices"."price" IS 'Цена';
COMMENT
ON COLUMN
    "prices"."start_date" IS 'Дата начала действия цены';
COMMENT
ON COLUMN
    "prices"."end_date" IS 'Дата окончания действия цены';
ALTER TABLE
    "purchases" ADD CONSTRAINT "purchases_price_id_foreign" FOREIGN KEY("price_id") REFERENCES "prices"("id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_supplier_id_foreign" FOREIGN KEY("supplier_id") REFERENCES "suppliers"("id");
ALTER TABLE
    "purchases" ADD CONSTRAINT "purchases_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "purchases" ADD CONSTRAINT "purchases_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "categories"("id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_manufacturer_id_foreign" FOREIGN KEY("manufacturer_id") REFERENCES "manufacturers"("id");
ALTER TABLE
    "prices" ADD CONSTRAINT "prices_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
```

