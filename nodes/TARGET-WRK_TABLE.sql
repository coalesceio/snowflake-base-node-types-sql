@id("ef23dea2-46c4-4015-89c6-f5b1fcbb7a64")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(),
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @hashValue("GH_Col"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_Col') }}::STRING AS "GH_Col"
FROM {{ ref('SRC', 'NATION') }} "NATION"