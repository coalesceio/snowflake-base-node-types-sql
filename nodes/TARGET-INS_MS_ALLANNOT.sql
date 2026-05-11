@id("186fae27-6e9f-490d-9c19-bd34a489b027")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@truncateBefore
@selectDistinct

@preSQL("SELECT count(*) FROM {{ this }}", "SELECT count(*) FROM {{ this }}") 
@postSQL("SELECT count(*) FROM {{ this }}", "SELECT count(*) FROM {{ this }}") 


@preTests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "continuEOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1") 

@postTests("continueOnFailure: SELECT * FROM {{ this }} WHERE N_NAME IS NULL", "SELECT * FROM {{ this }} WHERE N_REGIONKEY < 0") 

WITH ALL_TABLES AS (
     SELECT * FROM {{ ref('SRC', 'NATION_COPY1') }} "NATION_COPY1"
     UNION
     SELECT * FROM {{ ref('SRC', 'NATION_COPY2') }} "NATION_COPY2"
)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false) @defaultValue(200) @tests("null", "unique") @hashValue("GH_NATIONKEY"),
     "N_NAME" AS "N_NAME" @nullable("false") @description("column1 comment") @defaultValue("NA") @tests("null"),
     "N_REGIONKEY" AS "N_REGIONKEY" @description("column2 comment") @defaultValue("199") @tests("unique"),
     "N_COMMENT" AS "N_COMMENT" @defaultValue("'DEFAULT'"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_NATIONKEY', 'MD5') }}::STRING AS "GH_NATIONKEY"
FROM ALL_TABLES