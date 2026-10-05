@id("b65f9421-17d2-4739-824d-56daa78b76db")
@nodeType("718")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY HK_ORDER HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_ORDER"                           AS "HK_ORDER"            @id("212e5e") @isBusinessKey @not_null,
    "S"."HASHDIFF_ORDER"                     AS "HASHDIFF_ORDER"      @id("4e5041") @isChangeTracking @not_null,
    "S"."O_ORDERSTATUS"                      AS "O_ORDERSTATUS"       @id("78e2ed"),
    "S"."O_TOTALPRICE"                       AS "O_TOTALPRICE"        @id("3f24ad"),
    "S"."O_ORDERDATE"                        AS "O_ORDERDATE"         @id("3bc074"),
    "S"."O_ORDERPRIORITY"                    AS "O_ORDERPRIORITY"     @id("469997"),
    "S"."O_CLERK"                            AS "O_CLERK"             @id("1842e2"),
    "S"."O_SHIPPRIORITY"                     AS "O_SHIPPRIORITY"      @id("47dbee"),
    "S"."O_COMMENT"                          AS "O_COMMENT"           @id("d98769"),
    "S"."RECORD_SOURCE"                      AS "RECORD_SOURCE"       @id("96e23c"),
    1                                        AS "SYSTEM_VERSION"      @id("152968") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("0cb0f8") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "LOAD_DTS"            @id("cdc810") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("f17da8") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "LOAD_END_DTS"        @id("48132d") @isSystemEndDate
FROM {{ ref('TARGET', 'STG_DV_ORDERS') }} "S"
