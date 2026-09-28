@id("6b7129e2-9cf2-409e-a06b-bb71a3c9e353")
@nodeType("707")
@description("Work table of TPC-H suppliers")
SELECT
    "SUPPLIER"."S_SUPPKEY"   AS "S_SUPPKEY"   @id("5f49ea") @not_null @uniqueness @description("Supplier key (primary key)"),
    "SUPPLIER"."S_NAME"      AS "S_NAME"      @id("45abd3") @not_null @empty @description("Supplier name"),
    "SUPPLIER"."S_ADDRESS"   AS "S_ADDRESS"   @id("3aee0a") @description("Supplier street address"),
    "SUPPLIER"."S_NATIONKEY" AS "S_NATIONKEY" @id("e80e10") @not_null @min_max("0", "24") @description("Nation key of the supplier (FK to NATION)"),
    "SUPPLIER"."S_PHONE"     AS "S_PHONE"     @id("346f46") @description("Supplier phone number"),
    "SUPPLIER"."S_ACCTBAL"   AS "S_ACCTBAL"   @id("05aa6b") @description("Supplier account balance"),
    "SUPPLIER"."S_COMMENT"   AS "S_COMMENT"   @id("340fbe") @description("Free-text comment about the supplier")
FROM {{ ref('SRC', 'SUPPLIER') }} "SUPPLIER"
