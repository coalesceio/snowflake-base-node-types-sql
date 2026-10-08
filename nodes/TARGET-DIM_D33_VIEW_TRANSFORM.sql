@id("d5a70000-0000-4000-8000-000000000133")
@nodeType("SQLDimension")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d33001") @isBusinessKey,
     UPPER("name") AS "NATION_NAME" @id("d33002"),
     "REGIONKEY" AS "REGION_KEY" @id("d33003"),
     "CommenT" AS "NATION_COMMENT" @id("d33004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d33008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d33009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
