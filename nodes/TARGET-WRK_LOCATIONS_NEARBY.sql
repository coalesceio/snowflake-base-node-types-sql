@id("10c835f1-972b-4234-a91b-652ce0810973")
@nodeType("704")
@description("Locations within 50 km of the reference point POINT(77.5946 12.9716), with distance in kilometers")
SELECT
     "LOCATION_ID" AS "LOCATION_ID",
     "LOCATION_NAME" AS "LOCATION_NAME",
     "LOCATION" AS "LOCATION",
     ST_DISTANCE("LOCATION", TO_GEOGRAPHY('POINT(77.5946 12.9716)')) / 1000 AS "DISTANCE_KM" @description("Distance in kilometers between LOCATION and the reference point POINT(77.5946 12.9716)")
FROM {{ ref('TARGET', 'LOCATIONS') }} "LOCATIONS"
WHERE ST_DISTANCE("LOCATION", TO_GEOGRAPHY('POINT(77.5946 12.9716)')) <= 50000
