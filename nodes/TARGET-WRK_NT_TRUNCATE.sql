@id("397418f1-8884-488a-a186-ead64f4ced11")
@nodeType("707")
@materializationType("table")
@writeMode("truncateInsert")
@description("Work table on Nation_Test that replaces its contents on every run (explicit truncateInsert)")
SELECT
    "NAtionKey"        AS "NAtionKey"        @id("efaeec") @description("Nation business identifier from the source"),
    "name"             AS "name"             @id("4eee19") @description("Nation name"),
    "REGIONKEY"        AS "REGIONKEY"        @id("1b4901") @description("Identifier of the region the nation belongs to"),
    "CommenT"          AS "CommenT"          @id("9c49b5") @description("Free-text comment about the nation"),
    "N_Load_Timestamp" AS "N_Load_Timestamp" @id("f11794") @description("Timestamp when the row was loaded into the source")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
