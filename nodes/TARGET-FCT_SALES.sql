@id("d7f22753-89ee-4a95-ac49-e0e0f5f7a582")
@nodeType("SQLFact")
@materializationType("table")
@description("Sales star - order line sales fact (last modified) keyed to customer, product and nation dimensions")
@mergeStrategy("lastModified")
@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_KEY, LINE_NUMBER HAVING COUNT(*) > 1", false, "After")
SELECT
    "OL"."ORDER_KEY" AS "ORDER_KEY" @id("b59fb8a1-ffd5-447d-b5d2-08fda06e3ea2") @isBusinessKey,
    "OL"."LINE_NUMBER" AS "LINE_NUMBER" @id("41a87cc0-07d3-4dc2-b1b9-65e82fff8fa1") @isBusinessKey,
    COALESCE("C"."DIM_CUSTOMER_PROFILE_KEY", -1) AS "DIM_CUSTOMER_PROFILE_KEY" @id("530cbc72-a0c2-4871-aeb7-1cea289e3870") @not_null,
    COALESCE("P"."DIM_PRODUCT_KEY", -1) AS "DIM_PRODUCT_KEY" @id("ec58ad34-0473-4abe-ba13-1930b76c10db") @not_null,
    COALESCE("N"."DIM_NATION_KEY", -1) AS "DIM_NATION_KEY" @id("c917d282-18cf-4620-8bb6-504d7c90552d") @not_null,
    "OL"."SUPPLIER_KEY" AS "SUPPLIER_KEY" @id("3b9038b4-f157-4f6c-8056-b78f69ac9d18"),
    "OL"."ORDER_DATE" AS "ORDER_DATE" @id("b14ad53c-fe14-4f35-a5ae-e198ddffa0c5"),
    "OL"."SHIP_DATE" AS "SHIP_DATE" @id("b168e873-5d07-4807-886e-4bca633dbc14") @clusterKey(1),
    "OL"."RECEIPT_DATE" AS "RECEIPT_DATE" @id("ed6b16db-a35c-400c-b303-804476160ee7"),
    "OL"."SHIP_MODE" AS "SHIP_MODE" @id("fec7356f-229c-4d88-b6af-3fc97d858ae4"),
    "OL"."RETURN_FLAG" AS "RETURN_FLAG" @id("9bf1f29c-3594-496d-aac4-6fd4fe7180c8"),
    "OL"."QUANTITY" AS "QUANTITY" @id("d90df607-6aa8-4042-a9cf-7380d7ae7d52") @min_value("0"),
    "OL"."EXTENDED_PRICE" AS "EXTENDED_PRICE" @id("9933d857-a35e-43aa-baff-45b330cbc294"),
    "OL"."DISCOUNT_PCT" AS "DISCOUNT_PCT" @id("d1efca8d-7459-40d6-bc09-b9354fbff066"),
    "OL"."NET_AMOUNT" AS "NET_AMOUNT" @id("bbb8bac9-1db2-4ffb-9983-6eff069a0639"),
    "OL"."GROSS_AMOUNT" AS "GROSS_AMOUNT" @id("087fbe64-9804-47b6-bbba-e77786029016"),
    "OL"."IS_LATE" AS "IS_LATE" @id("44077be2-415d-4d19-bcc4-69fc5b598ddc"),
    "OL"."LOAD_TS" AS "LOAD_TS" @id("5b38f997-ec68-40ff-9183-8aef76c38591") @lastModifiedTracking,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("b6404033-1927-46c5-ad65-dbfb500e3e46") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("6fa1cfed-6cf8-4610-9f05-62374cd02ad5") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_ORDER_LINES') }} "OL"
LEFT JOIN {{ ref('TARGET', 'DIM_CUSTOMER_PROFILE') }} "C"
    ON "OL"."CUSTOMER_KEY" = "C"."CUSTOMER_KEY"
    AND "C"."SYSTEM_CURRENT_FLAG" = 'Y'
LEFT JOIN {{ ref('TARGET', 'DIM_PRODUCT') }} "P"
    ON "OL"."PART_KEY" = "P"."PART_KEY"
    AND "P"."SYSTEM_CURRENT_FLAG" = 'Y'
LEFT JOIN {{ ref('TARGET', 'DIM_NATION') }} "N"
    ON "C"."NATION_KEY" = "N"."NATION_KEY"
