@id("26c690bb-23a1-45c3-b7e5-3875599c43df")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

@type2Dimension
@treatNullAsCurrentTimestamp

SELECT
     0 AS "LM_SCD2_KEY" @isSurrogateKey,
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION_TEST."N_NAME" AS "N_NAME",
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY",
     NATION_TEST."N_COMMENT" AS "N_COMMENT",
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn,
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
     1 AS "SYSTEM_VERSION" @isSystemVersion,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"