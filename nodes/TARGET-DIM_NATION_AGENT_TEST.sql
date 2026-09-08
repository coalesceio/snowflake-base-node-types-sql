@id("f1a2b3c4-5d6e-4a7b-8c9d-0e1f2a3b4c5d")
@nodeType("710")
SELECT
     0 AS "DIM_NATION_AGENT_TEST_KEY" @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     "N_NAME" AS "N_NAME" @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @isChangeTracking,
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     1 AS "SYSTEM_VERSION" @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
