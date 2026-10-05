@id("263a5ada-407c-4e93-b932-d0aef1454445")
@nodeType("718")
@mergeStrategy("changeTracking")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY P_PARTKEY HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                        AS "DIM_PART_KEY"        @id("9e7e15") @isSurrogateKey,
    "STG_PART"."P_PARTKEY"                   AS "P_PARTKEY"           @id("f8df57") @isBusinessKey @not_null,
    "STG_PART"."P_NAME"                      AS "P_NAME"              @id("82fbd0"),
    "STG_PART"."P_MFGR"                      AS "P_MFGR"              @id("79e5d9"),
    "STG_PART"."P_BRAND"                     AS "P_BRAND"             @id("67cab1") @isChangeTracking,
    "STG_PART"."P_TYPE"                      AS "P_TYPE"              @id("2d0144"),
    "STG_PART"."P_SIZE"                      AS "P_SIZE"              @id("fca96d"),
    "STG_PART"."P_CONTAINER"                 AS "P_CONTAINER"         @id("23f56c"),
    "STG_PART"."P_RETAILPRICE"               AS "P_RETAILPRICE"       @id("fd5359") @isChangeTracking,
    1                                        AS "SYSTEM_VERSION"      @id("6acc03") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("fd825b") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("373061") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("a932fa") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("d12985") @isSystemEndDate
FROM {{ ref('TARGET', 'STG_PART') }} "STG_PART"
