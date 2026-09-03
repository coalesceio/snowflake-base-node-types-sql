@id("2458e365-07f6-4d66-9518-f4202b255021")
@nodeType("704")
@description("Pairwise distance in kilometers between every distinct pair of locations, via a self cross join on LOCATIONS")
SELECT
     L1."LOCATION_ID" AS "LOCATION_ID_1",
     L1."LOCATION_NAME" AS "LOCATION_NAME_1",
     L2."LOCATION_ID" AS "LOCATION_ID_2",
     L2."LOCATION_NAME" AS "LOCATION_NAME_2",
     ST_DISTANCE(L1."LOCATION", L2."LOCATION") / 1000 AS "DISTANCE_KM" @description("Distance in kilometers between LOCATION_ID_1 and LOCATION_ID_2")
FROM {{ ref('TARGET', 'LOCATIONS') }} L1
CROSS JOIN {{ ref('TARGET', 'LOCATIONS') }} L2
WHERE L1."LOCATION_ID" < L2."LOCATION_ID"
