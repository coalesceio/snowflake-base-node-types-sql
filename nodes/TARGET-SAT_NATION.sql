@id("5653c148-a8ea-4146-9389-0017933e1dfb")
@nodeType("718")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY HK_NATION HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_NATION"                          AS "HK_NATION"           @id("50f054") @isBusinessKey @not_null,
    "S"."HASHDIFF_NATION"                    AS "HASHDIFF_NATION"     @id("0b4be9") @isChangeTracking @not_null,
    "S"."N_NAME"                             AS "N_NAME"              @id("b71f26"),
    "S"."N_REGIONKEY"                        AS "N_REGIONKEY"         @id("340bd5"),
    "S"."N_COMMENT"                          AS "N_COMMENT"           @id("5565dc"),
    "S"."RECORD_SOURCE"                      AS "RECORD_SOURCE"       @id("c56f65"),
    1                                        AS "SYSTEM_VERSION"      @id("fa160a") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("ea6a94") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "LOAD_DTS"            @id("6f0fa5") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("077570") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "LOAD_END_DTS"        @id("025330") @isSystemEndDate
FROM {{ ref('TARGET', 'STG_DV_NATION') }} "S"
