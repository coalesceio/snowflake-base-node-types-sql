@id("afac77ad-b174-4e1d-9e39-acae46808d7e")
@nodeType("718")
@description("TEST: SCD2 dimension keyed on a GEOGRAPHY business key (safe_equals check)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_CUSTOMER_GEO_KEY" @id("d9b9fb")  @isSurrogateKey,
    ('POINT(' || "C_NATIONKEY" || ' ' || ("C_CUSTKEY" / 1000000) || ')')::GEOGRAPHY AS "C_LOCATION" @id("caf88d") @isBusinessKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY" @id("620b66"),
    "C_NAME"                                 AS "C_NAME" @id("f1e41c"),
    "C_ADDRESS"                              AS "C_ADDRESS" @id("7aa838")             @isChangeTracking,
    "C_PHONE"                                AS "C_PHONE" @id("a8bf14")               @isChangeTracking,
    "C_ACCTBAL"                              AS "C_ACCTBAL" @id("f7bbc2"),
    1                                        AS "SYSTEM_VERSION" @id("a256a9")        @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("c00bce")   @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE" @id("b568f7")    @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE" @id("52d6bf")    @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d26009")       @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
