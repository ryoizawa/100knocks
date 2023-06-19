// 63

SELECT
    product_cd
    ,unit_price
    ,unit_cost
    ,(unit_price - unit_cost) AS unit_profit
FROM product
LIMIT 10

// 64

SELECT
    AVG((unit_price * 1.0 - unit_cost) / unit_price ) AS avg_profit
FROM product

// 65

WITH new_price_tbl AS (
    SELECT
        product_cd
        ,unit_price
        ,unit_cost
        ,TRUNC(unit_cost / 0.7) AS new_price
    FROM product
)
SELECT
    *
    ,(new_price - unit_cost) / new_price AS new_profit_rate
FROM new_price_tbl
LIMIT 10

// 66

WITH new_price_tbl AS(
    SELECT
        product_cd
        ,unit_price
        ,unit_cost
        ,ROUND(unit_cost / 0.7) AS new_price
    FROM product
)
SELECT
    *
    ,(new_price - unit_cost) / new_price AS new_price_rate
FROM new_price_tbl
LIMIT 10

// 67

%%sql
WITH new_price_tbl AS (
    SELECT
        product_cd
        ,unit_price
        ,unit_cost
        ,CEIL(unit_cost / 0.7) AS new_price
    FROM product
)
SELECT
    *
    ,(new_price - unit_cost) / new_price AS new_profit_rate
FROM new_price_tbl
LIMIT 10
