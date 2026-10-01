@id("7e57a000-0000-4000-8000-000000000009")
@nodeType("724")
@mergeStrategy("changeTracking")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea091") @isBusinessKey,
    "name"                                   AS "name"                @id("7ea092"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea093"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea094"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea09e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7ea09f") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
