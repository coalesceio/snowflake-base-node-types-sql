@id("64642d3b-42ff-5e99-a23b-812445249d08")
@nodeType("SQLDimension")
@materializationType("table")
@description("Geography dimension - upsert (changed)")
@mergeStrategy("upsert")
@tag("Cost_Centre", "OPS")
SELECT
    "G"."NATION_KEY" AS "NATION_KEY" @id("4fc1aa13-6468-5097-a082-bed34723b280") @isBusinessKey,
    "G"."NATION_NAME" AS "NATION_NAME" @id("52413fa6-662b-5a34-84b0-1a1f9552b8aa"),
    "G"."REGION_KEY" AS "REGION_KEY" @id("ce733abd-bf3a-5682-adf5-0f6184d6822b"),
    "G"."REGION_NAME" AS "REGION_NAME" @id("fba4a209-6932-5590-aa8d-2e4a26b19895"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("8a043361-f1c7-5207-9471-97ac2f1edb18") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("4ad21d24-64f9-5f1d-97be-8b04f5d0c7f2") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_GEOGRAPHY') }} "G"
