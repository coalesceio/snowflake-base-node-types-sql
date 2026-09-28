@id("78e33474-79b3-4291-8284-b27a9cafec29")
@nodeType("707")
@description("Work table on Nation_Test using the default materialization (table) and write mode (truncateInsert)")
SELECT
    "NAtionKey"        AS "NAtionKey"        @id("171730") @description("Nation business identifier from the source"),
    "name"             AS "name"             @id("8e31d7") @description("Nation name"),
    "REGIONKEY"        AS "REGIONKEY"        @id("d1c837") @description("Identifier of the region the nation belongs to"),
    "CommenT"          AS "CommenT"          @id("fa6177") @description("Free-text comment about the nation"),
    "N_Load_Timestamp" AS "N_Load_Timestamp" @id("00c886") @description("Timestamp when the row was loaded into the source")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
