@id("7c1ea5f8-d6fd-4a68-9e87-a3a81b1c3838")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
WITH "NATION_DUPED" AS (
    SELECT * FROM {{ ref('SRC', 'NATION_TEST') }}
    UNION ALL
    SELECT * FROM {{ ref('SRC', 'NATION_TEST') }}
)
SELECT
    "NATION_DUPED"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d1301") @isBusinessKey,
    "NATION_DUPED"."N_NAME"                      AS "N_NAME"             @id("0d1302"),
    "NATION_DUPED"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d1303"),
    "NATION_DUPED"."N_COMMENT"                   AS "N_COMMENT"          @id("0d1304"),
    "NATION_DUPED"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d1305"),
    "NATION_DUPED"."N_DATE"                      AS "N_DATE"             @id("0d1306"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d1307") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d1308") @isSystemUpdateDate
FROM "NATION_DUPED"
