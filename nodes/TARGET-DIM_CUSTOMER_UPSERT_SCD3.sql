@id("3183231e-6c42-4b1e-a0ef-2b9ca019b16e")
@nodeType("718")
@description("Customer dimension using upsert with custom SCD3 logic: keeps the previous address")
@mergeStrategy("upsert")
WITH "EXISTING" AS (
    -- Current rows already in this dimension
    SELECT "C_CUSTKEY", "C_ADDRESS", "C_ADDRESS_PREV", "C_ADDRESS_CHANGED_DATE"
    FROM TANVI_DEV.TARGET.DIM_CUSTOMER_UPSERT_SCD3
)
SELECT
    "SRC"."C_CUSTKEY"                        AS "C_CUSTKEY"           @id("e626f1") @isBusinessKey,
    "SRC"."C_NAME"                           AS "C_NAME"              @id("27fce7"),
    "SRC"."C_ADDRESS"                        AS "C_ADDRESS"           @id("042cef"),
    CAST(CASE WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL AND NOT EQUAL_NULL("SRC"."C_ADDRESS", "EXISTING"."C_ADDRESS")
         THEN "EXISTING"."C_ADDRESS"
         ELSE "EXISTING"."C_ADDRESS_PREV" END AS VARCHAR(40))  AS "C_ADDRESS_PREV"         @id("4f630a"),
    CAST(CASE WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL AND NOT EQUAL_NULL("SRC"."C_ADDRESS", "EXISTING"."C_ADDRESS")
         THEN CURRENT_TIMESTAMP
         ELSE "EXISTING"."C_ADDRESS_CHANGED_DATE" END AS TIMESTAMP) AS "C_ADDRESS_CHANGED_DATE" @id("889805"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7993d0") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("636a9e") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }} "SRC"
LEFT JOIN "EXISTING" ON "SRC"."C_CUSTKEY" = "EXISTING"."C_CUSTKEY"
