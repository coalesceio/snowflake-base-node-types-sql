@id("c82cf283-17a0-45e1-b770-535e46802132")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")


WITH RECURSIVE RCTE_FNL AS (
    -- The anchor clause defines the initial query.
    SELECT TO_DATE('2025-01-01') AS "date_s"
    UNION ALL
    -- The recursive clause defines the query that is repeated.
    SELECT DATEADD(day, 1, "date_s") AS "date_s"
    FROM RCTE_FNL
    where "date_s" < TO_DATE('2025-01-10')
  )
SELECT "date_s"
FROM RCTE_FNL