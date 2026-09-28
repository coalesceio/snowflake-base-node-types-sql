@id("e94bfaab-d2d5-43f2-b362-7a6495b552dd")
@nodeType("707")
@description("Work table of TPC-H customers with a hash diff for change detection")
SELECT
    "CUSTOMER"."C_CUSTKEY"                AS "C_CUSTKEY"    @id("ef9597") @not_null @uniqueness @description("Customer key (primary key)"),
    "CUSTOMER"."C_NAME"                   AS "C_NAME"       @id("f57034") @not_null @empty @inHash("HD_CUSTOMER", 1) @description("Customer name"),
    "CUSTOMER"."C_ADDRESS"                AS "C_ADDRESS"    @id("4bbd2d") @inHash("HD_CUSTOMER", 2) @description("Customer street address"),
    "CUSTOMER"."C_NATIONKEY"              AS "C_NATIONKEY"  @id("2e17e3") @not_null @min_max("0", "24") @inHash("HD_CUSTOMER", 3) @description("Nation key of the customer (FK to NATION)"),
    "CUSTOMER"."C_PHONE"                  AS "C_PHONE"      @id("f95838") @inHash("HD_CUSTOMER", 4) @description("Customer phone number"),
    "CUSTOMER"."C_ACCTBAL"                AS "C_ACCTBAL"    @id("b48077") @inHash("HD_CUSTOMER", 5) @description("Customer account balance"),
    "CUSTOMER"."C_MKTSEGMENT"             AS "C_MKTSEGMENT" @id("c076f0") @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'") @inHash("HD_CUSTOMER", 6) @description("Customer market segment"),
    "CUSTOMER"."C_COMMENT"                AS "C_COMMENT"    @id("28efa1") @description("Free-text comment about the customer"),
    {{ get_hash('HD_CUSTOMER') }}::STRING AS "HD_CUSTOMER"  @id("bf88c0") @description("SHA1 hash diff of the descriptive customer columns")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
