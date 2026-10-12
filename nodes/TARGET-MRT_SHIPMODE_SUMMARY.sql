@id("3fea84ff-51ee-5fb0-b13a-7e274dcdb173")
@nodeType("SQLWork")
@materializationType("table")
@description("Ship mode summary - added on redeploy")
SELECT
    "OL"."SHIP_MODE" AS "SHIP_MODE" @id("ce52f54f-e24b-5ccc-9669-c0021637226f"),
    CAST(COUNT(*) AS NUMBER(18,0)) AS "LINE_COUNT" @id("08127c89-9e41-5fbe-a324-ec1af62b6561"),
    CAST(AVG("OL"."DAYS_TO_SHIP") AS NUMBER(9,2)) AS "AVG_DAYS_TO_SHIP" @id("cf56efe8-859d-5639-826b-bbfa3092e78a")
FROM {{ ref('TARGET', 'SLV_ORDER_LINES') }} "OL"
GROUP BY ALL
