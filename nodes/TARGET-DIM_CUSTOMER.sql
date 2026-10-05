@id("70de1016-0194-40c8-b867-a37c37a5077f")
@nodeType("718")
SELECT
    0                                        AS "DIM_CUSTOMER_KEY"    @id("e0ca6f") @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @id("fa9f71") @isBusinessKey,
    "C_NAME"                                 AS "C_NAME"              @id("1a0e51"),
    "C_ADDRESS"                              AS "C_ADDRESS"           @id("d73ea5"),
    "C_NATIONKEY"                            AS "C_NATIONKEY"         @id("362c31"),
    "C_PHONE"                                AS "C_PHONE"             @id("7e8d79"),
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @id("cc1e22"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"        @id("9c6109"),
    "C_COMMENT"                              AS "C_COMMENT"           @id("5f9237"),
    1                                        AS "SYSTEM_VERSION"      @id("a46dc2") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("cd1e2b") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("641409") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("5e1078") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("a5e6d6") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"