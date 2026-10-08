@id("d5a70000-0000-4000-8000-000000000233")
@nodeType("SQLFact")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f33001") @isBusinessKey,
     UPPER("name") AS "NATION_NAME" @id("f33002"),
     "REGIONKEY" AS "REGION_KEY" @id("f33003"),
     "CommenT" AS "NATION_COMMENT" @id("f33004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f33008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f33009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
