@id("d5a70000-0000-4000-8000-000000000111")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d11001") @isBusinessKey,
     CAST("name" AS VARCHAR(25)) AS "NATION_NAME" @id("d11002"),
     "REGIONKEY" AS "REGION_KEY" @id("d11003"),
     "CommenT" AS "NATION_COMMENT" @id("d11004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d11008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d11009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
