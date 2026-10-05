@id("32eb6dac-27a9-4a30-9579-d08295d15e4a")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0201") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0202"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0203"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0204"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0205"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0206"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0207") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0208") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
