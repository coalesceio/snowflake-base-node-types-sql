@id("ab2e2d2a-1325-46a7-a397-6025e3aadd04")
@nodeType("SQLWork")
SELECT
     "NAtionKey" AS "NAtionKey",
     "name" AS "name",
     "REGIONKEY" AS "REGIONKEY",
     "CommenT" AS "CommenT",
     "N_Load_Timestamp" AS "N_Load_Timestamp"
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"