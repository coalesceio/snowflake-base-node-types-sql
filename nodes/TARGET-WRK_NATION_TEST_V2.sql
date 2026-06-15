@id("4363ad8c-aa3e-46a7-9bfa-5192fb78fd67")
@nodeType("664")
@truncateBefore(true)
@selectDistinct(true)
@orderby(true)
@orderbycolumn("[object Object]", "desc")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @hashValue("GH_COL"),
     "N_NAME" AS "N_NAME" @defaultValue("NA")  @hashValue("GH_COL"),
     "N_REGIONKEY" AS "N_REGIONKEY" @description("region key")  @hashValue("GH_COL"),
     "N_COMMENT" AS "N_COMMENT" @hashValue("GH_COL"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique") @hashValue("GH_COL"),
     {{ get_hash('GH_COL', 'SHA256', '~') }}::STRING AS "GH_COL"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"