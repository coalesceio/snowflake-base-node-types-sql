@id("155ff4db-0a36-4bd1-bab0-85e6113c7bf3")
@nodeType("718")
SELECT
    0                                   AS "DIM_NATION_TEST_KEY" @id("9499bd") @isSurrogateKey,
    "N_NATIONKEY"                       AS "N_NATIONKEY"         @id("a6d178") @isBusinessKey,
    "N_NAME"                            AS "N_NAME"               @id("7e06c7") @isChangeTracking,
    "N_REGIONKEY"                       AS "N_REGIONKEY"          @id("05aef1") @isChangeTracking,
    "N_COMMENT"                         AS "N_COMMENT"            @id("c35087") @isChangeTracking,
    "N_LOAD_TIMESTAMP"                  AS "N_LOAD_TIMESTAMP"     @id("3421c2") @lastModifiedTracking(1),
    1                                   AS "SYSTEM_VERSION"       @id("495109") @isSystemVersion,
    'Y'                                 AS "SYSTEM_CURRENT_FLAG"  @id("1ac7dd") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"  @id("be03ab") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"  @id("d2f8a1") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("e91b6c") @isSystemEndDate
FROM {{ ref("SRC", "NATION_TEST") }}
