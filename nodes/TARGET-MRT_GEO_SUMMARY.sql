@id("e336f270-ccc0-5ed1-bdbc-dbb2df39f6f7")
@nodeType("SQLWork")
@materializationType("view")
@description("Nations per region (SQL Dimension + YAML Dimension)")
SELECT
    "R"."R_NAME" AS "REGION_NAME" @id("a0e65b19-7049-57bc-8034-150d889a017e"),
    CAST(COUNT("G"."NATION_KEY") AS NUMBER(18,0)) AS "NATION_COUNT" @id("1b225899-37b3-5af2-9dd8-196654dacda2")
FROM {{ ref('TARGET', 'DIM_REGION') }} "R"
LEFT JOIN {{ ref('TARGET', 'DIM_GEOGRAPHY') }} "G"
    ON "G"."REGION_KEY" = "R"."R_REGIONKEY"
GROUP BY ALL
