@id("c438445e-73ad-4846-9e7d-72557604ee20")
@nodeType("718")
@disableIDs     -- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created.
SELECT
    0                                        AS "DIM_CUSTOMER_KEY"    @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY" @isBusinessKey,
    "C_NAME"                                 AS "C_NAME",
    "C_ADDRESS"                              AS "C_ADDRESS",
    "C_NATIONKEY"                            AS "C_NATIONKEY",
    "C_PHONE"                                AS "C_PHONE",
    "C_ACCTBAL"                              AS "C_ACCTBAL",
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT",
    "C_COMMENT"                              AS "C_COMMENT",
    1                                        AS "SYSTEM_VERSION"      @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"