@id("c8ab1537-b0a6-4df9-a9f0-2fbaec11d54e")
@nodeType("707")
@description("Work table on Nation_Test generating hash keys with inHash and get_hash")
SELECT
    "NAtionKey"                                                       AS "NAtionKey"        @id("e20102") @inHash("HK_NATION", 1, "HD_NATION", 1) @description("Nation business identifier from the source"),
    "name"                                                            AS "name"             @id("e0a6be") @inHash("HK_NATION", 2, "HD_NATION", 2) @description("Nation name"),
    "REGIONKEY"                                                       AS "REGIONKEY"        @id("1b800c") @inHash("HD_NATION", 3) @description("Identifier of the region the nation belongs to"),
    "CommenT"                                                         AS "CommenT"          @id("56b8d1") @inHash("HD_NATION", 4) @description("Free-text comment about the nation"),
    "N_Load_Timestamp"                                                AS "N_Load_Timestamp" @id("ac22f6") @description("Timestamp when the row was loaded into the source"),
    {{ get_hash('HK_NATION') }}::STRING                               AS "HK_NATION"        @id("afc103") @description("SHA1 hash key of NAtionKey and name"),
    {{ get_hash('HD_NATION', algo='SHA256', delimiter='~') }}::STRING AS "HD_NATION"        @id("496a5b") @description("SHA256 hash diff of all descriptive columns")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
