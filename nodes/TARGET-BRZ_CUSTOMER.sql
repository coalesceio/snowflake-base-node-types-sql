@id("13cfe869-27ff-43f7-a90f-fb725ce94e76")
@nodeType("SQLWork")
@description("Bronze: raw copy of SRC.CUSTOMER with a load timestamp")
@writeMode("truncateInsert")
SELECT
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @id("425483"),
    "C_NAME"                                 AS "C_NAME"              @id("5c8bf0"),
    "C_ADDRESS"                              AS "C_ADDRESS"           @id("f7f397"),
    "C_NATIONKEY"                            AS "C_NATIONKEY"         @id("97a334"),
    "C_PHONE"                                AS "C_PHONE"             @id("2e6006"),
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @id("4bf11c"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"        @id("08b38e"),
    "C_COMMENT"                              AS "C_COMMENT"           @id("543d43"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "LOAD_TS"             @id("804371") @description("Time the row was loaded into bronze")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
