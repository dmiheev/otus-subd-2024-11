-- Описание/Пошаговая инструкция выполнения домашнего задания:

-- Напишите запрос на добавление данных с выводом информации о добавленных строках.
INSERT INTO SHOP.CATEGORIES (ID, NAME) 
VALUES 
  (1, 'Сок'),
  (2, 'Хлеб'),
  (3, 'Молоко'),
  (4, 'Сосиски')
;

INSERT INTO SHOP.MANUFACTURERS (ID, NAME, ADDRESS, PHONE, EMAIL) 
  VALUES (1, 'Мясозовод №1', 'Адрес 1', '+79999999999', 'emailzavoda@yandex.ru')
;

INSERT INTO SHOP.SUPPLIERS (ID, NAME, ADDRESS, PHONE, EMAIL) 
  VALUES (2, 'Поставщик №1', 'Адрес 2', '+79998888888', 'emailpostavshika@yandex.ru')
;
INSERT INTO SHOP.SUPPLIERS (ID, NAME, ADDRESS, PHONE, EMAIL) 
  VALUES (3, 'Поставщик №3', 'Адрес 3', '+79993333333', 'emailpostavshika3@yandex.ru')
;


INSERT INTO SHOP.PRODUCTS (ID, CATEGORY_ID, NAME, DESCRIPTION, MANUFACTURER_ID, SUPPLIER_ID)
  VALUES (1, 4, 'Куриные сосиски', 'Вкусные сосиски', 1, 2)

-- Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
-- Ищем категории имя которых начинается на "С"
SELECT * FROM SHOP.CATEGORIES C
WHERE C.NAME LIKE 'С%'
;


-- Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?
-- Выберем данные по категориям и товарам этих категорий
-- в случае LEFT JOIN будем видеть категории для которых нет товаров
SELECT *
FROM SHOP.CATEGORIES C
LEFT JOIN SHOP.PRODUCTS P ON P.CATEGORY_ID = C.ID 
;
-- в случае INNER JOIN будем видеть только категории для которых есть товары
SELECT *
FROM SHOP.CATEGORIES C
JOIN SHOP.PRODUCTS P ON P.CATEGORY_ID = C.ID
;

-- Напишите запрос с обновлением данные используя UPDATE FROM.
-- Меняем поставщика "Поставщик №1" на поставщика с ИД = 3 ("Поставщик №3")
UPDATE SHOP.PRODUCTS AS p
SET SUPPLIER_ID = 3
FROM (
    SELECT S.ID
    FROM SHOP.SUPPLIERS s
    WHERE S.NAME = 'Поставщик №1'
) AS t
WHERE P.SUPPLIER_ID = T.ID
;
SELECT * FROM SHOP.PRODUCTS P 
;
-- Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
-- Удалим категории с ИД меньше 3
DELETE FROM SHOP.CATEGORIES AS cat
USING (
    SELECT ID
    FROM SHOP.CATEGORIES 
    WHERE ID < 3
) AS t
WHERE t.ID = cat.ID
;
SELECT * FROM SHOP.CATEGORIES C
;

-- Задание со *:
-- Приведите пример использования утилиты COPY
-- Можем заполнить справочник категорий из CSV-файла
COPY SHOP.CATEGORIES FROM '/path_to_csv/NEW_CATEGORIES.txt' WITH (FORMAT csv);