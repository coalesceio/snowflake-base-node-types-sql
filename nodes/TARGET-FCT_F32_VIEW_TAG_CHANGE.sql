@id("d5a70000-0000-4000-8000-000000000232")
@nodeType("SQLFact")
@materializationType("view")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f32001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f32002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("f32003"),
     "CommenT" AS "NATION_COMMENT" @id("f32004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f32008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f32009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
