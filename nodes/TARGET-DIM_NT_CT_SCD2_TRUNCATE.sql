@id("dc5b58d1-05d9-4c3a-a4cc-31b1d7d7b14e")
@nodeType("SQLDimension")
@mergeStrategy("changeTracking")
@writeMode("truncateInsert")
SELECT
    0                                        AS "DIM_NT_CT_SCD2_TRUNCATE_KEY" @id("6c7177") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"                   @id("30ddd6") @isBusinessKey,
    "name"                                   AS "name"                        @id("81a66b") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"                   @id("cea613") @isChangeTracking,
    "CommenT"                                AS "CommenT"                     @id("f9818f"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"            @id("f10de3"),
    1                                        AS "SYSTEM_VERSION"              @id("43d641") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"         @id("bbe2fd") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"          @id("da4f82") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"          @id("ea29a2") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"             @id("0dfd48") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
