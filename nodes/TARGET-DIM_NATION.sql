@id("81538a12-84e8-451c-b061-4dfb12c14d2c")
@nodeType("718")
@description("Pipeline: nation dimension - changeTracking SCD Type 2 on name/region, with zero key")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'UNKNOWN'")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_NATION_KEY = -1 HAVING COUNT(*) <> 1", true, "After")
SELECT
    0                                        AS "DIM_NATION_KEY"      @id("2a0001") @isSurrogateKey,
    "W"."N_NATIONKEY"                        AS "N_NATIONKEY"         @id("2a0002") @isBusinessKey @zeroKey("-1") @not_null @min_value("-1"),
    "W"."N_NAME"                             AS "N_NAME"              @id("2a0003")  @not_null,
    "W"."N_REGIONKEY"                        AS "N_REGIONKEY"         @id("2a0004")  @zeroKey("-99") @min_max("-1", "4"),
    "W"."N_COMMENT"                          AS "N_COMMENT"           @id("2a0005") @isChangeTracking,
    "W"."N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"    @id("2a0006"),
    "W"."GH_NATION"                          AS "GH_NATION"           @id("2a0007"),
    1                                        AS "SYSTEM_VERSION"      @id("2a0008") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("2a0009") @isSystemCurrentFlag @accepted_values("'Y', 'N'"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("2a000a") @isSystemCreateDate @not_null,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("2a000b") @isSystemUpdateDate @not_null,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("2a000c") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_NATION_CLEAN') }} "W"
