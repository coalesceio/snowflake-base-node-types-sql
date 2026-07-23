@id("f8e6c6c0-3d40-4576-be65-c2110f376235")
@nodeType("663")
@description("Table''adk")
@insertZeroKey(true)
@insertZeroKeySurrogateKey("10")
@lastModifiedCompToggle(true)
@selectDistinct(true)
@orderby(true)
@orderbycolumn("[object Object]", "desc")
@lastModifiedColumn("[object Object]")
@type2Dimension(true)
WITH ALL_NATIONS AS(
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" ,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" 
FROM {{ ref('SRC', 'NATION_COPY1') }} "NATION_COPY1" 
UNION
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" ,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_COPY2') }} "NATION_COPY2"
) 
SELECT
     0 AS "DIM_NATION_COPY_KEY" @isSurrogateKey,
     ALL_NATIONS."N_NATIONKEY" AS "N_NATIONKEY"  @nullable(false) @isBusinessKey,
     ALL_NATIONS."N_NAME" AS "N_NAME" @defaultValue("NA") @isChangeTracking,
     ALL_NATIONS."N_REGIONKEY" AS "N_REGIONKEY" @description("Column''desc"),
     ALL_NATIONS."N_COMMENT" AS "N_COMMENT",
     ALL_NATIONS."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     1 AS "SYSTEM_VERSION",
     'Y' AS "SYSTEM_CURRENT_FLAG",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE",
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"
FROM ALL_NATIONS
WHERE ALL_NATIONS.N_NATIONKEY = 2