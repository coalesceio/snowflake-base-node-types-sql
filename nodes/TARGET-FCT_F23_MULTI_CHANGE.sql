@id("d5a70000-0000-4000-8000-000000000223")
@nodeType("SQLFact")
@materializationType("table")
@tag("OWNER", "Tanvi")
@description("F23: several changes")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f23001") @isBusinessKey,
     CAST("name" AS VARCHAR(60)) AS "NATION_NAME" @id("f23002"),
     "CommenT" AS "COMMENT_TEXT" @id("f23004"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("f2300a"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f23008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f23009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
