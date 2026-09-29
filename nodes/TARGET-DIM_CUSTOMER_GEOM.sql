@id("8a7235c3-eb63-4f47-8419-603b8b9361ba")
@nodeType("718")
@description("TEST: SCD1 dimension keyed on a GEOMETRY business key (safe_equals check)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_CUSTOMER_GEOM_KEY" @id("064565") @isSurrogateKey,
    ('POINT(' || "C_NATIONKEY" || ' ' || "C_CUSTKEY" || ')')::GEOMETRY AS "C_LOCATION" @id("7b47d4") @isBusinessKey,
    "C_CUSTKEY"                              AS "C_CUSTKEY" @id("16231d"),
    "C_NAME"                                 AS "C_NAME" @id("545297"),
    "C_ADDRESS"                              AS "C_ADDRESS" @id("8066e8"),
    "C_ACCTBAL"                              AS "C_ACCTBAL" @id("3eecb1"),
    1                                        AS "SYSTEM_VERSION" @id("e45826")        @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("7cf447")   @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE" @id("743304")    @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE" @id("0ed219")    @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
