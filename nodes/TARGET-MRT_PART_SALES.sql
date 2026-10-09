@id("ce01a398-6b55-520f-9ec4-567e1295a266")
@nodeType("Latest:::707")
@materializationType("table")
@description("Sales by brand and type (Latest Work V2)")
SELECT
    "P"."BRAND" AS "BRAND" @id("20857710-8f32-5f73-a88a-645055c3b2cd"),
    "P"."PART_TYPE" AS "PART_TYPE" @id("c9d976b3-f272-514b-b8f9-4101926ef06c"),
    CAST(SUM("L"."QUANTITY") AS NUMBER(38,2)) AS "QUANTITY" @id("289731c1-13c3-538d-9f0f-9ab604b68730"),
    CAST(SUM("L"."NET_AMOUNT") AS NUMBER(38,4)) AS "NET_SALES" @id("8601f10e-b6be-5376-82f1-41a59a206208")
FROM {{ ref('TARGET', 'FCT_LINEITEM') }} "L"
INNER JOIN {{ ref('TARGET', 'DIM_PART') }} "P"
    ON "L"."PART_KEY" = "P"."PART_KEY"
GROUP BY ALL
