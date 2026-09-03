@id("3fc0b050-3eb4-420f-9d1a-561ab12a10ed")
@nodeType("707")
@description("V1 Stage -> V2 Work -> V1 Stage pipeline example")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", true, "After")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @not_null,
     "N_REGIONKEY" AS "N_REGIONKEY" @min_max("0", "4")
FROM {{ ref('TARGET', 'STG_NATION_STAGE_RENAME') }} "STG_NATION_STAGE_RENAME"