@id("63b04610-7dd9-4695-bc69-062062f58bb9")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 2 nation dimension enriched with its region; a change to nation name, region key or region name expires the current version and inserts a new one")
WITH "NATION_CTE" AS (
    SELECT "N_NATIONKEY", "N_NAME", "N_REGIONKEY", "N_COMMENT"
    FROM {{ ref('SRC', 'NATION') }}
),
"REGION_CTE" AS (
    SELECT "R_REGIONKEY", "R_NAME", "R_COMMENT"
    FROM {{ ref('SRC', 'REGION') }}
)
SELECT
    0                                                AS "DIM_NATION_REGION_SCD2_KEY" @id("1cbf31") @isSurrogateKey,
    CAST("NATION_CTE"."N_NATIONKEY" AS NUMBER(38,0)) AS "N_NATIONKEY"                @id("70c420") @isBusinessKey,
    CAST("NATION_CTE"."N_NAME" AS VARCHAR(25))       AS "N_NAME"                     @id("f1dc76") @isChangeTracking,
    CAST("NATION_CTE"."N_REGIONKEY" AS NUMBER(38,0)) AS "N_REGIONKEY"                @id("88e71c") @isChangeTracking,
    CAST("REGION_CTE"."R_NAME" AS VARCHAR(25))       AS "R_NAME"                     @id("afd0b3") @isChangeTracking,
    CAST("NATION_CTE"."N_COMMENT" AS VARCHAR(152))   AS "N_COMMENT"                  @id("07a245"),
    CAST("REGION_CTE"."R_COMMENT" AS VARCHAR(152))   AS "R_COMMENT"                  @id("f5b031"),
    1                                                AS "SYSTEM_VERSION"             @id("7ae59d") @isSystemVersion,
    'Y'                                              AS "SYSTEM_CURRENT_FLAG"        @id("bc5c71") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)             AS "SYSTEM_CREATE_DATE"         @id("f7c6a2") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)             AS "SYSTEM_UPDATE_DATE"         @id("03ca64") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP)         AS "SYSTEM_END_DATE"            @id("595797") @isSystemEndDate
FROM "NATION_CTE"
LEFT JOIN "REGION_CTE"
    ON "NATION_CTE"."N_REGIONKEY" = "REGION_CTE"."R_REGIONKEY"
