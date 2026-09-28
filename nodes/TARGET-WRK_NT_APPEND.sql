@id("62dc83fe-74d1-4af4-a7bc-e4644b388926")
@nodeType("707")
@writeMode("append")
@description("Work table on Nation_Test that appends rows on every run, with pre- and post-load SQL")
@preSQL("DELETE FROM {{ this }} WHERE ""N_Load_Timestamp"" < DATEADD(DAY, -90, CURRENT_TIMESTAMP())")
@postSQL("DELETE FROM {{ this }} WHERE ""NAtionKey"" IS NULL")
SELECT
    "NAtionKey"                          AS "NAtionKey"        @id("08006b") @description("Nation business identifier from the source"),
    "name"                               AS "name"             @id("68754c") @description("Nation name"),
    "REGIONKEY"                          AS "REGIONKEY"        @id("58c51b") @description("Identifier of the region the nation belongs to"),
    "CommenT"                            AS "CommenT"          @id("228ee3") @description("Free-text comment about the nation"),
    "N_Load_Timestamp"                   AS "N_Load_Timestamp" @id("363eba") @description("Timestamp when the row was loaded into the source"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_TS"          @id("d0a70a") @description("Timestamp when the row was appended")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
