@id("59a9fb72-4418-4bcb-b6fc-f55c66a38fe3")
@nodeType("Latest220:::SQLDimension")
@mergeStrategy("changeTracking")
@zeroKey("0")
@tests("SELECT 1 FROM {{ ref('TARGET', 'WRK_EMPLOYEE') }} GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                        AS "DIM_EMPLOYEE_KEY"    @id("75b953") @isSurrogateKey,
    "WRK_EMPLOYEE"."EMPLOYEE_ID"             AS "EMPLOYEE_ID"         @id("4c2bc2") @isBusinessKey @not_null,
    "WRK_EMPLOYEE"."EMPLOYEE_NAME"           AS "EMPLOYEE_NAME"       @id("88fc19"),
    "WRK_EMPLOYEE"."DEPARTMENT"              AS "DEPARTMENT"          @id("68fa1e") @isChangeTracking,
    "WRK_EMPLOYEE"."LOCATION"                AS "LOCATION"            @id("59db99") @isChangeTracking,
    1                                        AS "SYSTEM_VERSION"      @id("ccfad2") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("9e52a5") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("318416") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("e67d25") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("01d20b") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_EMPLOYEE') }} "WRK_EMPLOYEE"
