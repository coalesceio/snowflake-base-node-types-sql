@id("d5a70000-0000-4000-8000-000000000218")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f18001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f18002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("f18003") @tag("OWNER", "Data"),
     "CommenT" AS "NATION_COMMENT" @id("f18004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f18008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f18009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
