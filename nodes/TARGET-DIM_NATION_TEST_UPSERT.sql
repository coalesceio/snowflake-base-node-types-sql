@id("27a9fbaf-0c41-4e37-9550-985ab4894827")
@nodeType("718")
@description("SQL-authored upsert dimension over NATION_TEST")
@mergeStrategy("upsert")
SELECT
     0 AS "DIM_NATION_TEST_UPSERT_KEY" @id("e789f6") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("e34d4a") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("28db90"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("318bbd"),
     "N_COMMENT" AS "N_COMMENT" @id("7261ec"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("3413f6"),
     "N_DATE" AS "N_DATE" @id("381509"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("261dd6") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("fc8adf") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
