@id("a94e6c32-ca49-4147-9ab0-91a0e6404b3a")
@nodeType("707")
@description("Pipeline: latest row per customer from CUSTOMERS, with a derived nation key")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY CUSTOMER_ID HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE SIGNUP_DATE > CURRENT_DATE()", true, "After")
WITH "CUSTOMER_LATEST" AS (
    SELECT *
    FROM {{ ref('SRC', 'CUSTOMERS') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "CUSTOMER_ID" ORDER BY "CREATED_AT" DESC NULLS LAST) = 1
)
SELECT
    "C"."CUSTOMER_ID"                            AS "CUSTOMER_ID"   @id("1b0001") @not_null @uniqueness @min_value(0) @inHash("GH_CUSTOMER", 1),
    UPPER(TRIM("C"."CUSTOMER_NAME"))             AS "CUSTOMER_NAME" @id("1b0002") @not_null @empty @inHash("GH_CUSTOMER", 2),
    "C"."SIGNUP_DATE"                            AS "SIGNUP_DATE"   @id("1b0003") @inHash("GH_CUSTOMER", 3),
    YEAR("C"."SIGNUP_DATE")                      AS "SIGNUP_YEAR"   @id("1b0004"),
    "C"."CREATED_AT"                             AS "CUSTOMER_CREATED_AT"    @id("1b0005") @not_null,
    MOD("C"."CUSTOMER_ID", 25)                   AS "NATION_KEY"    @id("1b0006") @not_null @min_max(0, 24),
    {{ get_hash('GH_CUSTOMER', 'SH1') }}::STRING AS "GH_CUSTOMER"   @id("1b0007") @not_null
FROM "CUSTOMER_LATEST" "C"
