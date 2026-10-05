@id("d4f6b8c0-3e5a-4c94-9d26-4f8b0d2e3a54")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("d40001"),
    "N_NAME"                             AS "N_NAME"             @id("d40002"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("d40003"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("d40004"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("d40005"),
    "N_DATE"                             AS "N_DATE"             @id("d40006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d40007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d40009") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
