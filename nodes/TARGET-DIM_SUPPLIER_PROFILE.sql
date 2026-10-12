@id("3d77cffa-f988-482c-a1c1-73bbf8a78741")
@nodeType("SQLDimension")
@materializationType("table")
@description("Sales star - supplier dimension (upsert)")
@mergeStrategy("upsert")
SELECT
    "S"."SUPPLIER_KEY" AS "SUPPLIER_KEY" @id("51d69ebf-b16a-4147-8496-e9b946c3b5dd") @isBusinessKey,
    "S"."SUPPLIER_NAME" AS "SUPPLIER_NAME" @id("5be406d2-da38-4bed-b9cc-e399230b5fab") @not_null,
    "S"."ADDRESS" AS "ADDRESS" @id("141a9ff5-377a-4ade-a997-d3fcbabeabf9"),
    "S"."PHONE" AS "PHONE" @id("655e738d-23d1-4f2f-88fe-bbadcdf47012"),
    "S"."ACCOUNT_BALANCE" AS "ACCOUNT_BALANCE" @id("f06b191d-5e7f-48f9-9495-055b8f2d1d72"),
    "S"."NATION_KEY" AS "NATION_KEY" @id("44b770a8-3ead-4651-92bb-c4ff5b5b5dc7"),
    "S"."NATION_NAME" AS "NATION_NAME" @id("3de26c57-86f4-4ecc-b15e-4b1554876358"),
    "S"."REGION_NAME" AS "REGION_NAME" @id("4265faa5-aef4-40f6-a4b9-f1c99f8657d8"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("2845b6ac-0c40-4500-9df4-81a2637a047f") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("c79a307d-7ca2-4ff2-bf42-a0f9c8ed3f8d") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_SUPPLIER_TBL') }} "S"
