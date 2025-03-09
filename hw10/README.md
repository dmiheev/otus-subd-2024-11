# Лекция 23. Типы данных в MySQL

## Домашнее задание

Типы данных

Цель:

Подбирать нужные типы данных;  
Определиться с типом ID;  
Изучить тип JSON.

  

Описание/Пошаговая инструкция выполнения домашнего задания:

1. проанализировать типы данных в своем проекте, изменить при необходимости. В README указать что на что поменялось и почему.
2. добавить тип JSON в структуру. Проанализировать какие данные могли бы там хранится. привести примеры SQL для добавления записей и выборки.


```MySQL
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
```

Первичные ключи создаем в беззнаковом формате `INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE`.
Связи между таблицами описываем через `REFERENCES`.


В таблицу `products` добавлено поле `specifications` в формате JSON.

Для демонстрации создадим таблицу без лишних столбцов и добавим в нее данные.

```MySQL
INSERT INTO products (name, specifications)
VALUES ('Абсент Jacques Senaux Blue 0,7 л',
        '{
          "Тип": "Абсент",
          "Литраж": 0.7,
          "Крепость": 80,
          "Страна": "Испания",
          "Производитель": "Teichenne S.A.",
          "Бренд": "Jacques Senaux"
        }');
```

Теперь можно писать выборки по Спецификации
```MySQL
SELECT * FROM products WHERE JSON_EXTRACT(specifications, '$."Тип"') = 'Абсент';
```

