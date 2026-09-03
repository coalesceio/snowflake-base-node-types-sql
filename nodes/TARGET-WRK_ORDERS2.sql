@id("edc3b733-cd26-496a-8f6f-6e95886cce92")
@nodeType("707")
SELECT DISTINCT *
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"