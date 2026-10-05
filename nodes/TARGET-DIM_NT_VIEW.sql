@id("bb16244f-cb9b-45d1-9fe4-9dd8c5087591")
@nodeType("SQLDimension")
@materializationType("view")
SELECT
    0                                        AS "DIM_NT_VIEW_KEY"     @id("24db2f"),
    "NAtionKey"                              AS "NAtionKey"           @id("cbe3dc"),
    "name"                                   AS "name"                @id("4c3b7b"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("037231"),
    "CommenT"                                AS "CommenT"             @id("60e933"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("b9f3c5"),
    1                                        AS "SYSTEM_VERSION"      @id("e7e098"),
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("66516f"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("d4459a"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("6a886d"),
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("878f62")
FROM {{ ref('SRC', 'Nation_Test_CamelCase') }} "Nation_Test_CamelCase"
