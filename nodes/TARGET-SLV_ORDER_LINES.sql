@id("7f6b2998-ad85-5ff6-9790-ce088fb43065")
@nodeType("Latest:::707")
@materializationType("table")
@description("Order lines (Latest Work V2)")
SELECT
    "L"."ORDER_KEY" AS "ORDER_KEY" @id("962d8280-db74-50df-9da9-8df34e24f560"),
    "L"."LINE_NUMBER" AS "LINE_NUMBER" @id("9de20e2c-98d7-5493-9fa8-080b0b069c01"),
    "O"."CUSTOMER_KEY" AS "CUSTOMER_KEY" @id("59fd053f-24e5-553b-9773-fa44c9bd3ee1"),
    "O"."ORDER_DATE" AS "ORDER_DATE" @id("577229f9-b528-5eaa-97d5-f84862ff98c4"),
    "L"."SHIP_DATE" AS "SHIP_DATE" @id("e5934eef-8820-511f-bc9c-315e836ea29c"),
    "L"."SHIP_MODE" AS "SHIP_MODE" @id("f041f9f3-54a7-5180-87c4-feb7b15ac10a"),
    "L"."NET_AMOUNT" AS "NET_AMOUNT" @id("6f9a8764-3743-5fbf-a98a-307331634b64"),
    CAST(DATEDIFF(DAY, "O"."ORDER_DATE", "L"."SHIP_DATE") AS NUMBER(9,0)) AS "DAYS_TO_SHIP" @id("83b2e37a-278e-595c-8432-c7e41264c765")
FROM {{ ref('TARGET', 'SLV_LINEITEM') }} "L"
INNER JOIN {{ ref('TARGET', 'SLV_ORDERS') }} "O"
    ON "L"."ORDER_KEY" = "O"."ORDER_KEY"
