@id("1e68b424-944c-4e38-b897-33224b9113bd")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0901") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0902"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0903"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0904"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0905"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0906"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0907") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0908") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
