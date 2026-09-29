@id("ccb27953-f34c-464b-9f33-5722e3edc793")
@nodeType("718")
@description("TC38 - multiple @preSQL and @postSQL statements run in order around a lastModified SCD1 load")
@mergeStrategy("lastModified")
@preSQL("ALTER SESSION SET QUERY_TAG = 'DIM_TC38_PRE_POST_SQL'")
@preSQL("SELECT COUNT(*) FROM {{ this }}")
@postSQL("DELETE FROM {{ this }} WHERE N_NATIONKEY IS NULL")
@postSQL("ALTER SESSION UNSET QUERY_TAG")
SELECT
     0 AS "DIM_TC38_PRE_POST_SQL_KEY" @id("5f5b5e") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("c53404") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("4a2ec6"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("092de5"),
     "N_COMMENT" AS "N_COMMENT" @id("908bb5"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("ecef04") @lastModifiedTracking(1),
     "N_DATE" AS "N_DATE" @id("087166"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d067fb") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("2d707e") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
