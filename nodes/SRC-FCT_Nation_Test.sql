@id("84deee8c-895a-4ac6-ac12-34dab0483ca7")
@nodeType("Latest220:::SQLFact")
SELECT
    "NAtionKey"                          AS "NAtionKey"          @id("2a3a6d"),
    "name"                               AS "name"               @id("c2b4a6"),
    "REGIONKEY"                          AS "REGIONKEY"          @id("117b21"),
    "CommenT"                            AS "CommenT"            @id("447c2f"),
    "N_Load_Timestamp"                   AS "N_Load_Timestamp"   @id("08df8a"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("86acf4") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("dcac5c") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"