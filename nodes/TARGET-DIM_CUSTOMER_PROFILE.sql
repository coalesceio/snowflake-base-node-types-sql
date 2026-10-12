@id("888f914d-11ac-4656-b707-3f40fb39171e")
@nodeType("SQLDimension")
@materializationType("table")
@description("Sales star - customer dimension (change tracking, SCD2 on segment and nation) with zero key")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tests("SELECT CUSTOMER_KEY FROM {{ ref('TARGET', 'WRK_CUSTOMER') }} GROUP BY CUSTOMER_KEY HAVING COUNT(*) > 1 OR CUSTOMER_KEY IS NULL", false, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY CUSTOMER_KEY HAVING COUNT(*) > 1", false, "After")
SELECT
    0 AS "DIM_CUSTOMER_PROFILE_KEY" @id("c0a1cb95-5348-49f6-82c2-91d688d58efd") @isSurrogateKey,
    "C"."CUSTOMER_KEY" AS "CUSTOMER_KEY" @id("2f9e654c-0fe3-4075-9bce-d02915e7ee6e") @isBusinessKey @clusterKey(1),
    "C"."CUSTOMER_NAME" AS "CUSTOMER_NAME" @id("e6f491d0-ddc2-4ffe-ae94-ecf11bfeb475"),
    "C"."ADDRESS" AS "ADDRESS" @id("c239777e-0e1b-4ecf-b886-ae76a585fb40"),
    "C"."PHONE" AS "PHONE" @id("b57ab4b0-55c5-4788-bba4-2cade08dc7b4"),
    "C"."ACCOUNT_BALANCE" AS "ACCOUNT_BALANCE" @id("09a532c8-ec8f-4293-a5d2-56b20bebab00"),
    "C"."MARKET_SEGMENT" AS "MARKET_SEGMENT" @id("3256956d-2bd8-4901-9a67-23728a29e2e1") @isChangeTracking @zeroKey("'N/A'"),
    "C"."NATION_KEY" AS "NATION_KEY" @id("916c1e58-66e0-4b9a-a364-45c4fbb974a3") @isChangeTracking @zeroKey("-1"),
    "C"."NATION_NAME" AS "NATION_NAME" @id("bff5a4a9-95d5-49c9-b067-3ca1d05f8d2e"),
    "C"."REGION_NAME" AS "REGION_NAME" @id("aea42fc2-daf2-4702-9d40-073c54b56585"),
    CAST(CASE WHEN "C"."ACCOUNT_BALANCE" >= 5000 THEN 'GOLD'
              WHEN "C"."ACCOUNT_BALANCE" >= 0 THEN 'STD'
              ELSE 'RISK' END AS VARCHAR(4)) AS "CUSTOMER_TIER" @id("48e8f4b5-69ce-413f-b750-ddfc71336846") @zeroKey("'STD'"),
    1 AS "SYSTEM_VERSION" @id("93668db3-72af-450b-b8d5-5d785c47b5a1") @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @id("e174e5c3-e8d1-4932-abf6-db16615eb526") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("fbcfe4c0-c496-4468-b3d5-cf6c6ea06752") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("403d5fbb-4772-4d95-adf0-f5c4ba1b3a03") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("5020287b-1a3b-47aa-a190-d9929d5c95fb") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_CUSTOMER_TBL') }} "C"
