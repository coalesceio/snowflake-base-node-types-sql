@id("d5a70000-0000-4000-8000-000000000116")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_ID" @id("d16001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d16002"),
     "CommenT" AS "NATION_COMMENT" @id("d16004"),
     SUBSTR("name", 1, 2) AS "NAME_PREFIX" @id("d1600a") @clusterKey(3),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d16008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d16009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
