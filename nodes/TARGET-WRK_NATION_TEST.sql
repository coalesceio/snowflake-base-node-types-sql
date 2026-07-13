@id("5e64c74c-5e53-477e-aa87-6d74ce3d568e")
@nodeType("664")
@orderby(true)
@groupByAll(true)
@orderbycolumn("N_NAME", "desc")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"