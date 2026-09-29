@id("580fe962-2bfb-462e-8858-154e57eae8ca")
@nodeType("718")
@description("TC18 - changeTracking SCD1 with renamed system columns (incl. optional version/flag/end date) and no surrogate key (no warning expected)")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @id("499285") @isBusinessKey @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @id("e1f650"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("3f6e07"),
     "N_COMMENT" AS "N_COMMENT" @id("f775e6"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("ecf201"),
     "N_DATE" AS "N_DATE" @id("76ca35"),
     1 AS "DW_VERSION" @id("ebaf8b") @isSystemVersion @accepted_values(1),
     'Y' AS "DW_IS_CURRENT" @id("3ed6ec") @isSystemCurrentFlag @accepted_values("'Y'"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "DW_INSERTED_AT" @id("1a5aa6") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "DW_MODIFIED_AT" @id("8234c5") @isSystemUpdateDate @relative_time(">=", "DW_INSERTED_AT"),
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "DW_VALID_TO" @id("6531c6") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
