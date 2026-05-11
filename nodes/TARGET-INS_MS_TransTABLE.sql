@id("3b4e9eb3-3bbd-4d2a-bf9a-1992a12736b2")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@materializationType("transient table")

WITH ALL_TABLES AS (
     SELECT * FROM {{ ref('SRC', 'NATION_COPY1') }} "NATION_COPY1"
     UNION
     SELECT * FROM {{ ref('SRC', 'NATION_COPY2') }} "NATION_COPY2"
)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM ALL_TABLES