@id("30c664f4-93ae-4113-af16-ed31e6a8295e")
@nodeType("SQLWork")
@description("Silver: cleaned customer - trimmed text, upper-cased segment, non-null key")
@writeMode("truncateInsert")
SELECT
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @id("031461") @description("Customer identifier") @not_null,
    TRIM("C_NAME")                           AS "C_NAME"              @id("92698c") @description("Customer name, trimmed"),
    TRIM("C_ADDRESS")                        AS "C_ADDRESS"           @id("9ac333") @description("Customer address, trimmed"),
    "C_NATIONKEY"                            AS "C_NATIONKEY"         @id("9dd6df") @description("Nation the customer belongs to"),
    TRIM("C_PHONE")                          AS "C_PHONE"             @id("4368fb") @description("Customer phone number, trimmed"),
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @id("9fc838") @description("Account balance"),
    UPPER(TRIM("C_MKTSEGMENT"))              AS "C_MKTSEGMENT"        @id("49af3e") @description("Market segment, upper-cased"),
    "LOAD_TS"                                AS "LOAD_TS"             @id("dd5218") @description("Bronze load time")
FROM {{ ref('TARGET', 'BRZ_CUSTOMER') }} "BRZ_CUSTOMER"
WHERE "C_CUSTKEY" IS NOT NULL
