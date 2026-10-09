@id("c53149df-e415-4e1f-b2f2-9b2c67e57a07")
@nodeType("Latest220:::SQLFact")
SELECT
    "NAtionKey"                          AS "NAtionKey"          @id("6dd160"),
    "name"                               AS "name"               @id("14ed1f"),
    "REGIONKEY"                          AS "REGIONKEY"          @id("a5b98f"),
    "CommenT"                            AS "CommenT"            @id("cfd088"),
    "N_Load_Timestamp"                   AS "N_Load_Timestamp"   @id("ea15fc"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("ca1a5e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e9bb9d") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"