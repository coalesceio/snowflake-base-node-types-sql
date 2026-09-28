@id("adcb9a8f-f117-4e9c-bde4-9798a01b87de")
@nodeType("707")
@description("Work table on Nation_Test with NOT NULL constraints and column default values")
SELECT
    "NAtionKey"        AS "NAtionKey"        @id("0eacdc") @notNull @description("Nation business identifier from the source"),
    "name"             AS "name"             @id("0f3166") @notNull @description("Nation name"),
    "REGIONKEY"        AS "REGIONKEY"        @id("13b485") @defaultValue("0") @description("Identifier of the region the nation belongs to"),
    "CommenT"          AS "CommenT"          @id("42d570") @defaultValue("'NA'") @description("Free-text comment about the nation"),
    "N_Load_Timestamp" AS "N_Load_Timestamp" @id("3f0bd5") @description("Timestamp when the row was loaded into the source")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
