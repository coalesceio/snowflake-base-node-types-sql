@id("6488b4bf-c47e-45b6-8df6-3d63816ce649")
@nodeType("718")
@disableIDs
@mergeStrategy("lastModified")
SELECT
  0 AS "DIM_NATION_FRESH_KEY" @isSurrogateKey,
  N_NATIONKEY @isBusinessKey,
  N_REGIONKEY @isBusinessKey,
  N_NAME,
  N_COMMENT,
  N_LOAD_TIMESTAMP @lastModifiedTracking(2),
  1 AS "SYSTEM_VERSION" @isSystemVersion,
  'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
  CAST('9999-12-31 23:59:59' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref("SRC", "NATION_TEST") }}
