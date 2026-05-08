@id("9769741f-a1fe-452c-b970-5e9b9d75f72b")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@selectDistinct
@truncateBefore
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @description("nation key") @defaultValue("100") @tests("null", "unique") @hashValue("GH_Col"),
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_Col') }}::STRING AS "GH_Col"
FROM {{ ref('SRC', 'NATION') }} "NATION"