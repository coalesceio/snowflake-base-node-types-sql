@id("d5a70000-0000-4000-8000-000000000210")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f10001") @isBusinessKey,
     "name" AS "COUNTRY_NAME" @id("f10002"),
     "REGIONKEY" AS "REGION_KEY" @id("f10003"),
     "CommenT" AS "NATION_COMMENT" @id("f10004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f10008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
