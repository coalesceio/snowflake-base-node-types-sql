@id("e5a7c9d1-4f6b-4da5-8e37-5a9c1e3f4b65")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("e50001"),
    "N_NAME"                             AS "N_NAME"             @id("e50002"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("e50002"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("e50004"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("e50005"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("e50006"),
    "N_DATE"                             AS "N_DATE",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e50008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e50009") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
