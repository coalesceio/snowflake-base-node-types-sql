@id("6b586750-f7f7-518a-ae0d-92fa20cf9ed8")
@nodeType("SQLWork")
@materializationType("table")
@description("Nation + region (SQLWork over YAML nodes)")
SELECT
    "N"."N_NATIONKEY" AS "NATION_KEY" @id("a2fa58e5-ca8e-55e5-afed-a4ed2bbf94f7"),
    "N"."N_NAME" AS "NATION_NAME" @id("796e35b0-80dc-5875-b4a0-bc8a720e5027"),
    "N"."N_REGIONKEY" AS "REGION_KEY" @id("c850f8a3-b288-584f-b711-a3a99cb6f518"),
    "R"."R_NAME" AS "REGION_NAME" @id("4c0fcd8f-410d-5841-ba93-9489c12f448b"),
    "N"."N_LOAD_TIMESTAMP" AS "LOAD_TS" @id("330fe94d-2752-53d9-b440-2ecac83416db")
FROM {{ ref('TARGET', 'BRZ_NATION') }} "N"
INNER JOIN {{ ref('TARGET', 'BRZ_REGION') }} "R"
    ON "N"."N_REGIONKEY" = "R"."R_REGIONKEY"
