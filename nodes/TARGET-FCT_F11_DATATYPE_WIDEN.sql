@id("d5a70000-0000-4000-8000-000000000211")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f11001") @isBusinessKey,
     CAST("name" AS VARCHAR(100)) AS "NATION_NAME" @id("f11002"),
     "REGIONKEY" AS "REGION_KEY" @id("f11003"),
     "CommenT" AS "NATION_COMMENT" @id("f11004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f11008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f11009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
