@id("359b8737-ed3a-4cc8-a0b8-ea7f8f837190")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 1 order line dimension built on WRK_ORDER_LINES; keyed by ANANDHIS_DEV.TARGET.ORDER_SEQ instead of the built-in identity surrogate key")
@tests("SELECT 1 FROM {{ this }} GROUP BY O_ORDERKEY, L_LINENUMBER HAVING COUNT(*) > 1")
WITH "ORDER_LINES_LATEST" AS (
    SELECT "O_ORDERKEY", "L_LINENUMBER", "O_CUSTKEY", "O_ORDERDATE", "O_ORDERSTATUS",
           "L_PARTKEY", "L_SUPPKEY", "L_QUANTITY", "L_NET_PRICE", "L_SHIPDATE"
    FROM {{ ref('TARGET', 'WRK_ORDER_LINES') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "O_ORDERKEY", "L_LINENUMBER" ORDER BY "LOAD_TS" DESC) = 1
),
"EXISTING_KEYS" AS (
    -- Sequence keys already assigned in this dimension, so existing order lines keep their key
    -- and only new order lines draw a new value from the sequence
    SELECT "O_ORDERKEY", "L_LINENUMBER", "ORDER_LINE_SEQ_KEY"
    FROM ANANDHIS_DEV.TARGET.DIM_ORDER_LINES_SEQ_SCD1
)
SELECT
    CAST(COALESCE("EXISTING_KEYS"."ORDER_LINE_SEQ_KEY", ANANDHIS_DEV.TARGET.ORDER_SEQ.NEXTVAL) AS NUMBER(38,0)) AS "ORDER_LINE_SEQ_KEY" @id("5568b4") @not_null @description("Sequence-generated key of the order line (ANANDHIS_DEV.TARGET.ORDER_SEQ)"),
    CAST("ORDER_LINES_LATEST"."O_ORDERKEY" AS NUMBER(38,0))   AS "O_ORDERKEY"         @id("be1a7e") @isBusinessKey @not_null @description("Order key (business key, part 1)"),
    CAST("ORDER_LINES_LATEST"."L_LINENUMBER" AS NUMBER(38,0)) AS "L_LINENUMBER"       @id("318c01") @isBusinessKey @not_null @description("Line number within the order (business key, part 2)"),
    CAST("ORDER_LINES_LATEST"."O_CUSTKEY" AS NUMBER(38,0))    AS "O_CUSTKEY"          @id("372134") @description("Customer key (FK to CUSTOMER)"),
    CAST("ORDER_LINES_LATEST"."O_ORDERDATE" AS DATE)          AS "O_ORDERDATE"        @id("73a9be") @description("Date the order was placed"),
    CAST("ORDER_LINES_LATEST"."O_ORDERSTATUS" AS VARCHAR(1))  AS "O_ORDERSTATUS"      @id("6f4f67") @description("Order status (O = open, F = fulfilled, P = partial)"),
    CAST("ORDER_LINES_LATEST"."L_PARTKEY" AS NUMBER(38,0))    AS "L_PARTKEY"          @id("cffac9") @description("Part key (FK to PART)"),
    CAST("ORDER_LINES_LATEST"."L_SUPPKEY" AS NUMBER(38,0))    AS "L_SUPPKEY"          @id("b8b421") @description("Supplier key (FK to SUPPLIER)"),
    CAST("ORDER_LINES_LATEST"."L_QUANTITY" AS NUMBER(12,2))   AS "L_QUANTITY"         @id("d7dc61") @description("Quantity ordered"),
    CAST("ORDER_LINES_LATEST"."L_NET_PRICE" AS NUMBER(18,4))  AS "L_NET_PRICE"        @id("fee3ec") @description("Extended price after discount"),
    CAST("ORDER_LINES_LATEST"."L_SHIPDATE" AS DATE)           AS "L_SHIPDATE"         @id("d11294") @description("Date the line was shipped"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                      AS "SYSTEM_CREATE_DATE" @id("28774f") @isSystemCreateDate @description("Timestamp when the order line was first inserted"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                      AS "SYSTEM_UPDATE_DATE" @id("207d17") @isSystemUpdateDate @description("Timestamp when the order line was last inserted or updated")
FROM "ORDER_LINES_LATEST"
LEFT JOIN "EXISTING_KEYS"
    ON  "ORDER_LINES_LATEST"."O_ORDERKEY"   = "EXISTING_KEYS"."O_ORDERKEY"
    AND "ORDER_LINES_LATEST"."L_LINENUMBER" = "EXISTING_KEYS"."L_LINENUMBER"
