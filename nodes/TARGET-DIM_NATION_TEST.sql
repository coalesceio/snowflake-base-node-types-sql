@id("aaf9a4e2-b505-42c1-9257-83ed716a1c25")
@nodeType("663")
@description("Dim Table")
@groupByAll(true)
@orderbycolumn("[object Object]", "desc")
@orderbycolumn("[object Object]", "desc")
@insertZeroKeyStr("KNOWN")
@insertZeroKeyTimestamp("1901-01-01 00:00:00")
@testsEnabled(true)
@preTests("SELECT 1 FROM {{ this }} 
GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@preContinueOnFailure(true)
@lastModifiedColumn("[object Object]")
@type2Dimension(true)
SELECT
     0 AS "DIM_NATION_TEST_KEY",
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY" @nullable(false),
     NATION_TEST."N_NAME" AS "N_NAME" @zeroKey("NA_Name") @defaultValue("NA"),
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY" @description("Region name"),
     NATION_TEST."N_COMMENT" AS "N_COMMENT" @zeroKey("NA"),
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     1 AS "SYSTEM_VERSION",
     'Y' AS "SYSTEM_CURRENT_FLAG",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE",
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"