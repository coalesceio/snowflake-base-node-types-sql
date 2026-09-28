@id("7b96f104-b42b-4433-a53c-6fba25254574")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 2 customer order summary dimension built on WRK_CUSTOMER_ORDER_SUMMARY_VW; a change to segment, order count, spend, last order date or has-orders flag expires the current version and inserts a new one")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY, SYSTEM_VERSION HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} WHERE (HAS_ORDERS = 'Y' AND (ORDER_COUNT = 0 OR LAST_ORDER_DATE IS NULL)) OR (HAS_ORDERS = 'N' AND (ORDER_COUNT <> 0 OR TOTAL_SPEND <> 0 OR LAST_ORDER_DATE IS NOT NULL))")
@tests("SELECT 1 FROM {{ this }} WHERE (SYSTEM_CURRENT_FLAG = 'Y' AND SYSTEM_END_DATE <> '2999-12-31 00:00:00'::TIMESTAMP) OR (SYSTEM_CURRENT_FLAG = 'N' AND SYSTEM_END_DATE >= '2999-12-31 00:00:00'::TIMESTAMP)")
SELECT
    0                                                                   AS "DIM_CUSTOMER_ORDER_SUMMARY_SCD2_KEY" @id("896e12") @isSurrogateKey @description("Surrogate key of the customer order summary version"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."C_CUSTKEY" AS NUMBER(38,0))   AS "C_CUSTKEY"                           @id("78a0f1") @isBusinessKey @not_null @min_value("1") @description("Customer key (business key)"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."C_NAME" AS VARCHAR(25))       AS "C_NAME"                              @id("8cf56c") @not_null @empty @description("Customer name"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."C_MKTSEGMENT" AS VARCHAR(10)) AS "C_MKTSEGMENT"                        @id("9cc356") @isChangeTracking @not_null @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'") @description("Customer market segment; a change creates a new version"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."ORDER_COUNT" AS NUMBER(18,0)) AS "ORDER_COUNT"                         @id("097adb") @isChangeTracking @not_null @min_value("0") @description("Number of orders placed by the customer; a change creates a new version"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."TOTAL_SPEND" AS NUMBER(38,2)) AS "TOTAL_SPEND"                         @id("d19ab3") @isChangeTracking @not_null @min_value("0") @description("Sum of O_TOTALPRICE across all orders of the customer; a change creates a new version"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."LAST_ORDER_DATE" AS DATE)     AS "LAST_ORDER_DATE"                     @id("5a7143") @isChangeTracking @min_max("DATE '1992-01-01'", "CURRENT_DATE") @description("Date of the most recent order of the customer, NULL when none; a change creates a new version"),
    CAST("WRK_CUSTOMER_ORDER_SUMMARY_VW"."HAS_ORDERS" AS VARCHAR(1))    AS "HAS_ORDERS"                          @id("3a6d82") @isChangeTracking @not_null @accepted_values("'Y', 'N'") @description("Y when the customer has placed at least one order; a change creates a new version"),
    1                                                                   AS "SYSTEM_VERSION"                      @id("f40a51") @isSystemVersion @not_null @min_value("1") @description("Version number of the customer summary, incremented on each tracked change"),
    'Y'                                                                 AS "SYSTEM_CURRENT_FLAG"                 @id("49f9f9") @isSystemCurrentFlag @not_null @accepted_values("'Y', 'N'") @description("Y on the current version of the customer summary, N on expired versions"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                AS "SYSTEM_CREATE_DATE"                  @id("10e92e") @isSystemCreateDate @not_null @description("Timestamp when this version was first inserted"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                AS "SYSTEM_UPDATE_DATE"                  @id("d3ba2d") @isSystemUpdateDate @not_null @relative_time(">=", "SYSTEM_CREATE_DATE") @description("Timestamp when this version was last inserted or expired"),
    CAST('2999-12-31 00:00:00' AS TIMESTAMP)                            AS "SYSTEM_END_DATE"                     @id("a08f2f") @isSystemEndDate @not_null @description("End of the validity window of this version; 2999-12-31 while current")
FROM {{ ref('TARGET', 'WRK_CUSTOMER_ORDER_SUMMARY_VW') }} "WRK_CUSTOMER_ORDER_SUMMARY_VW"
