@id("d761c18f-6aad-4118-9393-b54d42339829")
@nodeType("718")
@description("TC43 - multi-source direct join without a CTE (CUSTOMER x NATION_TEST), business key C_CUSTKEY")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1", false)
SELECT
     0 AS "DIM_TC43_MS_DIRECT_JOIN_CT_SCD1_KEY" @id("cc9a27") @isSurrogateKey,
     "C"."C_CUSTKEY" AS "C_CUSTKEY" @id("754906") @isBusinessKey @not_null @uniqueness,
     "C"."C_NAME" AS "C_NAME" @id("91f4c4") @not_null,
     "C"."C_MKTSEGMENT" AS "C_MKTSEGMENT" @id("8eafea"),
     "C"."C_ACCTBAL" AS "C_ACCTBAL" @id("18127e"),
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("16eaa9") @not_null,
     "N"."N_NAME" AS "N_NAME" @id("11c853"),
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("1b3a3b") @min_max(0, 4),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("305b09") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d974d") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'NATION_TEST') }} "N" ON "C"."C_NATIONKEY" = "N"."N_NATIONKEY"
