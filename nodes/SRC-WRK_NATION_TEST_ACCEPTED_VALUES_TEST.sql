@id("2898236a-4ba8-4dd1-9632-496f4ff16696")
@nodeType("707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @accepted_values("1,2,3,4") @accepted_values("5","6") @accepted_values(7) @accepted_values(1),
     "N_NAME" AS "N_NAME" @rejected_values("'NA'") @rejected_values("'NAME'"),
     "N_REGIONKEY" AS "N_REGIONKEY" @accepted_values("1") @rejected_values("4","5") @rejected_values(6),
     "N_COMMENT" AS "N_COMMENT" @rejected_values("'NA'"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"