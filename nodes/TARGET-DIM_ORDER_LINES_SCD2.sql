@id("444b1f8c-e7c9-4337-a28d-46016a38e35c")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 2 order line dimension built on WRK_ORDER_LINES; a change to status, quantity, net price or ship date expires the current version and inserts a new one")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY O_ORDERKEY, L_LINENUMBER HAVING COUNT(*) > 1")
WITH "ORDER_LINES_LATEST" AS (
    SELECT "O_ORDERKEY", "L_LINENUMBER", "O_CUSTKEY", "O_ORDERDATE", "O_ORDERSTATUS",
           "L_PARTKEY", "L_SUPPKEY", "L_QUANTITY", "L_NET_PRICE", "L_SHIPDATE"
    FROM {{ ref('TARGET', 'WRK_ORDER_LINES') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "O_ORDERKEY", "L_LINENUMBER" ORDER BY "LOAD_TS" DESC) = 1
)
SELECT
    0                                        AS "DIM_ORDER_LINES_SCD2_KEY" @id("5cd962") @isSurrogateKey @description("Surrogate key of the order line version"),
    "ORDER_LINES_LATEST"."O_ORDERKEY"        AS "O_ORDERKEY"               @id("442ee2") @isBusinessKey @not_null @description("Order key (business key, part 1)"),
    "ORDER_LINES_LATEST"."L_LINENUMBER"      AS "L_LINENUMBER"             @id("1887f0") @isBusinessKey @not_null @description("Line number within the order (business key, part 2)"),
    "ORDER_LINES_LATEST"."O_CUSTKEY"         AS "O_CUSTKEY"                @id("3d0119") @description("Customer key (FK to CUSTOMER)"),
    "ORDER_LINES_LATEST"."O_ORDERDATE"       AS "O_ORDERDATE"              @id("8a3908") @description("Date the order was placed"),
    "ORDER_LINES_LATEST"."O_ORDERSTATUS"     AS "O_ORDERSTATUS"            @id("93f8ad") @isChangeTracking @accepted_values("'O', 'F', 'P'") @description("Order status (O = open, F = fulfilled, P = partial); a change creates a new version"),
    "ORDER_LINES_LATEST"."L_PARTKEY"         AS "L_PARTKEY"                @id("b02e47") @description("Part key (FK to PART)"),
    "ORDER_LINES_LATEST"."L_SUPPKEY"         AS "L_SUPPKEY"                @id("b016bd") @description("Supplier key (FK to SUPPLIER)"),
    "ORDER_LINES_LATEST"."L_QUANTITY"        AS "L_QUANTITY"               @id("86160c") @isChangeTracking @description("Quantity ordered; a change creates a new version"),
    "ORDER_LINES_LATEST"."L_NET_PRICE"       AS "L_NET_PRICE"              @id("d020fc") @isChangeTracking @min_value("0") @description("Extended price after discount; a change creates a new version"),
    "ORDER_LINES_LATEST"."L_SHIPDATE"        AS "L_SHIPDATE"               @id("ad1506") @isChangeTracking @description("Date the line was shipped; a change creates a new version"),
    1                                        AS "SYSTEM_VERSION"           @id("26f9ca") @isSystemVersion @description("Version number of the order line, incremented on each tracked change"),
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"      @id("9cb6c6") @isSystemCurrentFlag @description("Y on the current version of the order line, N on expired versions"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"       @id("b7955e") @isSystemCreateDate @description("Timestamp when this version was first inserted"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"       @id("bd7eb4") @isSystemUpdateDate @description("Timestamp when this version was last inserted or expired"),
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"          @id("3632bf") @isSystemEndDate @description("End of the validity window of this version; 2999-12-31 while current")
FROM "ORDER_LINES_LATEST"
