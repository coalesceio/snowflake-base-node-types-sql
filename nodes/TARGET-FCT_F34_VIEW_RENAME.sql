@id("d5a70000-0000-4000-8000-000000000234")
@nodeType("SQLFact")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f34001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f34002"),
     "REGIONKEY" AS "REGION_KEY" @id("f34003"),
     "CommenT" AS "NATION_COMMENT" @id("f34004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f34008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f34009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
