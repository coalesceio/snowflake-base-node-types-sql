@id("97c932e0-d19d-444d-a408-a386dce83364")
@nodeType("Latest220:::SQLDimension")
@description("Gold: nation dimension - lastModified SCD1 on LOAD_TS")
@mergeStrategy("lastModified")
SELECT
    0                                        AS "GLD_DIM_NATION_LM_KEY" @id("b33bc1") @description("Surrogate key") @isSurrogateKey,
    "NATION_KEY"                             AS "NATION_KEY"            @id("51284e") @description("Nation identifier") @isBusinessKey,
    "NATION_NAME"                            AS "NATION_NAME"           @id("6a2302") @description("Nation name"),
    "REGION_KEY"                             AS "REGION_KEY"            @id("f8abd4") @description("Region key"),
    "LOAD_TS"                                AS "LOAD_TS"               @id("b0c80a") @description("Source load time - drives lastModified") @lastModifiedTracking(1),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"    @id("74361b") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"    @id("5f8f41") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_NATION') }} "SLV_NATION"
