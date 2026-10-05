@id("4eecd2a6-3811-461a-8edf-9be7ac070227")
@nodeType("707")
@description("Pipeline: latest row per nation from NATION_TEST, trimmed and standardised")
@writeMode("truncateInsert")
@preSQL("SELECT 'WRK_NATION_CLEAN pre-load'")
@postSQL("SELECT 'WRK_NATION_CLEAN post-load'")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
WITH "NATION_LATEST" AS (
    SELECT *
    FROM {{ ref('SRC', 'NATION_TEST') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "N_NATIONKEY" ORDER BY "N_LOAD_TIMESTAMP" DESC NULLS LAST) = 1
)
SELECT
    "N"."N_NATIONKEY"                          AS "N_NATIONKEY"      @id("1a0001") @not_null @uniqueness @min_max(0, 24) @inHash("GH_NATION", 1),
    UPPER(TRIM("N"."N_NAME"))                  AS "N_NAME"           @id("1a0002") @not_null @empty @rejected_values("'UNKNOWN'") @inHash("GH_NATION", 2),
    "N"."N_REGIONKEY"                          AS "N_REGIONKEY"      @id("1a0003") @not_null @accepted_values("0, 1, 2, 3, 4") @inHash("GH_NATION", 3),
    COALESCE(TRIM("N"."N_COMMENT"), 'N/A')     AS "N_COMMENT"        @id("1a0004") @not_null,
    "N"."N_LOAD_TIMESTAMP"                     AS "N_LOAD_TIMESTAMP" @id("1a0005") @not_null,
    "N"."N_DATE"                               AS "N_DATE"           @id("1a0006"),
    {{ get_hash('GH_NATION') }}::STRING        AS "GH_NATION"        @id("1a0007") @not_null
FROM "NATION_LATEST" "N"
