@id("323d7aa8-8de0-4afc-b638-7cf8beddf710")
@nodeType("SQLFact")
SELECT
    "DIM_CUSTOMER_GEO_SCD1_KEY"          AS "DIM_CUSTOMER_GEO_SCD1_KEY" @id("95d75e"),
    "C_CUSTKEY"                          AS "C_CUSTKEY"                 @id("f7afbe"),
    "C_NAME"                             AS "C_NAME"                    @id("9d6850"),
    "C_MKTSEGMENT"                       AS "C_MKTSEGMENT"              @id("7cc386"),
    "C_ACCTBAL"                          AS "C_ACCTBAL"                 @id("f45b44"),
    "N_NATIONKEY"                        AS "N_NATIONKEY"               @id("8507f4"),
    "N_NAME"                             AS "N_NAME"                    @id("1f02d1"),
    "R_REGIONKEY"                        AS "R_REGIONKEY"               @id("54c7f6"),
    "R_NAME"                             AS "R_NAME"                    @id("ff4973"),
    "SYSTEM_CREATE_DATE"                 AS "SYSTEM_CREATE_DATE"        @id("cc8611"),
    "SYSTEM_UPDATE_DATE"                 AS "SYSTEM_UPDATE_DATE"        @id("86b027"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"        @id("c9b291") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"        @id("a5eb2b") @isSystemUpdateDate
FROM {{ ref('TARGET', 'DIM_CUSTOMER_GEO_SCD1') }} "DIM_CUSTOMER_GEO_SCD1"