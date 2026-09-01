@id("1a2bafd4-2b4e-4084-9188-e03465841574")
@nodeType("704")
@writeMode("truncateInsert")
@disableTests("false")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0")
@preSQL("SELECT 1")
@postSQL("SELECT 1")
SELECT
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @notNull @description("Nation key") @inHash("GH_COL", 1) @not_null @uniqueness @min_max("0", "100") @max_value("1000"),
     "N"."N_NAME" AS "N_NAME" @empty,
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @rejected_values("-1") @min_value("0") @accepted_values("0") @accepted_values("1") @accepted_values("2") @accepted_values("3") @accepted_values("4"),
     "N"."N_COMMENT" AS "N_COMMENT" @defaultValue("'NA'"),
     "N"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @freshness(1, "DAY") @relative_time(">", "REF_TS"),
     "O"."ORDER_ID" AS "ORDER_ID" @inHash("GH_COL", 2),
     "O"."CUSTOMER_NAME" AS "CUSTOMER_NAME",
     "O"."ORDER_DATA" AS "ORDER_DATA",
     TO_TIMESTAMP_LTZ('2020-01-01 00:00:00') AS "REF_TS",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
JOIN {{ ref('SRC', 'ORDERS_TEST') }} "O" ON MOD("O"."ORDER_ID", 25) = "N"."N_NATIONKEY"