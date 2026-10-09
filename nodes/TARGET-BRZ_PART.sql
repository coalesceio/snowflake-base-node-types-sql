@id("8fc3ec5a-72e9-5839-ba8b-7e78a61e196f")
@nodeType("Latest:::707")
@materializationType("table")
@description("Bronze part (Latest Work V2)")
SELECT
    "PART"."P_PARTKEY" AS "P_PARTKEY" @id("d91b95f2-8f7e-52ce-bb2f-1f57bc609400"),
    "PART"."P_NAME" AS "P_NAME" @id("0478b53f-ffb2-56f0-b715-f87ed19db8e2"),
    "PART"."P_MFGR" AS "P_MFGR" @id("5999f233-3f61-5972-b55e-5f36dc98781b"),
    "PART"."P_BRAND" AS "P_BRAND" @id("8259e370-9dc0-55b2-a846-4c4e8e918a30"),
    "PART"."P_TYPE" AS "P_TYPE" @id("78b160ee-9725-56a9-ad43-c80021af8518"),
    "PART"."P_SIZE" AS "P_SIZE" @id("07882e30-5327-5f45-b517-fe84a4b411ca"),
    "PART"."P_CONTAINER" AS "P_CONTAINER" @id("1e895ec0-3e0f-5220-9936-5d23a2269584"),
    "PART"."P_RETAILPRICE" AS "P_RETAILPRICE" @id("fd59fbbf-825d-5287-ac93-973574c3d8a8"),
    "PART"."P_COMMENT" AS "P_COMMENT" @id("186e1bbd-1d93-500d-9a05-dfe8e9d02864"),
    "PART"."LOAD_TS" AS "LOAD_TS" @id("4d97c562-a243-515a-b997-c46f5e049678"),
    CAST(CASE WHEN "PART"."P_SIZE" <= 15 THEN 'SMALL' WHEN "PART"."P_SIZE" <= 35 THEN 'MEDIUM' ELSE 'LARGE' END AS VARCHAR(6)) AS "P_SIZE_BAND" @id("a7289a12-19b3-5c14-a5f2-7fa7446296f3")
FROM {{ ref('SRC', 'PART') }} "PART"
