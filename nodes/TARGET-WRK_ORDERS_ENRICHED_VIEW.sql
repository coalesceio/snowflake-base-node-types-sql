@id("afb5fb7a-78d8-475c-a3e8-614dd3cb2c07")
@nodeType("707")
@description("Pipeline: orders matched to cleaned customers by name, with a nation key")
@materializationType("view")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_ID HAVING COUNT(*) > 1", false, "After")
WITH "ORDERS_DEDUP" AS (
    SELECT *
    FROM {{ ref('SRC', 'ORDERS_TEST') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "ORDER_ID" ORDER BY "ORDER_ID") = 1
)
SELECT
    "O"."ORDER_ID"                                      AS "ORDER_ID"         @id("1c0001") @not_null @uniqueness @inHash("GH_ORDER", 1),
    UPPER(TRIM("O"."CUSTOMER_NAME"))                    AS "CUSTOMER_NAME"    @id("1c0002") @inHash("GH_ORDER", 2),
    "C"."CUSTOMER_ID"                                   AS "CUSTOMER_ID"      @id("1c0003"),
    COALESCE("C"."NATION_KEY", MOD("O"."ORDER_ID", 25)) AS "NATION_KEY"       @id("1c0004") @not_null @min_max(0, 24),
    "O"."ORDER_DATA"                                    AS "ORDER_DATA"       @id("1c0005"),
    IFF("C"."CUSTOMER_ID" IS NULL, 'N', 'Y')            AS "CUSTOMER_MATCHED" @id("1c0006") @accepted_values("'Y', 'N'"),
    {{ get_hash('GH_ORDER') }}::STRING                  AS "GH_ORDER"         @id("1c0007") @not_null
FROM "ORDERS_DEDUP" "O"
INNER JOIN {{ ref('TARGET', 'WRK_CUSTOMER_CLEAN') }} "C"
    ON UPPER(TRIM("O"."CUSTOMER_NAME")) = "C"."CUSTOMER_NAME"
