@id("2fbe6727-5a95-4a70-b643-7060c5fff577")
@nodeType("707")
@description("Work table of TPC-H part-supplier pairs with a composite hash key")
@tests("SELECT 1 FROM {{ this }} GROUP BY PS_PARTKEY, PS_SUPPKEY HAVING COUNT(*) > 1")
SELECT
    "PARTSUPP"."PS_PARTKEY"                         AS "PS_PARTKEY"    @id("dfde52") @not_null @inHash("HK_PARTSUPP", 1) @description("Part key (FK to PART)"),
    "PARTSUPP"."PS_SUPPKEY"                         AS "PS_SUPPKEY"    @id("ce5bcf") @not_null @inHash("HK_PARTSUPP", 2) @description("Supplier key (FK to SUPPLIER)"),
    "PARTSUPP"."PS_AVAILQTY"                        AS "PS_AVAILQTY"   @id("46bf43") @min_value("0") @description("Quantity available from the supplier"),
    "PARTSUPP"."PS_SUPPLYCOST"                      AS "PS_SUPPLYCOST" @id("9fd463") @min_value("0") @description("Supplier cost for the part"),
    "PARTSUPP"."PS_COMMENT"                         AS "PS_COMMENT"    @id("7bf6fd") @description("Free-text comment about the part-supplier pair"),
    {{ get_hash('HK_PARTSUPP', 'SHA256') }}::STRING AS "HK_PARTSUPP"   @id("7c3a06") @not_null @uniqueness @description("SHA256 hash key of PS_PARTKEY and PS_SUPPKEY")
FROM {{ ref('SRC', 'PARTSUPP') }} "PARTSUPP"
