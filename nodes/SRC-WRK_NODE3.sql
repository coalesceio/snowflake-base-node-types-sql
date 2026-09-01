@id("f32805bd-f6c3-46e6-8c4d-ca618daa8ba0")
@nodeType("707")
@writeMode("truncateInsert")
@disableTests("false")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0")
@preSQL("SELECT 1")
@postSQL("SELECT 1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @inHash("GH_COL", 1) @not_null @uniqueness @min_max("0", "100") @max_value("1000"),
     "N_NAME" AS "N_NAME" @empty,
     "N_REGIONKEY" AS "N_REGIONKEY" @rejected_values("-1") @min_value("0") @accepted_values("0") @accepted_values("1") @accepted_values("2") @accepted_values("3") @accepted_values("4"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @freshness(30, "DAY") @relative_time(">", "REF_TS"),
     TO_TIMESTAMP_LTZ('2020-01-01 00:00:00') AS "REF_TS",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"