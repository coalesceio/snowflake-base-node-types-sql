@id("c12f1c4c-0aff-491f-899f-1d0cd0dee02e")
@nodeType("718")
@description("TC19 - lastModified SCD2 with renamed system columns and a non-default surrogate key name")
@mergeStrategy("lastModified")
SELECT
     0 AS "NATION_SID" @id("5233b6") @isSurrogateKey @uniqueness,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("8cdc0c") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("6bc9a2"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("5bfc11"),
     "N_COMMENT" AS "N_COMMENT" @id("52cbfa"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("9e6b67") @lastModifiedTracking(2),
     "N_DATE" AS "N_DATE" @id("a8d083"),
     1 AS "ROW_VERSION" @id("635395") @isSystemVersion,
     'Y' AS "IS_ACTIVE" @id("64e324") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "EFFECTIVE_FROM" @id("271cfa") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LAST_TOUCHED_AT" @id("239553") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "EFFECTIVE_TO" @id("e9484b") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
