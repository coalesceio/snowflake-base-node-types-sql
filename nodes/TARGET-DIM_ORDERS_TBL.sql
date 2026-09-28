@id("9ec64336-8d53-45b7-a3fc-1dcd9903828c")
@nodeType("718")
@writeMode("truncateInsert")
SELECT
    0                                        AS "DIM_ORDERS_KEY"      @id("43a637") @isSurrogateKey,
    "O_ORDERKEY"                             AS "O_ORDERKEY"          @id("fcbe21") @isBusinessKey,
    "O_CUSTKEY"                              AS "O_CUSTKEY"           @id("c42ce4"),
    "O_ORDERSTATUS"                          AS "O_ORDERSTATUS"       @id("feb90d") @isChangeTracking,
    "O_TOTALPRICE"                           AS "O_TOTALPRICE"        @id("f88cac") @isChangeTracking,
    "O_ORDERDATE"                            AS "O_ORDERDATE"         @id("c0bd0e"),
    "O_ORDERPRIORITY"                        AS "O_ORDERPRIORITY"     @id("2ea632"),
    "O_CLERK"                                AS "O_CLERK"             @id("df0862"),
    "O_SHIPPRIORITY"                         AS "O_SHIPPRIORITY"      @id("1b8b59"),
    "O_COMMENT"                              AS "O_COMMENT"           @id("5f2e4e"),
    1                                        AS "SYSTEM_VERSION"      @id("62a469") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("616031") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("e3d171") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("581a1f") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("8dcd32") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_ORDERS') }} "WRK_ORDERS"