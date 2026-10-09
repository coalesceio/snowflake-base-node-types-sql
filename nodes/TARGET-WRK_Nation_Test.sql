@id("e99da43d-45ce-43a6-8bd9-ad6f4ce21e90")
@nodeType("Latest220:::SQLWork")
@description("Staging copy of Nation_Test with data quality checks and a row hash")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} HAVING COUNT(*) = 0", false, "Before")
@tests("SELECT 1 FROM {{ this }} HAVING COUNT(*) <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @description("Nation identifier") @not_null @uniqueness @min_value(1) @inHash("ROW_HASH", 1),
    "name"                                   AS "name"                @description("Nation name") @not_null @empty @inHash("ROW_HASH", 2),
    "REGIONKEY"                              AS "REGIONKEY"           @description("Region the nation belongs to") @not_null @min_max(0, 4) @inHash("ROW_HASH", 3),
    "CommenT"                                AS "CommenT"             @description("Free-text comment") @inHash("ROW_HASH", 4),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @description("When the row was loaded into the source") @not_null @max_value("CURRENT_TIMESTAMP"),
    {{ get_hash('ROW_HASH') }}::STRING       AS "ROW_HASH"            @description("SHA1 hash of the nation attributes, for change comparison")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
