@id("16c29b02-6c28-5d67-8f8c-f0aede8c8eb7")
@nodeType("SQLDimension")
@materializationType("table")
@description("Part dimension - lastModified")
@mergeStrategy("lastModified")
SELECT
    CAST(0 AS NUMBER) AS "PART_SK" @id("376b4a43-321b-51bf-9250-69bc8084ac04") @isSurrogateKey,
    "P"."P_PARTKEY" AS "PART_KEY" @id("93ced19e-e825-5d56-a08b-2d8f309f53aa") @isBusinessKey,
    "P"."P_NAME" AS "PART_NAME" @id("e5ada89c-d0ab-5a72-ad1e-2b437d579a96"),
    "P"."P_BRAND" AS "BRAND" @id("ff0cce23-4f1e-57fc-9999-1734b94a3d9d"),
    "P"."P_TYPE" AS "PART_TYPE" @id("60acdf85-eb83-5a15-ab6f-e794e24d209e"),
    "P"."P_SIZE" AS "PART_SIZE" @id("9d36a836-88d7-5ca9-9acf-3c162bf0f16c"),
    CAST("P"."P_RETAILPRICE" AS NUMBER(14,2)) AS "RETAIL_PRICE" @id("6c4a411f-19a9-5114-a2b9-89b5ec46063e"),
    "P"."LOAD_TS" AS "LOAD_TS" @id("ff2ae738-b44d-5273-803d-c5706e932292") @lastModifiedTracking(1),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("93bbc872-c5b9-5a4d-9e4d-e85256b6b5da") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d81d2e0b-e896-5b36-926a-69171452bc3e") @isSystemUpdateDate
FROM {{ ref('TARGET', 'BRZ_PART') }} "P"
