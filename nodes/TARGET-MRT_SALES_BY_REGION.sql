@id("d6a663d2-b331-536c-b6fe-16b8dcbbdf14")
@nodeType("SQLWork")
@materializationType("table")
@description("Net sales by region and year")
@tag("OWNER", "DATA_TEAM")
SELECT
    "C"."REGION_NAME" AS "REGION_NAME" @id("55251b0b-0044-5e31-8faf-7816472c4770"),
    CAST(YEAR("O"."ORDER_DATE") AS NUMBER(4,0)) AS "ORDER_YEAR" @id("44bed702-1857-5299-81d2-d0629f21b505"),
    CAST(COUNT(*) AS NUMBER(18,0)) AS "LINE_COUNT" @id("93221e3c-3e95-5e41-91bf-a94deb7ed365"),
    CAST(SUM("L"."NET_AMOUNT") AS NUMBER(38,4)) AS "NET_SALES" @id("d5d27b90-6573-5bf7-b582-28b19ce5dfe5")
FROM {{ ref('TARGET', 'FCT_LINEITEM') }} "L"
INNER JOIN {{ ref('TARGET', 'FCT_ORDERS') }} "O"
    ON "L"."ORDER_KEY" = "O"."ORDER_KEY"
INNER JOIN {{ ref('TARGET', 'DIM_CUSTOMER') }} "C"
    ON "O"."CUSTOMER_KEY" = "C"."CUSTOMER_KEY"
    AND "C"."SYSTEM_CURRENT_FLAG" = 'Y'
GROUP BY ALL
