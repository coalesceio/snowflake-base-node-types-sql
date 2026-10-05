@id("19375406-b6b9-412a-8c15-ba18869cf20e")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0501"),
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0502"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0503"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0504"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0505"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0506"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0507") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0508") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
