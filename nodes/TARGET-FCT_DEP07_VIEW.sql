@id("f4fcfef4-0f0e-404d-9772-b7cfea2b5432")
@nodeType("SQLFact")
@materializationType("view")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0701"),
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0702"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0703"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0704"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0705"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0706"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0707") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0708") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
