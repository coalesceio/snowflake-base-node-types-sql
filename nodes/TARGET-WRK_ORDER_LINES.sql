@id("ff11049c-3ee7-44ab-b84b-55fbd05650d5")
@nodeType("SQLWork")
@materializationType("transient table")
@description("Sales star - order lines (lineitem joined to order header) with derived amounts123")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_KEY, LINE_NUMBER HAVING COUNT(*) > 1", false, "After")
SELECT
    "L"."L_ORDERKEY" AS "ORDER_KEY1" @notNull,
    "L"."L_LINENUMBER" AS "LINE_NUMBER" @notNull,
    "O"."O_CUSTKEY" AS "CUSTOMER_KEY" @empty,
    "L"."L_PARTKEY" AS "PART_KEY" @description("partkey"),
    "L"."L_SUPPKEY" AS "SUPPLIER_KEY",
    "O"."O_ORDERSTATUS" AS "ORDER_STATUS",
    "O"."O_ORDERPRIORITY" AS "ORDER_PRIORITY",
    "O"."O_ORDERDATE" AS "ORDER_DATE",
    "L"."L_COMMITDATE" AS "COMMIT_DATE",
    "L"."L_RECEIPTDATE" AS "RECEIPT_DATE" @relative_time(">=", "SHIP_DATE"),
    "L"."L_RETURNFLAG" AS "RETURN_FLAG" @accepted_values("'A', 'N', 'R'"),
    "L"."L_LINESTATUS" AS "LINE_STATUS" @accepted_values("'F', 'O'"),
    "L"."L_QUANTITY" AS "QUANTITY" @min_value("0"),
    "L"."L_EXTENDEDPRICE" AS "EXTENDED_PRICE",
    "L"."L_DISCOUNT" AS "DISCOUNT_PCT" @min_max("0", "1"),
    "L"."L_TAX" AS "TAX_PCT",
    CAST("L"."L_EXTENDEDPRICE" * (1 - "L"."L_DISCOUNT") AS NUMBER(18,2)) AS "NET_AMOUNT",
    CAST("L"."L_EXTENDEDPRICE" * (1 - "L"."L_DISCOUNT") * (1 + "L"."L_TAX") AS NUMBER(18,2)) AS "GROSS_AMOUNT",
    CAST(CASE WHEN "L"."L_RECEIPTDATE" > "L"."L_COMMITDATE" THEN TRUE ELSE FALSE END AS BOOLEAN) AS "IS_LATE",
    "L"."L_LOAD_TIMESTAMP" AS "LOAD_TS"
FROM {{ ref('SRC', 'LINEITEM') }} "L"
INNER JOIN {{ ref('SRC', 'ORDERS') }} "O"
    ON "L"."L_ORDERKEY" = "O"."O_ORDERKEY"
