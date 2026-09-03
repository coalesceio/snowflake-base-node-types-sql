@id("51a59613-546f-4186-8b02-e93293835ec4")
@nodeType("704")
@materializationType("table")
@description("Nation records joined with their region, combining nation and region attributes into a single table")
@postSQL("CREATE OR REPLACE SEMANTIC VIEW {{ ref_no_link('TARGET', 'NATION_REGION_JOIN_SV') }}
  TABLES (
    NATION_REGION AS {{ ref_no_link('TARGET', 'NATION_REGION_JOIN') }}
      PRIMARY KEY (NATION_KEY)
      COMMENT = 'Nation joined with its region'
  )
  DIMENSIONS (
    NATION_REGION.NATION_NAME AS NATION_NAME COMMENT = 'Nation name',
    NATION_REGION.REGION_NAME AS REGION_NAME COMMENT = 'Region name'
  )
  METRICS (
    NATION_REGION.NATION_COUNT AS COUNT(NATION_REGION.NATION_KEY) COMMENT = 'Count of nations per region'
  )
  COMMENT = 'Semantic view over NATION_REGION_JOIN combining nation and region attributes'")
SELECT
     N."N_NATIONKEY" AS "NATION_KEY" @description("Unique identifier for the nation"),
     N."N_NAME" AS "NATION_NAME" @description("Nation name"),
     N."N_REGIONKEY" AS "REGION_KEY" @description("Foreign key to the nation's region, shared join key with WRK_REGION"),
     R."R_NAME" AS "REGION_NAME" @description("Region name"),
     N."N_COMMENT" AS "NATION_COMMENT" @description("Free-text comment about the nation"),
     R."R_COMMENT" AS "REGION_COMMENT" @description("Free-text comment about the region")
FROM {{ ref('TARGET', 'WRK_NATION') }} N
JOIN {{ ref('TARGET', 'WRK_REGION') }} R ON N."N_REGIONKEY" = R."R_REGIONKEY"
