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

// 68
    
SELECT *
    ,TRUNC(unit_price * 1.1) AS price_with_tax
FROM product
LIMIT 10

// 69

WITH amount_all AS (
    SELECT
        customer_id
        ,SUM(amount) AS sum_all
    FROM receipt
    GROUP BY customer_id
),
amount_07 AS (
    SELECT
        r.customer_id
        ,SUM(r.amount) AS sum_07
    FROM receipt r
    JOIN product p
    ON r.product_cd = p.product_cd
    WHERE
        p.category_major_cd = '07'
    GROUP BY customer_id
)
SELECT
    amount_all.customer_id
    ,sum_all
    ,sum_07
    ,sum_07 * 1.0 / sum_all AS sales_rate
FROM amount_all
JOIN amount_07
ON amount_all.customer_id = amount_07.customer_id
LIMIT 10

// 70

WITH receipt_distinct AS (
    SELECT
        DISTINCT customer_id
        , sales_ymd
    FROM receipt
)
SELECT
    r.customer_id
    ,r.sales_ymd
    ,c.application_date
    ,EXTRACT(DAY FROM (TO_TIMESTAMP(CAST(r.sales_ymd AS VARCHAR), 'YYYYMMDD')
                       - TO_TIMESTAMP(c.application_date, 'YYYYMMDD'))) AS elaped_days
FROM receipt_distinct r
JOIN customer c
ON r.customer_id = c.customer_id
LIMIT 10
