@id("1fb236a3-f6f8-4570-a415-15f5ca52c62c")
@nodeType("718")
@description("TC17 - changeTracking SCD2 with renamed system columns and no @isSurrogateKey (expect RECOMMENDED warning)")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE DW_IS_CURRENT = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @id("17e4e7") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("e551d2") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("bd2ec3"),
     "N_COMMENT" AS "N_COMMENT" @id("6687a6"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("1b2690"),
     "N_DATE" AS "N_DATE" @id("5ac5e3"),
     1 AS "DW_VERSION" @id("a02365") @isSystemVersion @min_value(1),
     'Y' AS "DW_IS_CURRENT" @id("31bf48") @isSystemCurrentFlag @accepted_values("'Y', 'N'"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "DW_VALID_FROM" @id("10db2c") @isSystemCreateDate @relative_time("<=", "DW_VALID_TO"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "DW_UPDATED_AT" @id("37b84f") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "DW_VALID_TO" @id("da7d3c") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
