@id("e5c7fee8-7cfd-4f75-b194-43307534b26a")
@nodeType("718")
@description("Customer dimension (SCD Type 2): keeps a history of address, phone and market-segment changes")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_CUSTOMER_KEY"    @id("8da386") @description("Surrogate key, one per customer version") @isSurrogateKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @id("dd2adb") @description("Customer identifier") @isBusinessKey @not_null,
    "C_NATIONKEY"                            AS "C_NATIONKEY"         @id("d83308") @description("Nation the customer belongs to") @isBusinessKey @not_null @min_max(0, 24),
    "C_NAME"                                 AS "C_NAME"              @id("c514fd") @description("Customer name") @not_null @empty,
    "C_ADDRESS"                              AS "C_ADDRESS"           @id("4ff125") @description("Customer address - a change creates a new version") @isChangeTracking,
    "C_PHONE"                                AS "C_PHONE"             @id("58e9bd") @description("Customer phone number - a change creates a new version") @isChangeTracking,
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @id("c82ff4") @description("Customer account balance") @min_max("-999.99", "9999.99"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"        @id("74be21") @description("Customer market segment - a change creates a new version") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C_COMMENT"                              AS "C_COMMENT"           @id("36e52b") @description("Free-text comment"),
    1                                        AS "SYSTEM_VERSION_RENAME"      @id("d5ed29") @description("Version number of the customer row") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG_RENAME" @id("cec34c") @description("Y on the current version, N on expired versions") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE_RENAME"  @id("1641a0") @description("When this version was created") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE_RENAME"  @id("faa1b5") @description("When this version was last updated or expired") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE_RENAME"     @id("53fae8") @description("When this version stopped being current; 2999-12-31 while current") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
