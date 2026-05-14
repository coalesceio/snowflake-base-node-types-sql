@id("f2af1843-308e-4359-90c2-1699e71fb9c3")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

@zeroKey("string:DEFAULT", "number:10", "boolean:True", "datetime:1999-12-31 10:10:10")

SELECT
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION_TEST."N_NAME" AS "N_NAME" @isChangeTracking,
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY",
     NATION_TEST."N_COMMENT" AS "N_COMMENT",
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
     1 AS "SYSTEM_VERSION" @isSystemVersion,
     0 AS "CT_SCD2_KEY" @isSurrogateKey @zeroKey(0),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"