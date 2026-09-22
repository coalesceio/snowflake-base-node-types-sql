@id("49706c21-3694-45d1-ae71-6a145d5c9d85")
@nodeType("718")
@mergeStrategy("lastModified")
@zeroKey(0, "'UNKNOWN'", "1900-01-01 00:00:00", true)
SELECT
  0 AS "DIM_NATION_TEST_KEY" @id("6ea530") @isSurrogateKey,
  N_NATIONKEY @id("28fc46") @zeroKey(100),
  N_NAME @id("2e3888") @zeroKey("'N/A'"),
  N_REGIONKEY @id("5d649c"),
  N_COMMENT @id("4b00d9"),
  N_LOAD_TIMESTAMP @id("54ec2a") @lastModifiedTracking(1),
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("3030b3") @isSystemCreateDate,
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("3198b0") @isSystemUpdateDate
FROM {{ ref("SRC", "NATION_TEST") }}