@id("52abe37b-67cd-45e8-8205-72b648a6362d")
@nodeType("707")
@disableTests
@description("Work table on Nation_Test with tests configured but skipped via disableTests")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1")
SELECT
    "NAtionKey"        AS "NAtionKey"        @id("87d4a7") @not_null @uniqueness @description("Nation business identifier from the source"),
    "name"             AS "name"             @id("183033") @not_null @description("Nation name"),
    "REGIONKEY"        AS "REGIONKEY"        @id("7d664c") @description("Identifier of the region the nation belongs to"),
    "CommenT"          AS "CommenT"          @id("d6047d") @description("Free-text comment about the nation"),
    "N_Load_Timestamp" AS "N_Load_Timestamp" @id("577499") @description("Timestamp when the row was loaded into the source")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
