@id("1965e61a-20c1-4a9a-a2ac-6967b8cfa6b0")
@nodeType("707")
@description("Work table on Nation_Test exercising node-level and column-level data quality tests")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} WHERE ""REGIONKEY"" IS NULL")
SELECT
    "NAtionKey"                              AS "NAtionKey"        @id("af7bce") @not_null @uniqueness @min_max("0", "24") @description("Nation business identifier from the source"),
    "name"                                   AS "name"             @id("1f9cfb") @not_null @empty @description("Nation name"),
    "REGIONKEY"                              AS "REGIONKEY"        @id("663c48") @accepted_values("0, 1, 2, 3, 4") @description("Identifier of the region the nation belongs to"),
    "CommenT"                                AS "CommenT"          @id("72ec5b") @rejected_values("'NA'") @description("Free-text comment about the nation"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp" @id("76b5fe") @freshness(30, "DAY") @relative_time("<=", "LOAD_TS") @description("Timestamp when the row was loaded into the source"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP_LTZ) AS "LOAD_TS"          @id("fe4680") @not_null @description("Timestamp when the row was loaded into the work table"),
    "REGIONKEY" * 10                         AS "REGION_SCORE"     @id("19a1b6") @min_value("0") @max_value("40") @description("Derived region score (REGIONKEY x 10)")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
