@id("9345bbc4-5348-4500-a3b7-0af0c557a9d9")
@nodeType("SQLDimension")
@description("Gold: customer dimension - SCD2 on address and market segment")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "GLD_DIM_CUSTOMER_KEY" @id("3e8119") @description("Surrogate key, one per customer version") @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY"            @id("cc5b77") @description("Customer identifier") @isBusinessKey,
    "C_NAME"                                 AS "C_NAME"               @id("4c23f9") @description("Customer name"),
    "C_ADDRESS"                              AS "C_ADDRESS"            @id("d3375e") @description("Customer address - tracked") @isChangeTracking,
    "C_PHONE"                                AS "C_PHONE"              @id("619d22") @description("Customer phone number"),
    "C_ACCTBAL"                              AS "C_ACCTBAL"            @id("1c93be") @description("Account balance"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"         @id("bdf675") @description("Market segment - tracked") @isChangeTracking,
    "C_NATIONKEY"                            AS "C_NATIONKEY"          @id("242c50") @description("Nation key"),
    "NATION_NAME"                            AS "NATION_NAME"          @id("bfd5cb") @description("Nation name"),
    "REGION_KEY"                             AS "REGION_KEY"           @id("0d7bbe") @description("Region key"),
    1                                        AS "SYSTEM_VERSION"       @id("6b295c") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("106941") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("28705c") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("5052cf") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("f1b33f") @isSystemEndDate
FROM {{ ref('TARGET', 'SLV_CUSTOMER_NATION') }} "SLV_CUSTOMER_NATION"
