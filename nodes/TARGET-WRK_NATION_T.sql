@id("c814974d-8fd5-48f2-9fb1-6a9aa9080a69")
@nodeType("664")
@orderby(true)
@orderbycolumn("[object Object]", "desc")
@groupByAll(true)
@description("Table''desc")
@testsEnabled(true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "After", true)
WITH ALL_NATION AS
(
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_COPY1') }} "NATION_COPY1"
UNION
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_COPY2') }} "NATION_COPY2"
)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY"  @nullable(false),
     "N_NAME" AS "N_NAME_RENAME" @defaultValue("NA"),
     "N_REGIONKEY" AS "N_REGIONKEY" @description("Column''desc"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM ALL_NATION
WHERE N_NATIONKEY = 2
