@id("36bcec1c-5f00-48de-8156-b87fa5714651")
@nodeType("SQLFact")
SELECT
    "NAtionKey"                          AS "NAtionKey"          @id("d41482") @isBusinessKey,
    "name"                               AS "name"               @id("0f7013"),
    "REGIONKEY"                          AS "REGIONKEY"          @id("061512"),
    "CommenT"                            AS "CommenT"            @id("9752b1"),
    "N_Load_Timestamp"                   AS "N_Load_Timestamp"   @id("4b8f72"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("fedc39") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("5ac9ad") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test_CamelCase') }} "Nation_Test_CamelCase"