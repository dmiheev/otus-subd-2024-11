-- Домашнее задание
-- Посчитать кол-во очков по всем игрокам за текущий год и за предыдущий.

-- Цель:
-- Использовать функцию LAG и CTE.


-- Описание/Пошаговая инструкция выполнения домашнего задания:
-- Создайте таблицу и наполните ее данными
CREATE TABLE statistic(
player_name VARCHAR(100) NOT NULL,
    player_id INT NOT NULL,
    year_game SMALLINT NOT NULL CHECK (year_game > 0),
    points DECIMAL(12,2) CHECK (points >= 0),
    PRIMARY KEY (player_name,year_game)
);

-- 2) заполнить данными
INSERT INTO
    statistic(player_name, player_id, year_game, points)
VALUES
    ('Mike',1,2018,18),
    ('Jack',2,2018,14),
    ('Jackie',3,2018,30),
    ('Jet',4,2018,30),
    ('Luke',1,2019,16),
    ('Mike',2,2019,14),
    ('Jack',3,2019,15),
    ('Jackie',4,2019,28),
    ('Jet',5,2019,25),
    ('Luke',1,2020,19),
    ('Mike',2,2020,17),
    ('Jack',3,2020,18),
    ('Jackie',4,2020,29),
    ('Jet',5,2020,27);

-- 3) написать запрос суммы очков с группировкой и сортировкой по годам
SELECT s.year_game,
       sum(s.points) sum_points
FROM statistic s
GROUP BY s.year_game
ORDER BY s.year_game;

-- 4) написать cte показывающее тоже самое
WITH sum_stat AS (
  SELECT s.year_game,
         sum(s.points) sum_points
  FROM statistic s
  GROUP BY s.year_game
)
SELECT *
FROM sum_stat
ORDER BY year_game;

-- 5) используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий.
WITH sum_stat AS (
  SELECT s.year_game,
         sum(s.points) sum_points
  FROM statistic s
  GROUP BY s.year_game
)
SELECT year_game,
       sum_points sum_current_year,
       LAG(sum_points, 1) OVER (ORDER BY year_game) AS sum_last_year
FROM sum_stat;


