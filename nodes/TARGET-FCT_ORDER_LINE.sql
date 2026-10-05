@id("df9b18f1-3bd7-452f-8ef5-a1efafc182f6")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ ref('TARGET', 'STG_ORDER_LINE') }} GROUP BY ORDER_KEY, LINE_NUMBER HAVING COUNT(*) > 1", false, "Before")
SELECT
    "OL"."ORDER_KEY"                         AS "ORDER_KEY"            @id("44a586") @isBusinessKey @not_null,
    "OL"."LINE_NUMBER"                       AS "LINE_NUMBER"          @id("729fcc") @isBusinessKey @not_null,
    COALESCE("DC"."DIM_CUSTOMER_GEO_KEY", 0) AS "DIM_CUSTOMER_GEO_KEY" @id("353a09") @not_null,
    COALESCE("DP"."DIM_PART_KEY", 0)         AS "DIM_PART_KEY"         @id("5f5cbf") @not_null,
    "OL"."SUPPLIER_KEY"                      AS "SUPPLIER_KEY"         @id("df8e39"),
    "OL"."ORDER_DATE"                        AS "ORDER_DATE"           @id("851a21"),
    "OL"."SHIP_DATE"                         AS "SHIP_DATE"            @id("a4329a"),
    "OL"."RECEIPT_DATE"                      AS "RECEIPT_DATE"         @id("6e14ed"),
    "OL"."ORDER_STATUS"                      AS "ORDER_STATUS"         @id("035902"),
    "OL"."ORDER_PRIORITY"                    AS "ORDER_PRIORITY"       @id("4c9370"),
    "OL"."RETURN_FLAG"                       AS "RETURN_FLAG"          @id("c8a462"),
    "OL"."LINE_STATUS"                       AS "LINE_STATUS"          @id("03d972"),
    "OL"."SHIP_MODE"                         AS "SHIP_MODE"            @id("4ac609"),
    "OL"."QUANTITY"                          AS "QUANTITY"             @id("23d328") @min_value("0"),
    "OL"."EXTENDED_PRICE"                    AS "EXTENDED_PRICE"       @id("6ee257"),
    "OL"."DISCOUNT"                          AS "DISCOUNT"             @id("4fe190") @min_max("0", "1"),
    "OL"."TAX"                               AS "TAX"                  @id("a1aa8f"),
    "OL"."NET_AMOUNT"                        AS "NET_AMOUNT"           @id("33669d"),
    "OL"."GROSS_AMOUNT"                      AS "GROSS_AMOUNT"         @id("2e8d8d"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("c9cc9a") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("d83b8b") @isSystemUpdateDate
FROM {{ ref('TARGET', 'STG_ORDER_LINE') }} "OL"
LEFT JOIN {{ ref('TARGET', 'DIM_CUSTOMER_GEO') }} "DC"
    ON "OL"."CUSTOMER_KEY" = "DC"."C_CUSTKEY"
   AND "DC"."SYSTEM_CURRENT_FLAG" = 'Y'
LEFT JOIN {{ ref('TARGET', 'DIM_PART') }} "DP"
    ON "OL"."PART_KEY" = "DP"."P_PARTKEY"
   AND "DP"."SYSTEM_CURRENT_FLAG" = 'Y'
