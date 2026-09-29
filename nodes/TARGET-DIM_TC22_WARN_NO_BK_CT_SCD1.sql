@id("fda2c33e-5f2a-4273-9dd8-36a38da9b85e")
@nodeType("718")
@description("TC22 - NEGATIVE: changeTracking SCD1 with no @isBusinessKey (expect Missing Business Key)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC22_WARN_NO_BK_CT_SCD1_KEY" @id("647925") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("605e93"),
     "N_NAME" AS "N_NAME" @id("6704bb"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("b15fbf"),
     "N_COMMENT" AS "N_COMMENT" @id("f827d2"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("b082fb"),
     "N_DATE" AS "N_DATE" @id("638ce8"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("009a7a") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("5a3ccd") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
