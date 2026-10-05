@id("0116d0be-d347-43b6-84d2-7377d68b8eaf")
@nodeType("718")
SELECT
    0                                        AS "DIM_CUSTOMER_ORDER_SUMMARY_VW_KEY" @id("37c2bb") @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY"                         @id("30b0b6"),
    "C_NAME"                                 AS "C_NAME"                            @id("129f1a"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"                      @id("e36955"),
    "ORDER_COUNT"                            AS "ORDER_COUNT"                       @id("9b1b32"),
    "TOTAL_SPEND"                            AS "TOTAL_SPEND"                       @id("71651c"),
    "LAST_ORDER_DATE"                        AS "LAST_ORDER_DATE"                   @id("697fdc"),
    "HAS_ORDERS"                             AS "HAS_ORDERS"                        @id("35a757"),
    1                                        AS "SYSTEM_VERSION"                    @id("680691") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"               @id("9c98a3") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"                @id("96e1a2") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"                @id("d0322c") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"                   @id("429dae") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_CUSTOMER_ORDER_SUMMARY_VW') }} "WRK_CUSTOMER_ORDER_SUMMARY_VW"