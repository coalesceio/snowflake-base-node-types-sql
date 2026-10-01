@id("da569c9b-b647-4b2b-8d90-3660576d1aeb")
@nodeType("718")
@description("Gold: customer dimension, SCD2 on market segment (SQL Dimension)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "GLD_DIM_CUSTOMER_KEY" @id("3427cc") @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY"            @id("5f6141") @isBusinessKey,
    "C_NAME"                                 AS "C_NAME"               @id("9e9040"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"         @id("64ef36") @isChangeTracking,
    "NATION_NAME"                            AS "NATION_NAME"          @id("631921"),
    1                                        AS "SYSTEM_VERSION"       @id("c8f68b") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("19ebad") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("ddc8c3") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("bb3984") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("731d3e") @isSystemEndDate
FROM {{ ref('TARGET', 'SLV_CUSTOMER_ENRICHED') }} "SLV_CUSTOMER_ENRICHED"
