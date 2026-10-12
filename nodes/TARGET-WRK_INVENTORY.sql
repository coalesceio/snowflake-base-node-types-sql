@id("84350427-98bb-4045-9646-c42bc26ca352")
@nodeType("SQLWork")
@materializationType("view")
@description("Sales star - part/supplier inventory position")
@tag("PIPELINE", "SALES_STAR")
SELECT
    "PS"."PS_PARTKEY" AS "PART_KEY",
    "PS"."PS_SUPPKEY" AS "SUPPLIER_KEY",
    "PS"."PS_AVAILQTY" AS "AVAILABLE_QTY" @min_value("0"),
    "PS"."PS_SUPPLYCOST" AS "SUPPLY_COST",
    CAST("PS"."PS_AVAILQTY" * "PS"."PS_SUPPLYCOST" AS NUMBER(18,2)) AS "INVENTORY_VALUE",
    "PS"."LOAD_TS" AS "LOAD_TS"
FROM {{ ref('SRC', 'PARTSUPP') }} "PS"
