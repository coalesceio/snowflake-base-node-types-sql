@id("fa8509bf-4ae9-4590-af7d-a4fbe8ff391f")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

WITH orders_base AS (
    SELECT
        O_ORDERKEY AS order_key,
        O_CUSTKEY AS customer_key,
        O_ORDERSTATUS AS order_status,
        O_TOTALPRICE AS order_total_price,
        O_ORDERDATE AS order_date,
        TRIM(O_ORDERPRIORITY) AS order_priority
    FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
),

lineitem_base AS (
    SELECT
        L_ORDERKEY AS order_key,
        L_LINENUMBER::NUMBER AS line_number,
        L_QUANTITY AS quantity,
        L_EXTENDEDPRICE AS extended_price,
        L_DISCOUNT AS discount_percent,
        L_EXTENDEDPRICE * (1 - L_DISCOUNT) AS discounted_price
    FROM {{ ref('SRC', 'LINEITEM') }} "LINEITEM"
)

SELECT
    o.order_key @isBusinessKey,
    li.line_number @isBusinessKey,
    o.customer_key @isBusinessKey,
    o.order_date,
    o.order_status @isBusinessKey,
    o.order_priority,
    li.quantity @isBusinessKey,
    li.extended_price,
    li.discount_percent,
    li.discounted_price,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM orders_base o
INNER JOIN lineitem_base li
    ON o.order_key = li.order_key