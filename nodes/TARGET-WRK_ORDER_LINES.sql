@id("7d1ec8fb-2d15-4004-b105-58bb6c78ebad")
@nodeType("707")
@writeMode("append")
@description("Order lines joined to their order header; appended on every run, keeping only the last 30 loads")
@preSQL("DELETE FROM {{ this }} WHERE LOAD_TS < DATEADD(DAY, -30, CURRENT_TIMESTAMP())")
@tests("SELECT 1 FROM {{ this }} WHERE L_SHIPDATE < O_ORDERDATE")
SELECT
    "ORDERS"."O_ORDERKEY"                                        AS "O_ORDERKEY"    @id("642580") @not_null @description("Order key (primary key)"),
    "LINEITEM"."L_LINENUMBER"                                    AS "L_LINENUMBER"  @id("d2bd10") @not_null @description("Line number within the order"),
    "ORDERS"."O_CUSTKEY"                                         AS "O_CUSTKEY"     @id("4ea879") @description("Customer key (FK to CUSTOMER)"),
    "ORDERS"."O_ORDERDATE"                                       AS "O_ORDERDATE"   @id("ef95b4") @description("Date the order was placed"),
    "ORDERS"."O_ORDERSTATUS"                                     AS "O_ORDERSTATUS" @id("2d1fdb") @description("Order status (O = open, F = fulfilled, P = partial)"),
    "LINEITEM"."L_PARTKEY"                                       AS "L_PARTKEY"     @id("c51ea5") @description("Part key (FK to PART)"),
    "LINEITEM"."L_SUPPKEY"                                       AS "L_SUPPKEY"     @id("d8d84c") @description("Supplier key (FK to SUPPLIER)"),
    "LINEITEM"."L_QUANTITY"                                      AS "L_QUANTITY"    @id("03f110") @description("Quantity ordered"),
    "LINEITEM"."L_EXTENDEDPRICE" * (1 - "LINEITEM"."L_DISCOUNT") AS "L_NET_PRICE"   @id("18aa58") @min_value("0") @description("Extended price after discount"),
    "LINEITEM"."L_SHIPDATE"                                      AS "L_SHIPDATE"    @id("7c05b2") @description("Date the line was shipped"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP_LTZ)                     AS "LOAD_TS"       @id("197b6c") @not_null @description("Timestamp when the row was appended")
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
INNER JOIN {{ ref('SRC', 'LINEITEM') }} "LINEITEM"
    ON "ORDERS"."O_ORDERKEY" = "LINEITEM"."L_ORDERKEY"
