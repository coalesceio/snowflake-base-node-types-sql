@id("d5a70000-0000-4000-8000-000000000131")
@nodeType("SQLDimension")
@materializationType("view")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d31001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d31002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("d31003"),
     "CommenT" AS "NATION_COMMENT" @id("d31004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d31008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d31009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
