@id("d5a70000-0000-4000-8000-000000000202")
@nodeType("SQLFact")
@materializationType("transient table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f02001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f02002"),
     "REGIONKEY" AS "REGION_KEY" @id("f02003"),
     "CommenT" AS "NATION_COMMENT" @id("f02004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f02008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f02009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
