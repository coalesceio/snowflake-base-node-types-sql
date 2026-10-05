@id("0ae8dcbf-6b58-4ea4-9394-cf06d234e885")
@nodeType("718")
@mergeStrategy("changeTracking")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY C_CUSTKEY HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                        AS "DIM_CUSTOMER_GEO_KEY" @id("299d29") @isSurrogateKey,
    "STG_CUSTOMER"."C_CUSTKEY"               AS "C_CUSTKEY"            @id("7db7d9") @isBusinessKey @not_null,
    "STG_CUSTOMER"."C_NAME"                  AS "C_NAME"               @id("d28c5a"),
    "STG_CUSTOMER"."C_ADDRESS"               AS "C_ADDRESS"            @id("6971a0") @isChangeTracking,
    "STG_CUSTOMER"."C_PHONE"                 AS "C_PHONE"              @id("6fc46c"),
    "STG_CUSTOMER"."C_ACCTBAL"               AS "C_ACCTBAL"            @id("d2b75c"),
    "STG_CUSTOMER"."C_MKTSEGMENT"            AS "C_MKTSEGMENT"         @id("8cd28a") @isChangeTracking,
    "STG_CUSTOMER"."N_NATIONKEY"             AS "N_NATIONKEY"          @id("efb2da") @isChangeTracking,
    "STG_CUSTOMER"."N_NAME"                  AS "N_NAME"               @id("e2a5de"),
    "STG_CUSTOMER"."R_REGIONKEY"             AS "R_REGIONKEY"          @id("68115c"),
    "STG_CUSTOMER"."R_NAME"                  AS "R_NAME"               @id("6d6f29"),
    1                                        AS "SYSTEM_VERSION"       @id("2532e9") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("0d77b3") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("a37505") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("b37407") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("65a604") @isSystemEndDate
FROM {{ ref('TARGET', 'STG_CUSTOMER') }} "STG_CUSTOMER"
