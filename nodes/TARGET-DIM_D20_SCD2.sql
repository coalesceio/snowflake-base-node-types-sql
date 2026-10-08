@id("d5a70000-0000-4000-8000-000000000120")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" * 100 AS "DIM_SK" @id("d2000b") @isSurrogateKey,
     "NAtionKey" AS "NATION_KEY" @id("d20001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d20002") @isChangeTracking,
     "REGIONKEY" AS "REGION_KEY" @id("d20003") @isChangeTracking,
     "CommenT" AS "NATION_COMMENT" @id("d20004"),
     SUBSTR("name", 1, 3) AS "NAME_CODE" @id("d2000a") @isChangeTracking,
     1 AS "SYSTEM_VERSION" @id("d20005") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("d20006") @isSystemCurrentFlag,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d20007") @isSystemEndDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d20008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d20009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
