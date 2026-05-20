@id("b82d3bb0-1185-4d14-9b7d-b2bf8620fc47")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

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
    customer_key  @isBusinessKey,
    order_count,
    total_spend,
    last_order_date,
    total_spend / order_count AS avg_order_value,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM order_summary