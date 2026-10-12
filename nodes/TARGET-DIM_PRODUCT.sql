@id("00825ec6-cf89-4831-85fa-301c364e4541")
@nodeType("SQLDimension")
@materializationType("table")
@description("Sales star - product dimension (last modified, SCD2) with zero key")
@mergeStrategy("lastModified")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
SELECT
    0 AS "DIM_PRODUCT_KEY" @id("595338b8-5ef5-4776-8432-66a500587374") @isSurrogateKey,
    "P"."PART_KEY" AS "PART_KEY" @id("71cfc740-0687-4b24-8ca7-4f01945a86f5") @isBusinessKey,
    "P"."PART_NAME" AS "PART_NAME" @id("1dc71c71-bf4f-478f-bbba-a5cd1f083193"),
    "P"."MANUFACTURER" AS "MANUFACTURER" @id("3f5211b1-ba13-4287-9c1d-a45a9e8b5367"),
    "P"."BRAND" AS "BRAND" @id("0e08721f-d789-4a2a-a4f6-63835fab71fd"),
    "P"."PART_TYPE" AS "PART_TYPE" @id("ba82e438-168d-49c3-9b80-902848092731"),
    "P"."PART_SIZE" AS "PART_SIZE" @id("979be419-b0f2-44f7-af28-4e4cc9d2052b"),
    "P"."CONTAINER" AS "CONTAINER" @id("da191807-92bc-4ca4-9db9-acaccc6a45cd"),
    "P"."RETAIL_PRICE" AS "RETAIL_PRICE" @id("f7ee37fb-9878-4dac-8cc3-801115f7aa45"),
    "P"."PRICE_BAND" AS "PRICE_BAND" @id("8a2cbc94-e0ea-4f8d-89dd-3b77138ef869") @zeroKey("'N/A'"),
    "P"."LOAD_TS" AS "LOAD_TS" @id("91ac521f-211d-45a2-ac20-54e27fa154ef") @lastModifiedTracking(2),
    1 AS "SYSTEM_VERSION" @id("7f7e3e90-f583-416b-8888-8c5c6b440a03") @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @id("39d9e969-94e8-4f06-ae0a-a7c832a77dd6") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("91dc50d9-9688-4107-a2be-0bba05891f97") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("222b03e6-4240-48db-95dc-d992b7c0bbf8") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("3f0f39ed-ad86-4050-bd10-49a0b4e9c904") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_PRODUCT') }} "P"
