@id("1a8e7a6d-ad9d-5b10-a9ef-426f13de3341")
@nodeType("SQLFact")
@materializationType("table")
@description("Lineitem fact - lastModified")
@mergeStrategy("lastModified")
@tag("OWNER", "DATA_TEAM")
SELECT
    "L"."ORDER_KEY" AS "ORDER_KEY" @id("a3420c13-a624-590d-a0e1-73d97f054a00") @isBusinessKey,
    "L"."LINE_NUMBER" AS "LINE_NUMBER" @id("042cb78e-af0c-5cc4-b25e-068902c5df47") @isBusinessKey,
    "L"."PART_KEY" AS "PART_KEY" @id("3761f099-9792-521f-9501-dc1059c6cb75"),
    "L"."SUPPLIER_KEY" AS "SUPPLIER_KEY" @id("0dc291f3-ca4f-5908-b140-0f20daa07661"),
    "L"."QUANTITY" AS "QUANTITY" @id("9d959875-bba6-5dc8-b8d1-ced6625398f8"),
    "L"."NET_AMOUNT" AS "NET_AMOUNT" @id("b1d9da25-b853-510e-bef4-37587cd60707"),
    "L"."SHIP_DATE" AS "SHIP_DATE" @id("27160750-8760-53fa-add5-1f837d18fcfd") @clusterKey(1),
    "L"."SHIP_MODE" AS "SHIP_MODE" @id("57acd22f-f0f6-5235-9d3c-8e6a28c1c898"),
    "L"."RETURN_FLAG" AS "RETURN_FLAG" @id("cdead14b-9737-5e23-887f-900be83b5bf1"),
    "L"."LOAD_TS" AS "LOAD_TS" @id("a350f1ca-3f76-58ca-afba-b5b78ee05a92") @lastModifiedTracking,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("663842c5-ceaa-5cb1-87cd-fc0b2a7e7ae8") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("10582264-c638-51de-9f99-64bbc0815008") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_LINEITEM') }} "L"
