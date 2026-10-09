@id("8b0b28e2-1159-468b-ad09-5896ade465b7")
@nodeType("Latest220:::SQLDimension")
@description("Gold: nation dimension - SCD1, overwritten in place")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "GLD_DIM_NATION_KEY"  @id("bbaaa7") @description("Surrogate key") @isSurrogateKey,
    "NATION_KEY"                             AS "NATION_KEY"          @id("129be5") @description("Nation identifier") @isBusinessKey,
    "NATION_NAME"                            AS "NATION_NAME"         @id("e25825") @description("Nation name"),
    "REGION_KEY"                             AS "REGION_KEY"          @id("7ec5fb") @description("Region key"),
    "NATION_COMMENT"                         AS "NATION_COMMENT"      @id("d47bd0") @description("Free-text comment"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("4d4a09") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("c09379") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_NATION') }} "SLV_NATION"
