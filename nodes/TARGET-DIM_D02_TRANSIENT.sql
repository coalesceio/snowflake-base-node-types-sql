@id("d5a70000-0000-4000-8000-000000000102")
@nodeType("SQLDimension")
@materializationType("transient table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d02001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d02002"),
     "REGIONKEY" AS "REGION_KEY" @id("d02003"),
     "CommenT" AS "NATION_COMMENT" @id("d02004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d02008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d02009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
