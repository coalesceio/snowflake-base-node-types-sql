@id("42fde756-01be-41b3-bd08-4302426262bd")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")
@lastModifiedCompToggle(true)
@insertZeroKey(true)
@insertZeroKeyStr("NA")
@testsEnabled(true)
@postContinueOnFailure(true)
@groupByAll(true)
SELECT
     "LM_SCD1_KEY"::NUMBER AS "LM_SCD1_KEY",
     NATION_TEST."N_NAME" AS "N_NAME" @zeroKey("NA-chnaged") @isSurrogateKe,
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY" @isLastModifiedColumn,
     NATION_TEST."N_COMMENT" AS "N_COMMENT",
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"  @tests('null'),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"