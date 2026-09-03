@id("43a14a5a-65c1-4372-afbf-d9d83c897590")
@nodeType("707")
@materializationType("table")
@description("Nation records joined with their region, combining nation and region attributes into a single table")
WITH JON_CTE AS
(SELECT
     N.*,
     R."R_NAME" AS "REGION_NAME" ,
     R."R_COMMENT" AS "REGION_COMMENT",
     'ABCD' AS CONSTANT
FROM {{ ref('TARGET', 'WRK_NATION') }} N
JOIN {{ ref('TARGET', 'WRK_REGION') }} R ON N."N_REGIONKEY" = R."R_REGIONKEY"
)
SELECT * FROM JON_CTE;

