@id("b515f012-aac0-474a-b4cc-edf7b23b9cbb")
@nodeType("718")
@description("Pipeline: customer dimension - lastModified SCD Type 1 on CREATED_AT, with zero key")
@mergeStrategy("lastModified")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00")
@tests("SELECT 1 FROM {{ this }} GROUP BY CUSTOMER_ID HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                    AS "DIM_CUSTOMER_KEY"   @id("2b0001") @isSurrogateKey,
    "W"."CUSTOMER_ID"                    AS "CUSTOMER_ID"        @id("2b0002") @isBusinessKey @zeroKey("-1") @not_null @uniqueness,
    "W"."CUSTOMER_NAME"                  AS "CUSTOMER_NAME"      @id("2b0003") @not_null,
    "W"."SIGNUP_DATE"                    AS "SIGNUP_DATE"        @id("2b0004"),
    "W"."SIGNUP_YEAR"                    AS "SIGNUP_YEAR"        @id("2b0005"),
    "W"."NATION_KEY"                     AS "NATION_KEY"         @id("2b0006") @zeroKey("-1"),
    "W"."CREATED_AT"                     AS "CREATED_AT"         @id("2b0007") @lastModifiedTracking(1) @not_null,
    "W"."GH_CUSTOMER"                    AS "GH_CUSTOMER"        @id("2b0008"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("2b0009") @isSystemCreateDate @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("2b000a") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_CUSTOMER_CLEAN') }} "W"
