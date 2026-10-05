@id("ad5e63b0-9fe2-416a-a918-e0ea9275b57d")
@nodeType("SQLDimension")
@mergeStrategy("changeTracking")
@zeroKey("0")
@tests("SELECT 1 FROM {{ ref('TARGET', 'WRK_TRAINING') }} GROUP BY TRAINING_ID HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY TRAINING_ID HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                        AS "DIM_TRAINING_KEY"    @id("247f89") @isSurrogateKey,
    "WRK_TRAINING"."TRAINING_ID"             AS "TRAINING_ID"         @id("5025da") @isBusinessKey @not_null,
    "WRK_TRAINING"."TRAINING_NAME"           AS "TRAINING_NAME"       @id("5ee1ea"),
    "WRK_TRAINING"."TRAINER"                 AS "TRAINER"             @id("0fd0dc") @isChangeTracking,
    1                                        AS "SYSTEM_VERSION"      @id("b10446") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("c146b9") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("93f123") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("4eaa1a") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("bc1a2f") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_TRAINING') }} "WRK_TRAINING"
