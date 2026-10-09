@id("11c0e78c-21d3-4f06-b0ec-a79174b0bdb2")
@nodeType("SQLWork")
@description("Staging copy of CUSTOMER with data quality checks and a row hash")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ ref('SRC', 'CUSTOMER') }} HAVING COUNT(*) = 0", false, "Before")
@tests("SELECT 1 FROM {{ this }} HAVING COUNT(*) <> (SELECT COUNT(*) FROM {{ ref('SRC', 'CUSTOMER') }})")
SELECT
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @description("Customer identifier") @not_null @uniqueness @min_value(1),
    "C_NAME"                                 AS "C_NAME"              @description("Customer name") @not_null @empty @inHash("ROW_HASH", 1),
    "C_ADDRESS"                              AS "C_ADDRESS"           @description("Customer address") @inHash("ROW_HASH", 2),
    "C_NATIONKEY"                            AS "C_NATIONKEY"         @description("Nation the customer belongs to") @not_null @min_max(0, 24) @inHash("ROW_HASH", 3),
    "C_PHONE"                                AS "C_PHONE"             @description("Customer phone number") @empty @inHash("ROW_HASH", 4),
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @description("Customer account balance") @min_max("-999.99", "9999.99") @inHash("ROW_HASH", 5),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"        @description("Customer market segment") @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'") @inHash("ROW_HASH", 6),
    "C_COMMENT"                              AS "C_COMMENT"           @description("Free-text comment") @inHash("ROW_HASH", 7),
    {{ get_hash('ROW_HASH') }}::STRING       AS "ROW_HASH"            @description("SHA1 hash of the customer attributes, for change comparison")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
