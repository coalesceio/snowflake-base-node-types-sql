@id("198e6f5e-888c-4f8a-841b-35a86cfafbd3")
@nodeType("SQLFact")
@description("Deploy test: add/remove/rename columns, change datatypes and @id, then redeploy")
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0101") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0102"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0103"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0104"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0105"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0106"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0107") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0108") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
