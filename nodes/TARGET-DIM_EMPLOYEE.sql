@id("59a9fb72-4418-4bcb-b6fc-f55c66a38fe3")
@nodeType("SQLDimension")
@materializationType("table")
@tag("PII", "NAME", "GOV")
@description("Employee training - employee dimension (change tracking, SCD2 on department and location)")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tests("SELECT EMPLOYEE_ID FROM {{ ref('TARGET', 'WRK_EMPLOYEE') }} GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1 OR EMPLOYEE_ID IS NULL", false, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1", false, "After")
SELECT
    0 AS "DIM_EMPLOYEE_KEY" @id("0e21ba30-166b-4287-ac67-249774360cde") @isSurrogateKey,
    "E"."EMPLOYEE_ID" AS "EMPLOYEE_ID" @id("43ae7f35-930c-4ac2-815b-3e96f885742e") @isBusinessKey @clusterKey(2),
    "E"."EMPLOYEE_NAME" AS "EMPLOYEE_NAME" @id("041f3a28-c50e-4503-8a51-73f327531179"),
    "E"."DEPARTMENT" AS "DEPARTMENT" @id("324f57c8-6cf7-4bca-a2b3-dab1cb1bcfd4") @isChangeTracking @clusterKey(1) @zeroKey("'N/A'"),
    "E"."LOCATION" AS "LOCATION" @id("8da6ceb2-12ac-4909-9fa5-395a06bbfd86") @isChangeTracking @zeroKey("'N/A'") @clusterKey(3),
    1 AS "SYSTEM_VERSION" @id("802e5640-e723-4cd9-afe6-e990abfac3d1") @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @id("bc6fb771-5f65-4652-9bae-df866a6bb30d") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("7409edb0-2d77-4f6d-9d5b-68e7c052c8be") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("1c0d3e84-1101-4a49-958e-4ab15c28c8ea") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("7b378a06-5707-42c8-9238-cab9b68ef388") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_EMPLOYEE') }} "E"
