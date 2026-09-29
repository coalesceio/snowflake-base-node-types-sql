@id("0693eec4-d270-41db-bdd1-a2e3749fbdc3")
@nodeType("718")
@description("TC32 - NEGATIVE: @zeroKey without an @isSurrogateKey column (expect Missing Required System Columns)")
@mergeStrategy("changeTracking")
@zeroKey("-1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @id("30220a") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("feda12"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("2aa58e"),
     "N_COMMENT" AS "N_COMMENT" @id("ebf490"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("763f12"),
     "N_DATE" AS "N_DATE" @id("ce3d52"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("6cade2") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("ca1977") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
