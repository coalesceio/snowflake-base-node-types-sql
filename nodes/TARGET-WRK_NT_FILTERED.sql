@id("f386635e-e246-45de-a19f-97a355743408")
@nodeType("707")
@deployDisabled
@description("Work table on Nation_Test filtered to regions 0-2 with a derived CASE column; excluded from deployment")
SELECT
    "NAtionKey"                                                 AS "NAtionKey"        @id("535d01") @description("Nation business identifier from the source"),
    "name"                                                      AS "name"             @id("b652b2") @description("Nation name"),
    "REGIONKEY"                                                 AS "REGIONKEY"        @id("6c0236") @description("Identifier of the region the nation belongs to"),
    "CommenT"                                                   AS "CommenT"          @id("62d174") @description("Free-text comment about the nation"),
    "N_Load_Timestamp"                                          AS "N_Load_Timestamp" @id("744b80") @description("Timestamp when the row was loaded into the source"),
    CASE WHEN "REGIONKEY" IN (0, 1) THEN 'WEST' ELSE 'EAST' END AS "REGION_GROUP"     @id("bcb750") @accepted_values("'WEST', 'EAST'") @description("Derived region grouping")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
WHERE "REGIONKEY" <= 2
