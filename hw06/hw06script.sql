-- Таблица Покупок.
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

-- Заполним данными
INSERT INTO shop.purchases (id, product_id, customer_id, purchase_date, price_id, quantity)
VALUES (1, 1, 1, '2025-01-21', 1, 10);
INSERT INTO shop.purchases (id, product_id, customer_id, purchase_date, price_id, quantity)
VALUES (2, 1, 2, '2024-01-22', 1, 20);
INSERT INTO shop.purchases (id, product_id, customer_id, purchase_date, price_id, quantity)
VALUES (3, 1, 3, '2024-01-23', 1, 30);


-- 1. Создать индекс к какой-либо из таблиц вашей БД
-- Запросы к таблице в условии которых будут использоваться данные поля,
-- будут выполнятся быстрее, так как при поиске будет задействован индекс.
CREATE INDEX IDX_purchases_product_id ON shop.purchases(product_id);
CREATE INDEX IDX_purchases_price_id ON shop.purchases(price_id);
CREATE INDEX IDX_purchases_purchase_date ON shop.purchases(purchase_date);


-- 2. Прислать текстом результат команды explain, в которой используется данный индекс
EXPLAIN SELECT * FROM shop.purchases p WHERE p.price_id = 1;

/* План запроса:
 * Seq Scan on purchases p  (cost=0.00..1.04 rows=1 width=44)
 *   Filter: (price_id = 1) 
 */


-- 3. Реализовать индекс для полнотекстового поиска
-- Создадим индекс для поля Name таблицы Products
CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
DROP INDEX IF EXISTS shop.IDX_products_name;
CREATE INDEX IDX_products_name ON shop.products USING GIN (name); -- поиск по названию продукта


-- 4. Реализовать индекс на часть таблицы или индекс на поле с функцией

-- Индекс на первые 20 символов поля Name в таблице Products. 
-- Такой индекс может быть полезен, если мы часто ищем продукты по их названию 
-- и не нуждаемся в индексировании всего поля Name.
CREATE INDEX IDX_products_name20 ON shop.products (name(20)); 

-- 5. Создать индекс на несколько полей
CREATE INDEX IDX_purchases_customer_id_purchase_date ON shop.purchases(customer_id,purchase_date,product_id);

