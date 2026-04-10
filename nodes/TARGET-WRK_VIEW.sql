@id("ce4b74f7-bf16-42c0-a6ba-a42f9253d8a7")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@materializationType("view")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"