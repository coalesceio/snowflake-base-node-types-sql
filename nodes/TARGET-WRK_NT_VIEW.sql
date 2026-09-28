@id("dd03ca59-5f5c-4964-9efd-61dddecf324a")
@nodeType("707")
@materializationType("view")
@description("Work view on Nation_Test")
SELECT
    "NAtionKey"        AS "NAtionKey"        @id("7cc252") @description("Nation business identifier from the source"),
    "name"             AS "name"             @id("031cac") @description("Nation name"),
    "REGIONKEY"        AS "REGIONKEY"        @id("fd9ebd") @description("Identifier of the region the nation belongs to"),
    "CommenT"          AS "CommenT"          @id("007525") @description("Free-text comment about the nation"),
    "N_Load_Timestamp" AS "N_Load_Timestamp" @id("c0e912") @description("Timestamp when the row was loaded into the source")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
