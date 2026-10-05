@id("ae2816bc-5a76-40cc-bc8e-3d531217d390")
@nodeType("SQLFact")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d1401"),
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d1402"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d1403"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d1404"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d1405") @lastModifiedTracking,
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d1406"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d1407") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d1408") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
