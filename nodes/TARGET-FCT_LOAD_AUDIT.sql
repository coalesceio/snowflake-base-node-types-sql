@id("47ea9fbf-0f07-54ac-86c5-95cbc4c38834")
@nodeType("SQLFact")
@materializationType("table")
@description("Load audit - plain insert, append")
@writeMode("append")
SELECT
    "R"."R_REGIONKEY" AS "REGION_KEY" @id("d0cb126a-633a-5124-91c3-fe3dbf4ac772"),
    "R"."R_NAME" AS "REGION_NAME" @id("95492c0c-aa28-59e2-a43e-643cf9210fb3"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_RUN_TS" @id("be452dc3-f4fb-56c0-ac3a-70e76bc8d87f"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("6a80415c-ea8c-5292-b59c-89947db5ea04") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("a05836d5-a657-59b0-9450-9b69b6d55088") @isSystemUpdateDate
FROM {{ ref('TARGET', 'BRZ_REGION') }} "R"
