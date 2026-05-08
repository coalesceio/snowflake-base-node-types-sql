@id("9f77431d-2220-4a12-a943-b963775ee6ff")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")

@zeroKey("string:{{ parameters.defaultString }}", "number:100", "boolean:True", "datetime:1999-12-31")

SELECT
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @description("nation key") @defaultValue("100") @tests("null", "unique") @hashValue("GH_Col") @isBusinessKey,
     NATION."N_NAME" AS "N_NAME",
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT",
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_Col') }}::STRING AS "GH_Col"
FROM {{ ref('SRC', 'NATION') }} "NATION"