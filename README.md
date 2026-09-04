# SQL-First(V2) NodeTypes

The [SQL-first nodes](https://docs.coalesce.io/docs/build-your-pipeline/v2-node-types) is a transformation tool within Coalesce that lets developers write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent with the standard UI, and ships with a built-in library of column- and node-level data quality tests. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

# Coalesce Base Node Types - SQL Package

The Coalesce Base Node Types - SQL Package includes:

* [Work](#work)

## Work

The Work node is a general-purpose transformation node within Coalesce, used to materialize intermediate or staging-layer tables and views as part of a larger transformation pipeline. It sits between raw source data and downstream modeled objects, giving developers a flexible landing point to shape, clean, and validate data — complete with a built-in library of column- and node-level data quality tests — before it flows further into the pipeline.

### Work Node Configuration

The Work Node type has three configuration groups:

* [General](#work-general-options)
* [Node Annotations](#work-node-annotations)
* [Column Annotations](#work-column-annotations)

#### Work General Options

<img width="745" height="302" alt="image" src="https://github.com/user-attachments/assets/bf4ced93-3b7d-434c-aee4-8757aa7c37ab" />

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Work table or view will be created |

> **Note:** `Deploy Enabled` (the setting that lets a Node be excluded from — or dropped during — redeployment based on a TRUE/FALSE toggle) is **not supported** on this node types.

### Work Node Annotations

<img width="793" height="612" alt="image" src="https://github.com/user-attachments/assets/db09c345-979b-4b4e-a628-19451e4435d3" />

| **Property** | **Description** |
|---------|-------------|
| `@id(id)` ***(reserved)*** | Unique identifier for the node.<br/>Static and auto-generated when the node is created — not meant to be edited. |
| `@nodeType(type)` ***(reserved)*** | Identifies the node's type.<br/>Set automatically based on the node type chosen when the node is created.|
| `@description(text)` ***(reserved)*** | Node-level description.<br/>Can be edited via this annotation or in the node description field below the node name in the UI.<br/>Example: `@description("Table description")` |
| `@materializationType(type)` ***(reserved)*** | table/view.<br/>Value is strictly case-sensitive — must be lowercase `table` or `view`.<br/>*Not specified in the SQL editor → defaults to **table**.*<br/>Example: `@materializationType("view")` |
| `@writeMode("truncateInsert \| append")` | **truncateInsert** — replaces the table's contents entirely via a single `INSERT OVERWRITE INTO` statement (atomic — no separate truncate step). <br/>**append** — inserts the new rows via `INSERT INTO`, alongside whatever is already there.<br/>*Not specified in the SQL editor → defaults to **truncateInsert**.*<br/>**Note:** Ignored on Views.<br/>Example: `@writeMode("append")` |
| `@disableTests`**²** | Controls whether configured tests are skipped.<br/>*Specified in the SQL editor → all node- and column-level tests are skipped.*<br/>*Not specified in the SQL editor → tests run normally.*<br/>To turn tests back on, remove the annotation. Useful while developing a node — iterate on the SQL first, then re-enable once the logic is settled.<br/>Example: `@disableTests` |
| `@tests(querySQL, continueOnFailure?, runOrder?)` | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")` |
| `@preSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `before` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")` |
| `@postSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `after` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('WRK_NATION', CURRENT_TIMESTAMP())")` |

>**Note:** Quote style matters for **case-sensitive** identifiers.

Default — outer `"..."` double quotes, identifier unquoted:
```
@preSQL(" SELECT 1 FROM {{ this }} GROUP BY N_NAME HAVING COUNT(*) > 1 ")
```
If the column name's casing must be preserved exactly, swap the outer quotes to `'...'` single quotes, and wrap the identifier itself in `"..."` double quotes:
```
@preSQL(' SELECT 1 FROM {{ this }} GROUP BY "N_Name" HAVING COUNT(*) > 1 ')
```
This applies to `@tests`, `@preSQL`, and `@postSQL`.

### Work Column Annotations

<img width="790" height="365" alt="image" src="https://github.com/user-attachments/assets/5ee65e14-e87f-4c72-9209-3c561f0cc57f" />

| **Property** | **Description** |
|---------|-------------|
| `@notNull` ***(reserved)*** | Marks column as NOT NULL.<br/>**Note:** Ignored on Views.<br/>Example: `@notNull` |
| `@description(<text>)` ***(reserved)*** | Adds column description.<br/>Example: `@description("timestamp column")` |
| `@defaultValue(<value>)` ***(reserved)*** | Adds default value.<br/>Quote to match the column's data type - <br/>number: `defaultValue("<num>")`<br/>string: `defaultValue("'<string>'")`<br/>**Note:** Ignored on Views.<br/>Example: `@defaultValue("20")` `@defaultValue("'NA'")` |
| `@inHash(<hashName>, <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>Example: `@inHash("GH_COL1", 1)` |

<img width="792" height="824" alt="image" src="https://github.com/user-attachments/assets/b8559c63-db38-4c09-ad5b-5ae12fb0c870" />

🚦**Column-level data quality tests** — applicable only when `@disableTests` is not set. Each runs **After** the load and continues the run on failure. *Not specified in the SQL editor → test is off.*

| **Property** | **Description** |
|---------|-------------|
| `@not_null` | Fails on rows where the column is NULL.<br/>Example: `@not_null` |
| `@unique` | Fails when a value appears on more than one row.<br/>Example: `@unique` |
| `@empty` | Fails on rows where the column trims to the empty string.<br/>NULL values pass this test — they're caught by `@not_null` instead.<br/>Example: `@empty` |
| `@accepted_values("<value>")` | ***(repeatable)*** Fails on rows whose value is outside the allow list.<br/>Repeat once per permitted value.<br/>Quote to match the column's data type — <br/>number: `accepted_values("<num>")`<br/>string: `accepted_values("'<string>'")`.<br/>Example: `@accepted_values("'ALGERIA'")` |
| `@rejected_values("<value>")` | ***(repeatable)*** Fails on rows whose value is in the deny list.<br/>Repeat once per forbidden value.<br/>Same quoting rules as `accepted_values`.<br/>Example: `@rejected_values("'NA'")` |
| `@min_max("<min>", "<max>")` | Fails on rows outside the inclusive range.<br/>Bounds are pasted into the SQL verbatim —<br/>number: `"0"`,<br/>date: `"DATE '2026-01-01'"`.<br/>Example: `@min_max("0", "4")` |
| `@min_value("<min>")` | Fails on rows below the bound.<br/>Value formatting — see `min_max`.<br/>Example: `@min_value("0")` |
| `@max_value("<max>")` | Fails on rows above the bound.<br/>Value formatting — see `min_max`.<br/>Example: `@max_value("100")` |
| `@freshness(<interval>, "<unit>")` | Fails when the newest value in the column is older than the given interval, or the table is empty.<br/>**interval** — how far back from now the newest value is allowed to be, expressed in the unit given by **unit**.<br/>**unit** — SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, or YEAR (defaults to DAY).<br/>**Note:** on a DATE column the value is truncated to midnight.<br/>Example: `@freshness(7, "DAY")` |
| `@relative_time("<operator>", "<other_column>")` | Compares this column against another date/time column on the same node.<br/>e.g. `@relative_time("<=", "END_DATE")` fails rows where this column's value is not `<=` END_DATE.<br/>Either side NULL → row is skipped (passes).<br/>Example: `@relative_time("<", "L_M_2")` |

---

### Notes

- Verify that all **column datatypes** are successfully resolved before creating the object. Columns with an `UNKNOWN` datatype may cause stage generation or runtime failures.

- Any keyword that is valid immediately after **SELECT** is accepted in the final **SELECT** clause (right after any CTEs) — for example **DISTINCT** or **ALL**. This does not extend to keywords like `DEFAULT` that, while valid SQL keywords elsewhere, don't fit in a `SELECT` clause.

    ```sql
    SELECT DISTINCT TOP 10
         "N_REGIONKEY" AS "N_REGIONKEY",
         "N_NAME" AS "N_NAME"
    FROM {{ ref('SRC', 'NATION') }} "NATION"
    ```

- **¹** The hash transformation uses the reusable `get_hash()` macro:

    ```SQL
    {{ get_hash(<hash_name>, <algo>, <delimiter>) }}
    ```

    | Parameter | Description |
    |-----------|-------------|
    | `hash_name` | Hash name used across columns to identify the columns included in the hash. |
    | `algo` | **(optional)** Hashing algorithm to use. Supported values include `SHA1` and `SHA256`. Defaults to `SHA1`. |
    | `delimiter` | **(optional)** Delimiter used to separate column values when generating the hash. Defaults to `\|\|` and can be customized. |

    #### Examples:
    
    Using hash macro(default-SHA1)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL", 1),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
    ```
    Using hash macro(MD5)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL", 1),
    {{ get_hash('GH_COL', 'MD5') }}::STRING AS "GH_COL"
    ```
    Using hash macro(SHA256)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL", 1),
    {{ get_hash('GH_COL', 'SHA256') }}::STRING AS "GH_COL"
    ```
    Using hash macro(algo=SHA256, delimeter='~' )
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL", 1),
    {{ get_hash('GH_COL', algo='SHA256', delimiter='~') }}::STRING AS "GH_COL"
    ```
    Using multiple keys hash macro
    ```sql
    <col_name1> AS <col_name1> @inHash("GH_COL", 1),
    <col_name2> AS <col_name2> @inHash("GH_COL", 2),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL_COMBINED"
    ```
    Using multiple hash macros
    ```sql
    <col_name1> AS <col_name1> @inHash("GH_COL1", 1, "GH_COL2", 2),
    <col_name2> AS <col_name2> @inHash("GH_COL1", 2),
    <col_name3> AS <col_name3> @inHash("GH_COL2", 1),
    {{ get_hash('GH_COL1') }}::STRING AS "GH_COL_COMBINED1",
    {{ get_hash('GH_COL2', delimiter='~') }}::STRING AS "GH_COL_COMBINED2"
    ```
    Using explicit expression:
    ```sql
    CAST(
      SHA1(
        NVL(CAST(<col_name> AS VARCHAR), 'null')
      ) AS STRING
    )::STRING AS "GH_Key"
    ```
- **²** Node level tests are performed only when `disableTests` is OFF
    ```text
    @tests("<querySQL>", <continueOnFailure>, "<runOrder>")
    ```
    | Parameter | Description |
    |-----------|-------------|
    | querySQL | SQL statement to execute as a validation test. The test fails if the query returns any records. |
    | continueOnFailure |**(optional)** `true` or `false`. Determines whether execution continues when the test fails. |
    | runOrder |**(optional)** `Before` or `After`. Determines whether the test is executed before or after the load operation. |
---

### Known Limitations

Users should be aware of the following technical constraints when using SQL-first nodes:

* **Parsable SQL Only**:
 The node only supports SQL that can be fully parsed by the platform’s engine. Non-standard SQL or vendor-specific "semantic views" that bypass standard parsing will not work.

* **SELECT Statements Only**:  
This node only supports data retrieval and transformation logic. DML or DDL commands such as `CREATE`, `MERGE`, `DELETE`, `UPDATE`, or `TRUNCATE` are not supported and will cause execution failures.

* **Support for `UNION`, and `UNION ALL`**:  
`UNION`, and `UNION ALL` are fully supported when used within **Common Table Expressions (CTEs)**. While these keywords can also be used in standard `SELECT` statements without generating an error, they may not parsed correctly by the platform. As a result, subsequent clauses (such as `JOIN`s) may be interpreted as part of a standard join structure, causing the generated SQL to differ from the intended query and potentially leading to inconsistent data loads. To ensure the SQL is parsed and executed as expected, always implement these operations inside a CTE.

* **Other Keywords**:  
**GROUP BY, ORDER BY and HAVING** clauses can be included as part of the join query and will be parsed and processed accordingly.

* **Reserved Keywords as Annotation Names**:  
Avoid naming custom annotations after words that are reserved keywords in the platform's SQL grammar — e.g. `UNIQUE`, `AS`, `PRIMARY`. The parser may fail to parse such annotations and throw a validation error.

* **Switching Between V1 and V2 Node Types**:  
Converting an existing V1 (`.yml`) node to a V2 (`.sql`) node, or vice versa, is not supported.

---

### Usage Examples 

The following patterns represent common ways to use the SQL Node.<br/>

**Sample node with Annotations**
```sql
@writeMode("append")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} WHERE N_REGIONKEY IS NULL", true, "Before")
@description("Table description")
@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")
@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('WRK_NATION', CURRENT_TIMESTAMP())")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null @unique @min_value("0") @max_value("100")  @accepted_values("1") @inHash("GH_COL1", 2),
     "N_NAME" AS "N_NAME" @not_null @empty @accepted_values("'ALGERIA'") @accepted_values("'ARGENTINA'") @inHash("GH_COL1", 1),
     "N_REGIONKEY" AS "N_REGIONKEY" @min_max("0", "4") @notNull @defaultValue("20"),
     "N_COMMENT" AS "N_COMMENT" @rejected_values("'NA'"),
     "LAST_MODIFIED" AS L_M_1 @freshness(7, "DAY") @relative_time("<", "L_M_2") @description("timestamp column"),
     "LAST_MODIFIED" AS L_M_2,
     CAST({{ get_hash('GH_COL1') }} AS STRING) AS "GH_COL1" @description("Hash Column")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```
**Sample node with DISTINCT**
```sql
@writeMode("append")
@description("Table description")
SELECT DISTINCT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "LAST_MODIFIED" AS L_M @freshness(7, "DAY")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```
**Basic Transformation & Cleaning** - Standard pattern for renaming columns and handling nulls.

```sql
SELECT
     "O_ORDERKEY" AS "O_ORDERKEY",
     "O_CUSTKEY" AS "O_CUSTKEY",
     UPPER("O_ORDERSTATUS") AS "O_ORDERSTATUS",
     COALESCE("O_TOTALPRICE", 0) AS "O_TOTALPRICE",
     "O_ORDERDATE" AS "O_ORDERDATE"
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
WHERE "O_ORDERSTATUS" != 'F'
```

**Aggregate Functions inside a CTE**

```sql
WITH "ORDER_COUNTS" AS (
    SELECT
        MOD("ORDER_ID", 25) AS "NATION_KEY",
        COUNT(*) AS "ORDER_COUNT"
    FROM {{ ref('SRC', 'ORDERS_TEST') }}
    GROUP BY MOD("ORDER_ID", 25)
)
SELECT
     "NATION_KEY" AS "NATION_KEY",
     "ORDER_COUNT" AS "ORDER_COUNT"
FROM "ORDER_COUNTS"
```

**Using CTEs (Common Table Expressions)** - For more complex, multi-step logic

```sql
WITH PRIORITY_COUNTS AS (
    SELECT 
        "O_ORDERPRIORITY" AS "O_ORDERPRIORITY",
        COUNT(*) AS ORDER_COUNT
    FROM {{ ref('SRC', 'ORDERS') }}
    GROUP BY 1
)
SELECT * FROM PRIORITY_COUNTS
```
**Multi-CTE Transformation With Window Functions** <br/>
Complex transformations that would otherwise require multiple nodes can be written as a single SQL statement. Coalesce tracks lineage through each CTE and down to the source tables
```sql
WITH ORDERED_ORDERS AS (
-- CTE 1: Rank every order for each customer by date
SELECT
O_CUSTKEY,
O_ORDERKEY,
O_ORDERDATE,
O_TOTALPRICE,
O_ORDERSTATUS,
ROW_NUMBER() OVER (
PARTITION BY O_CUSTKEY
ORDER BY O_ORDERDATE ASC, O_ORDERKEY ASC
) AS ORDER_RANK
FROM {{ ref('SRC', 'ORDERS') }}
),
FIRST_ORDERS AS (
-- CTE 2: Filter to keep only the first order (rank 1) for each customer
SELECT
O_CUSTKEY,
O_ORDERKEY AS FIRST_ORDER_ID,
O_ORDERDATE AS FIRST_PURCHASE_DATE,
O_TOTALPRICE AS FIRST_ORDER_VALUE,
O_ORDERSTATUS
FROM ORDERED_ORDERS
WHERE ORDER_RANK = 1
)
-- Final Select: Add metadata and return the results
SELECT
F.O_CUSTKEY,
F.FIRST_ORDER_ID,
F.FIRST_PURCHASE_DATE,
F.FIRST_ORDER_VALUE,
F.O_ORDERSTATUS @notNull,
CURRENT_TIMESTAMP() AS REFRESHED_AT,
'Initial Customer Purchase' AS RECORD_TYPE
FROM FIRST_ORDERS F
```
**Using Recursive CTE**
```sql
WITH RECURSIVE "NATION_MANAGERS" AS (
    SELECT
        "N_NATIONKEY" AS "NATION_ID",
        "N_NAME" AS "NATION_NAME",
        CASE WHEN "N_NATIONKEY" = 0 THEN NULL ELSE "N_NATIONKEY" - 1 END AS "MANAGER_ID"
    FROM {{ ref('SRC', 'NATION_TEST') }}
),
"NATION_CHAIN" AS (
    SELECT
        "NATION_ID",
        "NATION_NAME",
        "MANAGER_ID",
        1 AS "ORG_LEVEL",
        CAST("NATION_NAME" AS STRING) AS "PATH"
    FROM "NATION_MANAGERS"
    WHERE "MANAGER_ID" IS NULL

    UNION ALL

    SELECT
        "N"."NATION_ID",
        "N"."NATION_NAME",
        "N"."MANAGER_ID",
        "C"."ORG_LEVEL" + 1,
        "C"."PATH" || ' -> ' || "N"."NATION_NAME"
    FROM "NATION_MANAGERS" "N"
    JOIN "NATION_CHAIN" "C" ON "N"."MANAGER_ID" = "C"."NATION_ID"
)
SELECT
     "NC"."NATION_ID" AS "NATION_ID",
     "NC"."NATION_NAME" AS "NATION_NAME",
     "NC"."ORG_LEVEL" AS "ORG_LEVEL",
     "NC"."PATH" AS "PATH",
     COUNT("O"."ORDER_ID") AS "ORDER_COUNT"
FROM "NATION_CHAIN" "NC"
JOIN {{ ref('SRC', 'ORDERS_TEST') }} "O" ON "NC"."NATION_ID" = MOD("O"."ORDER_ID", 25)
GROUP BY "NC"."NATION_ID", "NC"."NATION_NAME", "NC"."ORG_LEVEL", "NC"."PATH"
```
**Using Recursive CTE - Date Series**
```sql
WITH RECURSIVE RCTE_FNL AS (
    SELECT TO_DATE('2025-01-01') AS "date_s"
    UNION ALL
    SELECT DATEADD(day, 1, "date_s") AS "date_s"
    FROM RCTE_FNL
    where "date_s" < TO_DATE('2025-01-10')
  )
SELECT "date_s"
FROM RCTE_FNL
```
**Using CTE for multisource combine**
```sql
WITH ALL_NATIONS AS (
    SELECT *
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }}
    UNION
    SELECT *
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY2') }}
)
SELECT * FROM ALL_NATIONS
```

### Supported SQL Functionality

- **Multi-Source Joins & Enrichment:** The ability to reference and join multiple upstream nodes (e.g., Joining ORDERS and CUSTOMER) within a single stage to flatten data or create enriched wide tables while maintaining full lineage for every source.

- **Conditional Logic via CASE Statements:** Support for complex business rules and data categorization using standard CASE WHEN syntax to create derived columns based on multiple logical conditions.

 - **Flexible Projection (SELECT * with Expressions):** Enhanced projection capabilities that allow for selecting all columns from a source (`SELECT *`) while simultaneously appending new calculated expressions, timestamps, or metadata in the same statement.<br/>**Note:** Column-level annotations (e.g. `@not_null`, `@inHash`) can only be attached to columns that are explicitly listed in the `SELECT` clause — they cannot be applied to columns pulled in via `SELECT *`.

- **Nested Subqueries:** Support for correlated and non-correlated subqueries within SELECT, FROM, or WHERE clauses, enabling granular filtering and complex lookups that don't require separate nodes.

- **Common Table Expressions (CTEs)**: Support for standard `WITH` clauses to break down complex, multi-step transformation logic into readable, modular blocks. Coalesce tracks lineage through each CTE and back to the source tables.

- **Recursive CTEs**: Full support for `WITH` RECURSIVE logic, enabling the transformation of hierarchical data and the programmatic generation of data sequences within a single node.
  
- If a CTE is referenced in templates that may include joins, always use a **table alias** and qualify all column references with that alias. This prevents ambiguous column errors and ensures the template remains extensible as additional joins are introduced.

---

### Work Deployment

#### Work Initial Deployment

When deployed for the first time into an Environment the Work Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Work Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Work View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Work Redeployment

After the Work Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Work Table or recreating the Work table.

#### Altering the Work Tables

A few types of column or table changes will result in an ALTER statement to modify the Work Table in the target Environment, whether these changes are made individually or all together:

* Changing table names
* Dropping existing columns
* Altering column data types
* Adding new columns

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Clone Table** | Creates an internal table |
| **Rename Table\| Alter Column \| Delete Column \| Add Column \| Edit table description** | Alter table statement is executed to perform the alter operation |
| **Swap Cloned Table** | Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost |
| **Delete Table** | Drops the internal table |

> **Note:** Renaming a column results in the existing column being dropped and a new column being created. This operation may lead to data loss and should be performed with caution.

#### Recreating the Work Tables

If the materialization type is changed from Table to View, then the following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Drops the existing table |
| **Create View** | Recreates the node as a view |

#### Recreating the Work Views

The subsequent deployment of the Work Node of materialization type view with changes in view definition, adding table description or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

### Removing a Work Node

If a Work Node of materialization type table is deleted from a SQL Workspace, that SQL Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Work Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a Work Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the WorkView in the target Environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing Work view from the target Environment |

---

### Code

#### Work

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/run.sql.j2)

