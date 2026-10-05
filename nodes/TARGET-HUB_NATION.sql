@id("0245e949-0634-4f48-bc17-7c8cc2e15c30")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY HK_NATION HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_NATION"                      AS "HK_NATION"     @id("b13305") @not_null,
    "S"."N_NATIONKEY"                    AS "N_NATIONKEY"   @id("f46a10") @not_null,
    "S"."RECORD_SOURCE"                  AS "RECORD_SOURCE" @id("4bd1c8"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_DTS"      @id("fd9948") @isSystemCreateDate
FROM {{ ref('TARGET', 'STG_DV_NATION') }} "S"
