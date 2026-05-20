@id("d40530ad-2068-42da-aa6b-a53e95acca17")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

WITH recent_orders AS (
    SELECT
        O_ORDERKEY AS order_key,
        O_CUSTKEY AS customer_key,
        O_TOTALPRICE AS order_total,
        O_ORDERDATE AS order_date
    FROM {{ ref('SRC', 'ORDERS') }} o
    WHERE o.O_ORDERDATE >= DATEADD('month', -3, CURRENT_DATE)
),

order_summary AS (
    SELECT
        customer_key,
        COUNT(*) AS order_count,
        SUM(order_total) AS total_spend,
        MAX(order_date) AS last_order_date
    FROM recent_orders
    GROUP BY customer_key
)

SELECT
    customer_key,
    order_count,
    total_spend,
    last_order_date,
    total_spend / order_count AS avg_order_value
FROM order_summary