@id("3cf0373b-e4df-4234-87f3-f16f8074a0fd")
@nodeType("718")
@description("TC16 - zero key on upsert (single node param, so the business key needs its own column override)")
@mergeStrategy("upsert")
@zeroKey("-1")
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_TC16_ZK_UPSERT_KEY = -1 HAVING COUNT(*) <> 1", true, "After")
SELECT
     0 AS "DIM_TC16_ZK_UPSERT_KEY" @id("69b5e9") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("e3a13e") @isBusinessKey @not_null @zeroKey("-1"),
     "N_NAME" AS "N_NAME" @id("14e4ae"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("93bcee"),
     "N_COMMENT" AS "N_COMMENT" @id("aac488"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("2096e6"),
     "N_DATE" AS "N_DATE" @id("cd9191"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("ba7a61") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("121069") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
