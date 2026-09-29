@id("fa859b94-85e1-411c-a8cb-b8be612aa4e9")
@nodeType("718")
@description("SQL-authored SCD Type 1 dimension over NATION_TEST")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_NATION_TEST_KEY" @id("158c39") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("6dc84a") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("7c057a"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("21400c"),
     "N_COMMENT" AS "N_COMMENT" @id("89b160"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("696d91"),
     "N_DATE" AS "N_DATE" @id("4286fa"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("324e4b") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("28f802") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
