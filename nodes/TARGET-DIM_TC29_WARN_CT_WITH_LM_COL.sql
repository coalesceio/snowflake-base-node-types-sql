@id("4c090e18-122a-4535-a890-7cd1f4e30c68")
@nodeType("718")
@description("TC29 - NEGATIVE: changeTracking with a @lastModifiedTracking column (expect non-blocking warning, column ignored)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC29_WARN_CT_WITH_LM_COL_KEY" @id("8a0614") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("8e246a") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("58d614"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("f4a2ce"),
     "N_COMMENT" AS "N_COMMENT" @id("26dbb0"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("dbee16") @lastModifiedTracking(1),
     "N_DATE" AS "N_DATE" @id("28b8d2"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("ab4ec2") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d75a24") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
