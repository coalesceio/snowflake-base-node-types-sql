@id("f4f160ea-7fef-47bb-9ca0-ff69ca474c29")
@nodeType("7b516fbe-d586-4d1b-ab79-f3b494bbcd4e")
@materializationType("view")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"