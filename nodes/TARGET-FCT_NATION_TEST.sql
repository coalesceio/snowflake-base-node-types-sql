@id("947f0d4e-4d2c-40bc-b335-c6a41642e6e0")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("f6a6c0"),
    "N_NAME"                             AS "N_NAME"             @id("26d03f"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("769bf0"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("40d8c1"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("155f85"),
    "N_DATE"                             AS "N_DATE"             @id("d57b0e"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("49bfc2") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("326521") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"