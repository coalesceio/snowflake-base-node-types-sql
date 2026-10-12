@id("086c2594-8491-4cf4-b711-1a0ee23e859d")
@nodeType("SQLFact")
@materializationType("table")
@description("Sales star - part/supplier inventory snapshot fact (change tracking, SCD1)")
@mergeStrategy("changeTracking")
SELECT
    "I"."PART_KEY" AS "PART_KEY" @id("765e63c7-d875-4c14-9158-af085dbc7793") @isBusinessKey,
    "I"."SUPPLIER_KEY" AS "SUPPLIER_KEY" @id("4618ea78-d45e-4a60-95d4-7dbd3c3b823e") @isBusinessKey,
    COALESCE("P"."DIM_PRODUCT_KEY", -1) AS "DIM_PRODUCT_KEY" @id("2c1f3635-e661-48da-bae2-1d665eb8108c") @not_null,
    "I"."AVAILABLE_QTY" AS "AVAILABLE_QTY" @id("296d1ac2-d517-44e6-8a38-3341f1d78c42") @min_value("0"),
    "I"."SUPPLY_COST" AS "SUPPLY_COST" @id("f7fb87f1-c36d-4d4f-a8f0-e9c5e9784da7"),
    "I"."INVENTORY_VALUE" AS "INVENTORY_VALUE" @id("5bc213e3-78b9-432a-a3d3-86b5707d7fa2"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("06a95dce-c7ee-42ea-8217-daeccbf2580e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("13b71a51-04b3-4f03-bba6-c92caa4cb239") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_INVENTORY') }} "I"
LEFT JOIN {{ ref('TARGET', 'DIM_PRODUCT') }} "P"
    ON "I"."PART_KEY" = "P"."PART_KEY"
    AND "P"."SYSTEM_CURRENT_FLAG" = 'Y'
