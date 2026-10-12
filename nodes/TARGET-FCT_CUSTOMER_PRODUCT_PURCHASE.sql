@id("91854d0f-0a9a-40f8-90ea-55eaba0ef9e1")
@nodeType("SQLFact")
@materializationType("table")
@description("Sales star - factless fact of which customer bought which product on which date (all column match)")
@mergeStrategy("allColumnMatch")
@tag("PIPELINE", "SALES_STAR")
SELECT DISTINCT
    "S"."DIM_CUSTOMER_PROFILE_KEY" AS "DIM_CUSTOMER_PROFILE_KEY" @id("179975d3-0616-41c5-ab0e-7074e6ae5e7f"),
    "S"."DIM_PRODUCT_KEY" AS "DIM_PRODUCT_KEY" @id("504056b2-c3eb-4e07-852a-ed8c27d629ba"),
    "S"."ORDER_DATE" AS "ORDER_DATE" @id("3c6c4f1c-aede-451b-8ab1-996b42389637") @clusterKey(1),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("65304afb-4d4f-4f58-a403-4eee58d6f067") @isSystemCreateDate
FROM {{ ref('TARGET', 'FCT_SALES') }} "S"
