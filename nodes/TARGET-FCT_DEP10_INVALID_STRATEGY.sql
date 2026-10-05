@id("a014fe3e-4523-49ed-9720-224dccd8aa44")
@nodeType("SQLFact")
@mergeStrategy("foo")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d1001") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d1002"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d1003"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d1004"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d1005"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d1006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d1007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d1008") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
