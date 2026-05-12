@id("7c2f9711-0b52-43fa-b8a3-19b42a1e6e90")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

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
    li.line_number,
    o.customer_key,
    o.order_date,
    o.order_status,
    o.order_priority,
    li.quantity,
    li.extended_price,
    li.discount_percent,
    li.discounted_price
FROM orders_base o
INNER JOIN lineitem_base li
    ON o.order_key = li.order_key