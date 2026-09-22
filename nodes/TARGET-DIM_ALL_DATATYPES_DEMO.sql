@id("55c002b6-27b8-4348-9cdd-c6e6e366472b")
@nodeType("718")
@mergeStrategy("changeTracking")
@zeroKey(12)
SELECT
  0 AS "DIM_ALL_DATATYPES_DEMO_KEY" @isSurrogateKey,
  COL_NUMBER @isBusinessKey @zeroKey(100),
  COL_DECIMAL @zeroKey("1.11"),
  COL_INT @zeroKey(200),
  COL_FLOAT @zeroKey(2.22),
  COL_DOUBLE @zeroKey(3.33),
  COL_BOOLEAN @zeroKey(false),
  COL_VARCHAR,
  COL_STRING @zeroKey("'Hi'"),
  COL_CHAR @zeroKey("'Hi'"),
  COL_TEXT @zeroKey("'Hi'"),
  COL_DATE,
  COL_TIME  @isBusinessKey,
  COL_TIMESTAMP,
  COL_TIMESTAMP_NTZ,
  COL_TIMESTAMP_LTZ,
  COL_TIMESTAMP_TZ,
  COL_BINARY,
  COL_VARIANT,
  COL_OBJECT,
  COL_ARRAY,
  COL_GEOGRAPHY,
  COL_GEOMETRY,
  COL_XML,
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
  CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref("SRC", "ALL_DATATYPES_DEMO") }}
