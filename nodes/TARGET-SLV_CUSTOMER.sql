@id("2779c9d9-a22f-4e4c-8655-07c551c68b68")
@nodeType("707")
@description("Silver: cleaned customer - trimmed text, upper-cased segment (SQL Work)")
SELECT
    "C_CUSTKEY"                 AS "C_CUSTKEY"    @id("3512b3") @not_null @uniqueness,
    TRIM("C_NAME")              AS "C_NAME"       @id("6f61cc") @not_null @empty,
    TRIM("C_ADDRESS")           AS "C_ADDRESS"    @id("3a9728"),
    "C_NATIONKEY"               AS "C_NATIONKEY"  @id("afe6e6") @not_null,
    TRIM("C_PHONE")             AS "C_PHONE"      @id("dc56aa"),
    "C_ACCTBAL"                 AS "C_ACCTBAL"    @id("8a6346"),
    UPPER(TRIM("C_MKTSEGMENT")) AS "C_MKTSEGMENT" @id("ae8aa8"),
    "LOAD_TS"                   AS "LOAD_TS"      @id("7664b3")
FROM {{ ref('TARGET', 'BRZ_CUSTOMER') }} "BRZ_CUSTOMER"
