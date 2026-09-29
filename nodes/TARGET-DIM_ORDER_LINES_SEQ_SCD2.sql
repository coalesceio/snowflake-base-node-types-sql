@id("6c755615-6837-4273-b4a1-21dcddffb941")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 2 order line dimension built on WRK_ORDER_LINES; keyed by ANANDHIS_DEV.TARGET.ORDER_SEQ instead of the built-in identity surrogate key. A change to status, quantity, net price or ship date expires the current version and inserts a new one with a new sequence key")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY O_ORDERKEY, L_LINENUMBER HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_LINE_SEQ_KEY HAVING COUNT(*) > 1")
WITH "ORDER_LINES_LATEST" AS (
    SELECT "O_ORDERKEY", "L_LINENUMBER", "O_CUSTKEY", "O_ORDERDATE", "O_ORDERSTATUS",
           "L_PARTKEY", "L_SUPPKEY", "L_QUANTITY", "L_NET_PRICE", "L_SHIPDATE"
    FROM {{ ref('TARGET', 'WRK_ORDER_LINES') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "O_ORDERKEY", "L_LINENUMBER" ORDER BY "LOAD_TS" DESC) = 1
),
"CURRENT_KEYS" AS (
    -- Sequence key and tracked values of each order line's current version, so an unchanged
    -- version keeps its key and only a new order line or a new version draws from the sequence
    SELECT "O_ORDERKEY", "L_LINENUMBER", "ORDER_LINE_SEQ_KEY",
           "O_ORDERSTATUS", "L_QUANTITY", "L_NET_PRICE", "L_SHIPDATE"
    FROM ANANDHIS_DEV.TARGET.DIM_ORDER_LINES_SEQ_SCD2
    WHERE "SYSTEM_CURRENT_FLAG" = 'Y'
)
SELECT
    CAST(CASE
        WHEN "CURRENT_KEYS"."ORDER_LINE_SEQ_KEY" IS NOT NULL
         AND EQUAL_NULL(CAST("ORDER_LINES_LATEST"."O_ORDERSTATUS" AS VARCHAR(1)), "CURRENT_KEYS"."O_ORDERSTATUS")
         AND EQUAL_NULL(CAST("ORDER_LINES_LATEST"."L_QUANTITY" AS NUMBER(12,2)), "CURRENT_KEYS"."L_QUANTITY")
         AND EQUAL_NULL(CAST("ORDER_LINES_LATEST"."L_NET_PRICE" AS NUMBER(18,4)), "CURRENT_KEYS"."L_NET_PRICE")
         AND EQUAL_NULL(CAST("ORDER_LINES_LATEST"."L_SHIPDATE" AS DATE), "CURRENT_KEYS"."L_SHIPDATE")
        THEN "CURRENT_KEYS"."ORDER_LINE_SEQ_KEY"
        ELSE ANANDHIS_DEV.TARGET.ORDER_SEQ.NEXTVAL
    END AS NUMBER(38,0))                                      AS "ORDER_LINE_SEQ_KEY"  @id("96662e") @not_null @description("Sequence-generated key of the order line version (ANANDHIS_DEV.TARGET.ORDER_SEQ); a new value per new version"),
    CAST("ORDER_LINES_LATEST"."O_ORDERKEY" AS NUMBER(38,0))   AS "O_ORDERKEY"          @id("b9f675") @isBusinessKey @not_null @description("Order key (business key, part 1)"),
    CAST("ORDER_LINES_LATEST"."L_LINENUMBER" AS NUMBER(38,0)) AS "L_LINENUMBER"        @id("69b766") @isBusinessKey @not_null @description("Line number within the order (business key, part 2)"),
    CAST("ORDER_LINES_LATEST"."O_CUSTKEY" AS NUMBER(38,0))    AS "O_CUSTKEY"           @id("1e8c57") @description("Customer key (FK to CUSTOMER)"),
    CAST("ORDER_LINES_LATEST"."O_ORDERDATE" AS DATE)          AS "O_ORDERDATE"         @id("39d23f") @description("Date the order was placed"),
    CAST("ORDER_LINES_LATEST"."O_ORDERSTATUS" AS VARCHAR(1))  AS "O_ORDERSTATUS"       @id("bd055a") @isChangeTracking @description("Order status (O = open, F = fulfilled, P = partial); a change creates a new version"),
    CAST("ORDER_LINES_LATEST"."L_PARTKEY" AS NUMBER(38,0))    AS "L_PARTKEY"           @id("b8f2e2") @description("Part key (FK to PART)"),
    CAST("ORDER_LINES_LATEST"."L_SUPPKEY" AS NUMBER(38,0))    AS "L_SUPPKEY"           @id("f53a46") @description("Supplier key (FK to SUPPLIER)"),
    CAST("ORDER_LINES_LATEST"."L_QUANTITY" AS NUMBER(12,2))   AS "L_QUANTITY"          @id("634fcd") @isChangeTracking @description("Quantity ordered; a change creates a new version"),
    CAST("ORDER_LINES_LATEST"."L_NET_PRICE" AS NUMBER(18,4))  AS "L_NET_PRICE"         @id("2d091c") @isChangeTracking @description("Extended price after discount; a change creates a new version"),
    CAST("ORDER_LINES_LATEST"."L_SHIPDATE" AS DATE)           AS "L_SHIPDATE"          @id("2a361b") @isChangeTracking @description("Date the line was shipped; a change creates a new version"),
    1                                                         AS "SYSTEM_VERSION"      @id("d68bea") @isSystemVersion @description("Version number of the order line, incremented on each tracked change"),
    'Y'                                                       AS "SYSTEM_CURRENT_FLAG" @id("6e805a") @isSystemCurrentFlag @description("Y on the current version of the order line, N on expired versions"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                      AS "SYSTEM_CREATE_DATE"  @id("d42375") @isSystemCreateDate @description("Timestamp when this version was first inserted"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                      AS "SYSTEM_UPDATE_DATE"  @id("75b811") @isSystemUpdateDate @description("Timestamp when this version was last inserted or expired"),
    CAST('2999-12-31 00:00:00' AS TIMESTAMP)                  AS "SYSTEM_END_DATE"     @id("1e3249") @isSystemEndDate @description("End of the validity window of this version; 2999-12-31 while current")
FROM "ORDER_LINES_LATEST"
LEFT JOIN "CURRENT_KEYS"
    ON  "ORDER_LINES_LATEST"."O_ORDERKEY"   = "CURRENT_KEYS"."O_ORDERKEY"
    AND "ORDER_LINES_LATEST"."L_LINENUMBER" = "CURRENT_KEYS"."L_LINENUMBER"
