@id("20a5e8a0-4536-5200-a11f-d13dec8a88ae")
@nodeType("SQLFact")
@materializationType("table")
@description("Orders fact - upsert")
@mergeStrategy("upsert")
SELECT
    "O"."ORDER_KEY" AS "ORDER_KEY" @id("46999d33-23b3-53b1-9b32-7586e0096035") @isBusinessKey,
    "O"."CUSTOMER_KEY" AS "CUSTOMER_KEY" @id("82d79317-819c-5d29-ad87-fe59b4c6ee80"),
    "O"."ORDER_STATUS" AS "ORDER_STATUS" @id("071a1558-e15d-53d8-bb15-cb6a07a7860e"),
    "O"."TOTAL_PRICE" AS "TOTAL_PRICE" @id("880994a3-528b-5ae3-8107-a7db60f07580"),
    "O"."ORDER_DATE" AS "ORDER_DATE" @id("d3c81176-7165-5cf1-85cd-d6d751ad2387") @clusterKey(1),
    "O"."ORDER_PRIORITY" AS "ORDER_PRIORITY" @id("fd4cff78-af91-5559-8deb-2752cb60513e"),
    "O"."ORDER_YEAR" AS "ORDER_YEAR" @id("bdf0fc8e-a037-550b-9636-3e74446aa55a"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("bc5670d6-d757-55df-ad68-45baf55efcde") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("afee6778-c9b9-532b-b612-1fc79bdda40a") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_ORDERS') }} "O"
