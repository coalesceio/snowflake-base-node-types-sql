@id("d71b96b3-f80d-465d-9909-a1f5966eecbc")
@nodeType("SQLFact")
@mergeStrategy("lastModified")
@tests("SELECT 1 FROM {{ ref('SRC', 'PARTSUPP') }} GROUP BY PS_PARTKEY, PS_SUPPKEY HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} GROUP BY PART_KEY, SUPPLIER_KEY HAVING COUNT(*) > 1", false, "After")
SELECT
    "PARTSUPP"."PS_PARTKEY"                                                     AS "PART_KEY"           @id("4db26f") @isBusinessKey @not_null,
    "PARTSUPP"."PS_SUPPKEY"                                                     AS "SUPPLIER_KEY"       @id("aac336") @isBusinessKey @not_null,
    "PARTSUPP"."PS_AVAILQTY"                                                    AS "AVAILABLE_QTY"      @id("e9db99") @min_value("0"),
    "PARTSUPP"."PS_SUPPLYCOST"                                                  AS "SUPPLY_COST"        @id("ca3adb") @min_value("0"),
    CAST("PARTSUPP"."PS_AVAILQTY" * "PARTSUPP"."PS_SUPPLYCOST" AS NUMBER(18,2)) AS "INVENTORY_VALUE"    @id("cf8e64"),
    "PARTSUPP"."PS_LOAD_TIMESTAMP"                                              AS "LAST_MODIFIED_TS"   @id("42c2f6") @lastModifiedTracking @not_null,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                        AS "SYSTEM_CREATE_DATE" @id("7a201e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                        AS "SYSTEM_UPDATE_DATE" @id("79eff8") @isSystemUpdateDate
FROM {{ ref('SRC', 'PARTSUPP') }} "PARTSUPP"
