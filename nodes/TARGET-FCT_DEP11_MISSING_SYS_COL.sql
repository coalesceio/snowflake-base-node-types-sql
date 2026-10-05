@id("00439ef0-1345-4826-ae2d-35ffe88a2fbe")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d1101") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d1102"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d1103"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d1104"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d1105"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d1106"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d1107") @isSystemCreateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
