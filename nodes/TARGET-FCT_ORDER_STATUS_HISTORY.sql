@id("ccfc6b82-b593-5956-98a3-31b3efc75735")
@nodeType("SQLFact")
@materializationType("table")
@description("Order status history - allColumnMatch")
@mergeStrategy("allColumnMatch")
SELECT
    "O"."ORDER_KEY" AS "ORDER_KEY" @id("afefe460-e33f-53b4-81e5-fd6d76115020"),
    "O"."ORDER_STATUS" AS "ORDER_STATUS" @id("6e820299-af41-56d2-bc5e-d2461dd4c6a9"),
    "O"."ORDER_PRIORITY" AS "ORDER_PRIORITY" @id("c02eb1c9-1f45-5578-bc53-f42490ebf637"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f270fc40-34c8-5396-9330-ae71f9e64d1c") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("2b013858-26ef-5738-85f3-40134a5d22fa") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_ORDERS') }} "O"
