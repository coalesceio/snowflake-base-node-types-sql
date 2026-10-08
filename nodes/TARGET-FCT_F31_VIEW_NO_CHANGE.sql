@id("d5a70000-0000-4000-8000-000000000231")
@nodeType("SQLFact")
@materializationType("view")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f31001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f31002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("f31003"),
     "CommenT" AS "NATION_COMMENT" @id("f31004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f31008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f31009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
