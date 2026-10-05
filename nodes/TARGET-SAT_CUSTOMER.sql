@id("9ab7855d-04fa-440e-8777-51545437a6e6")
@nodeType("718")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY HK_CUSTOMER HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_CUSTOMER"                        AS "HK_CUSTOMER"         @id("275568") @isBusinessKey @not_null,
    "S"."HASHDIFF_CUSTOMER"                  AS "HASHDIFF_CUSTOMER"   @id("fc4746") @isChangeTracking @not_null,
    "S"."C_NAME"                             AS "C_NAME"              @id("03cede"),
    "S"."C_ADDRESS"                          AS "C_ADDRESS"           @id("80742a"),
    "S"."C_PHONE"                            AS "C_PHONE"             @id("d8a31f"),
    "S"."C_ACCTBAL"                          AS "C_ACCTBAL"           @id("063199"),
    "S"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"        @id("65b11a"),
    "S"."C_COMMENT"                          AS "C_COMMENT"           @id("a581c6"),
    "S"."RECORD_SOURCE"                      AS "RECORD_SOURCE"       @id("d49925"),
    1                                        AS "SYSTEM_VERSION"      @id("1f8153") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("18b0ea") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "LOAD_DTS"            @id("8dbf86") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("458b83") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "LOAD_END_DTS"        @id("523e5e") @isSystemEndDate
FROM {{ ref('TARGET', 'STG_DV_CUSTOMER') }} "S"
