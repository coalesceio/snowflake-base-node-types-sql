@id("e9ed640d-cca7-44f9-b31e-b150c93f3e01")
@nodeType("SQLFact")
SELECT
    "NAtionKey"                          AS "NAtionKey"          @id("fbbd02"),
    "name"                               AS "name"               @id("f57aa3"),
    "REGIONKEY"                          AS "REGIONKEY"          @id("f3ad0f"),
    "CommenT"                            AS "CommenT"            @id("eb6fcf"),
    "N_Load_Timestamp"                   AS "N_Load_Timestamp"   @id("5f35bd"),
    "SYSTEM_CREATE_DATE"                 AS "SYSTEM_CREATE_DATE" @id("c846ea"),
    "SYSTEM_UPDATE_DATE"                 AS "SYSTEM_UPDATE_DATE" @id("1d309c"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("3064d7") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("3b5bef") @isSystemUpdateDate
FROM {{ ref('TARGET', 'FCT_Nation_Test') }} "FCT_Nation_Test"