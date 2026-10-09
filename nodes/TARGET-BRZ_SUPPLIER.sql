@id("c2f2d953-7627-51f2-9b58-464d861c8d31")
@nodeType("SQLWork")
@materializationType("transient table")
@description("Bronze supplier (SQLWork transient)")
SELECT
    "SUPPLIER"."S_SUPPKEY" AS "S_SUPPKEY" @id("732b7a4f-c677-5cb5-9a25-13e5ee89210f"),
    "SUPPLIER"."S_NAME" AS "S_NAME" @id("fcca9b24-2852-56a6-b5a7-6286a44521ca"),
    "SUPPLIER"."S_ADDRESS" AS "S_ADDRESS" @id("a62aeae0-025b-5c73-abbc-157ad43dac78"),
    "SUPPLIER"."S_NATIONKEY" AS "S_NATIONKEY" @id("37a28d61-4851-59ac-8a76-8aa82266080b"),
    "SUPPLIER"."S_PHONE" AS "S_PHONE" @id("a6724ca0-bd56-507d-bed4-596559cc3824"),
    "SUPPLIER"."S_ACCTBAL" AS "S_ACCTBAL" @id("1ac4bc43-9ad3-51b5-bc86-5c143cfa669c"),
    "SUPPLIER"."S_COMMENT" AS "S_COMMENT" @id("0887c989-d031-565a-a416-bea0bc7c1ad7")
FROM {{ ref('SRC', 'SUPPLIER') }} "SUPPLIER"
