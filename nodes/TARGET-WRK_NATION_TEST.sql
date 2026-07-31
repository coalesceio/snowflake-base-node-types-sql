@id("2940e54e-7357-4fee-845d-111a1d3aaf94")
@nodeType("664")
@materializationType("view")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @tests("null"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("unique")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"