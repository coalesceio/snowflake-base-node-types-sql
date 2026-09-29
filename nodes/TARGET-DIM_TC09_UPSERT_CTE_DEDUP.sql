@id("e23799b4-7a9d-49f4-9a24-5287b6225dda")
@nodeType("718")
@description("TC09 - upsert over a de-duplicating CTE; SYSTEM_UPDATE_DATE is a custom expression written as-is")
@mergeStrategy("upsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
WITH "NATION_LATEST" AS (
    SELECT *
    FROM {{ ref('SRC', 'NATION_TEST') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "N_NATIONKEY" ORDER BY "N_LOAD_TIMESTAMP" DESC NULLS LAST) = 1
)
SELECT
     0 AS "DIM_TC09_UPSERT_CTE_DEDUP_KEY" @id("a45bce") @isSurrogateKey,
     "NL"."N_NATIONKEY" AS "N_NATIONKEY" @id("8a22e2") @isBusinessKey @not_null @uniqueness,
     "NL"."N_NAME" AS "N_NAME" @id("73c055") @not_null,
     "NL"."N_REGIONKEY" AS "N_REGIONKEY" @id("361b91") @min_max(0, 4),
     "NL"."N_COMMENT" AS "N_COMMENT" @id("a81a57"),
     "NL"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("9ba50b"),
     "NL"."N_DATE" AS "N_DATE" @id("06861e"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("a2531a") @isSystemCreateDate,
     CAST("NL"."N_LOAD_TIMESTAMP" AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0b5c66") @isSystemUpdateDate
FROM "NATION_LATEST" "NL"
