@id("fd989544-ad43-468e-b626-ec911fb765d7")
@nodeType("707")
@description("Line item detail joined to orders and customers, enriched with each customer's average order amount")
WITH CUSTOMER_ORDER_AVG AS (
    SELECT
        "O_CUSTKEY",
        AVG("O_TOTALPRICE") AS "AVG_ORDER_AMOUNT"
    FROM {{ ref('SRC', 'ORDERS') }}
    GROUP BY "O_CUSTKEY"
)
SELECT
     L."L_ORDERKEY" AS "ORDER_KEY",
     L."L_LINENUMBER" AS "LINE_NUMBER",
     L."L_QUANTITY" AS "LINE_QUANTITY",
     L."L_EXTENDEDPRICE" AS "LINE_EXTENDED_PRICE",
     O."O_TOTALPRICE" AS "ORDER_TOTAL_PRICE",
     O."O_ORDERDATE" AS "ORDER_DATE",
     C."C_CUSTKEY" AS "CUSTOMER_KEY",
     C."C_NAME" AS "CUSTOMER_NAME",
     COA."AVG_ORDER_AMOUNT" AS "AVG_ORDER_AMOUNT_PER_CUSTOMER" @description("Average O_TOTALPRICE across all of this customer's orders, computed once per customer (not fanned out by lineitem count) and joined onto every lineitem row")
FROM {{ ref('SRC', 'LINEITEM') }} L
JOIN {{ ref('SRC', 'ORDERS') }} O ON L."L_ORDERKEY" = O."O_ORDERKEY"
JOIN {{ ref('SRC', 'CUSTOMER') }} C ON O."O_CUSTKEY" = C."C_CUSTKEY"
JOIN CUSTOMER_ORDER_AVG COA ON O."O_CUSTKEY" = COA."O_CUSTKEY"
