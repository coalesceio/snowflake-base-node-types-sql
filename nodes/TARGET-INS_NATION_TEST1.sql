@id("237cd61b-04a8-46a8-8bfe-5fd821dd0a25")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")
@testsEnabled(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @hashValue("GH", "GH1"),
     "N_NAME" AS "N_NAME" @nullable(false) @hashValue("GH1"),
     "N_REGIONKEY" AS "N_REGIONKEY" @description("region"),
     "N_COMMENT" AS "N_COMMENT" @defaultValue("NA"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique"),
     {{ get_hash('GH') }}::STRING AS HASH_COL1,
     {{ get_hash('GH1') }}::STRING AS HASH_COL2
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"