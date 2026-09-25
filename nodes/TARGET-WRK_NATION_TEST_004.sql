@id("3c931d5e-1fb8-4bda-bb58-df4d0b7695dc")
@nodeType("707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @min_max("-5", "10") @accepted_values("1, 2") @accepted_values(4),
     "N_NAME" AS "N_NAME" @rejected_values("'NA'") ,
     "N_REGIONKEY" AS "N_REGIONKEY" @min_value(99.9) @accepted_values(1),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @max_value("'2024-01-01 00:00:00'"),
     "N_DATE" AS "N_DATE" 
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"