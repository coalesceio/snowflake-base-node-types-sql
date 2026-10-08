@id("d5a70000-0000-4000-8000-000000000223")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f23001") @isBusinessKey,
     CAST("name" AS VARCHAR(25)) AS "NATION_NAME" @id("f23002"),
     "REGIONKEY" AS "REGION_KEY" @id("f23003"),
     "CommenT" AS "NATION_COMMENT" @id("f23004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f23008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f23009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
