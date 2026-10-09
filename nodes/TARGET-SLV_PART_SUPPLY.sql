@id("b0559446-218c-5d99-a967-2785d90efddf")
@nodeType("SQLWork")
@materializationType("table")
@description("Part supply (SQLWork over YAML nodes)")
SELECT
    "PS"."PS_PARTKEY" AS "PART_KEY" @id("411cf2ac-3dab-5edf-9c47-7a885e3559a2"),
    "PS"."PS_SUPPKEY" AS "SUPPLIER_KEY" @id("01d859b7-84d0-52e6-9f9e-a932d50a8eef"),
    "PS"."PS_AVAILQTY" AS "AVAILABLE_QTY" @id("bda68b8e-2de4-5c96-9a60-a4ac80e1f55e"),
    "PS"."PS_SUPPLYCOST" AS "SUPPLY_COST" @id("146699e2-f14c-582b-b6ee-bc14e378749c"),
    "P"."PART_NAME" AS "PART_NAME" @id("01336121-918f-5600-9d53-04604b3787ba"),
    CAST("PS"."PS_AVAILQTY" * "PS"."PS_SUPPLYCOST" AS NUMBER(38,2)) AS "INVENTORY_VALUE" @id("74ab4c9a-8ba6-5102-a610-796e543cd796"),
    "PS"."LOAD_TS" AS "LOAD_TS" @id("432e94c4-3beb-5c72-98ae-56b07c7d34cb")
FROM {{ ref('TARGET', 'BRZ_PARTSUPP') }} "PS"
INNER JOIN {{ ref('TARGET', 'SLV_PART') }} "P"
    ON "PS"."PS_PARTKEY" = "P"."PART_KEY"
