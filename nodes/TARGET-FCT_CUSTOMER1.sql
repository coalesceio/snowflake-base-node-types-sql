@id("ccb2c837-cfca-4f54-adf7-b9febeef5f5f")
@nodeType("SQLFact")
SELECT
    "DIM_CUSTOMER_KEY"                   AS "DIM_CUSTOMER_KEY"    @id("3b41fa"),
    "C_CUSTKEY"                          AS "C_CUSTKEY"           @id("f34c8a"),
    "C_NAME"                             AS "C_NAME"              @id("722842"),
    "C_ADDRESS"                          AS "C_ADDRESS"           @id("6bce62"),
    "C_NATIONKEY"                        AS "C_NATIONKEY"         @id("a94654"),
    "C_PHONE"                            AS "C_PHONE"             @id("1869bc"),
    "C_ACCTBAL"                          AS "C_ACCTBAL"           @id("45e0dc"),
    "C_MKTSEGMENT"                       AS "C_MKTSEGMENT"        @id("ad117c"),
    "C_COMMENT"                          AS "C_COMMENT"           @id("80d4c1"),
    "SYSTEM_VERSION"                     AS "SYSTEM_VERSION"      @id("d540ed"),
    "SYSTEM_CURRENT_FLAG"                AS "SYSTEM_CURRENT_FLAG" @id("cf42af"),
    "SYSTEM_END_DATE"                    AS "SYSTEM_END_DATE"     @id("596e24"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"  @id("2fe9bc") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"  @id("c0a517") @isSystemUpdateDate
FROM {{ ref('TARGET', 'DIM_CUSTOMER') }} "DIM_CUSTOMER"