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
