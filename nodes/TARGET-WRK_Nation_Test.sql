@id("dfe04891-f88e-4d9a-a15b-41e7ec86ad0c")
@nodeType("SQLWork")
SELECT
     "NAtionKey" AS "NAtionKey",
     "name" AS "name1" @clusterKey(1, "trunc(""name1"", -5)"),
     "REGIONKEY" AS "REGIONKEY",
     "CommenT" AS "CommenT",
     "N_Load_Timestamp" AS "N_Load_Timestamp"
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"