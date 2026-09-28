@id("ce9dca4d-123e-4d98-9c12-1676dc898d9e")
@nodeType("707")
@materializationType("view")
@description("View summarising order count and spend per customer, including customers with no orders")
WITH "ORDER_TOTALS" AS (
    SELECT "O_CUSTKEY", COUNT(*) AS "ORDER_COUNT", SUM("O_TOTALPRICE") AS "TOTAL_SPEND", MAX("O_ORDERDATE") AS "LAST_ORDER_DATE"
    FROM {{ ref('SRC', 'ORDERS') }}
    GROUP BY "O_CUSTKEY"
)
SELECT
    "CUSTOMER"."C_CUSTKEY"                                               AS "C_CUSTKEY"       @id("6d1082") @description("Customer key (primary key)"),
    "CUSTOMER"."C_NAME"                                                  AS "C_NAME"          @id("1609f3") @description("Customer name"),
    "CUSTOMER"."C_MKTSEGMENT"                                            AS "C_MKTSEGMENT"    @id("ab9436") @description("Customer market segment"),
    COALESCE("ORDER_TOTALS"."ORDER_COUNT", 0)                            AS "ORDER_COUNT"     @id("ca4481") @description("Number of orders placed by the customer"),
    COALESCE("ORDER_TOTALS"."TOTAL_SPEND", 0)                            AS "TOTAL_SPEND"     @id("5c1bc7") @description("Sum of O_TOTALPRICE across all orders of the customer"),
    "ORDER_TOTALS"."LAST_ORDER_DATE"                                     AS "LAST_ORDER_DATE" @id("5b833b") @description("Date of the most recent order of the customer; NULL when none"),
    CASE WHEN "ORDER_TOTALS"."ORDER_COUNT" IS NULL THEN 'N' ELSE 'Y' END AS "HAS_ORDERS"      @id("a711d6") @description("Y when the customer has placed at least one order")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
LEFT JOIN "ORDER_TOTALS"
    ON "CUSTOMER"."C_CUSTKEY" = "ORDER_TOTALS"."O_CUSTKEY"
