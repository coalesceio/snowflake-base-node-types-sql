@id("dd00d532-7112-5831-8a9b-3c1797e18834")
@nodeType("SQLDimension")
@materializationType("table")
@description("Customer dimension - SCD2")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
SELECT
    CAST(0 AS NUMBER) AS "CUSTOMER_SK" @id("63370beb-37c6-57ce-9802-6eb94c79b7a9") @isSurrogateKey,
    "C"."CUSTOMER_KEY" AS "CUSTOMER_KEY" @id("4f1432ec-a881-5b44-a131-1c6aa54f7f2d") @isBusinessKey @clusterKey(1),
    "C"."CUSTOMER_NAME" AS "CUSTOMER_NAME" @id("ae13d8df-c4d7-57f4-8ec5-65f994e3daad"),
    "C"."PHONE" AS "PHONE" @id("57dba59f-efc4-5786-998f-dd7c417722b9") @tag("PII", "true"),
    "C"."ACCOUNT_BALANCE" AS "ACCOUNT_BALANCE" @id("59482b4b-2e8a-5be9-8dda-10b948214271") @isChangeTracking,
    "C"."MARKET_SEGMENT" AS "MARKET_SEGMENT" @id("3daa8c51-8813-5fb3-aa84-42ca10923039") @isChangeTracking @zeroKey("'N/A'"),
    "C"."NATION_NAME" AS "NATION_NAME" @id("dda91cd5-e021-563a-9f04-bded8201915d"),
    "C"."REGION_NAME" AS "REGION_NAME" @id("a7cc0fb1-fa92-5760-9a7f-853caab7b3ea"),
    1 AS "SYSTEM_VERSION" @id("a7eab717-ac16-5eeb-8be6-1d81e62218f3") @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @id("1272914e-e52a-57f5-a5a4-74d478e22756") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("b349a19a-48ec-5e2f-937e-612ce240ba6e") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("331210ea-b334-593e-a66d-64ef60c1ce63") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("bab03483-cc86-540c-92cf-606a16a0c828") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_CUSTOMER_VIEW') }} "C"
