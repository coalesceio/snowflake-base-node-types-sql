# SQL-First NodeTypes

The [SQL-first nodes](https://docs.coalesce.io/docs/build-your-pipeline/v2-node-types) is a transformation tool within Coalesce that lets developers write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent with the standard UI, and ships with a built-in library of column- and node-level data quality tests. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

# Coalesce Base Node Types - SQL Package

The Coalesce Base Node Types - SQL Package includes:

* [Work](#work)
* [Dimension](#dimension)
* [Fact](#fact)

Concepts shared across every node type — quote style, hash columns, data quality tests, known limitations, and usage examples — are documented once in [Common Reference](#common-reference) and linked to from each node type below.

## Node Type Comparison

A side-by-side view of which annotations each node type supports, so it's easy to see what a given node type is missing compared to the others.

### Node Annotations Matrix

| Annotation | Work | Dimension | Fact |
|---|---|---|---|
| `@writeMode` | ✅ | ✅ | ✅ |
| `@mergeStrategy` | ➖ | ✅<br/>* changeTracking<br/>* lastModified<br/>* upsert | ✅<br/>* changeTracking<br/>* lastModified<br/>* upsert<br/>* allColumnMatch |
| `@zeroKey` (node-level) | ➖ | ✅ | ➖ |
| `@disableTests` | ✅ | ✅ | ✅ |
| `@tests` | ✅ | ✅ | ✅ |
| `@preSQL` | ✅ | ✅ | ✅ |
| `@postSQL` | ✅ | ✅ | ✅ |
| Target Load | INSERT (OVERWRITE) | (TRUNCATE) MERGE | (TRUNCATE) MERGE/INSERT |

### Column Annotations Matrix

| Annotation | Work | Dimension | Fact |
|---|---|---|---|
| `@id` ***(required)*** | ➖ | ✅ | ✅ |
| `@isBusinessKey` | ➖ | ✅<br/>***(required)*** | ✅<br/>***(conditional)*** ³ |
| `@isChangeTracking` | ➖ | ✅ | ➖ |
| `@lastModifiedTracking` | ➖ | ✅ | ✅ |
| `@zeroKey` (column-level) | ➖ | ✅ | ➖ |
| `@isSurrogateKey` | ➖ | ✅ | ➖ |
| `@isSystemVersion` | ➖ | ✅ | ➖ |
| `@isSystemCurrentFlag` | ➖ | ✅ | ➖ |
| `@isSystemCreateDate` | ➖ | ✅ | ✅ |
| `@isSystemUpdateDate` | ➖ | ✅ | ✅ |
| `@isSystemEndDate` | ➖ | ✅  | ➖ |
| all column tests | ✅ | ✅ | ✅ |

> See [Column-Level Data Quality Tests](#column-level-data-quality-tests) for the shared quality-test annotations in the last row.
>
> ³ Fact: required for an explicit `@mergeStrategy` of `changeTracking`, `lastModified` or `upsert`; optional otherwise — with neither `@mergeStrategy` nor `@isBusinessKey` the node is a plain insert, and `allColumnMatch` ignores it. See [Fact Load Behaviour](#fact-load-behaviour).

## Work

The Work node is a general-purpose transformation node within Coalesce, used to materialize intermediate or staging-layer tables and views as part of a larger transformation pipeline. It sits between raw source data and downstream modeled objects, giving developers a flexible landing point to shape, clean, and validate data — complete with a built-in library of column- and node-level data quality tests — before it flows further into the pipeline.

### Work Node Configuration

The Work Node type has three configuration groups:

* [General](#work-general-options)
* [Node Annotations](#work-node-annotations)
* [Column Annotations](#work-column-annotations)

#### Work General Options

<img width="622" height="307" alt="image" src="https://github.com/user-attachments/assets/6c4e70ce-a7b0-4feb-af74-9be64b64002b" />

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Work table or view will be created |

### Work Node Annotations

<img width="793" height="612" alt="image" src="https://github.com/user-attachments/assets/db09c345-979b-4b4e-a628-19451e4435d3" />

| **Property** | **Description** |
|---------|-------------|
| `@id(id)` ***(reserved)*** | Unique identifier for the node.<br/>Static and auto-generated when the node is created — not meant to be edited. |
| `@nodeType(type)` ***(reserved)*** | Identifies the node's type.<br/>Set automatically based on the node type chosen when the node is created.|
| `@description(text)` ***(reserved)*** | Node-level description.<br/>Can be edited via this annotation or in the node description field below the node name in the UI.<br/>Example: `@description("Table description")` |
| `@materializationType(type)` ***(reserved)*** | table/view.<br/>Value is strictly case-sensitive — must be lowercase `table` or `view`.<br/>*Not specified in the SQL editor → defaults to **table**.*<br/>Example: `@materializationType("view")` |
| `@deployDisabled` ***(reserved)*** | Excludes this node from deployment. |
| `@writeMode("truncateInsert \| append")` | **truncateInsert** — replaces the table's contents entirely via a single `INSERT OVERWRITE INTO` statement (atomic — no separate truncate step). <br/>**append** — inserts the new rows via `INSERT INTO`, alongside whatever is already there.<br/>*Not specified in the SQL editor → defaults to **truncateInsert**.*<br/>**Note:** Ignored on Views.<br/>Example: `@writeMode("append")` |
| `@disableTests`**²** | Controls whether configured tests are skipped.<br/>*Specified in the SQL editor → all node- and column-level tests are skipped.*<br/>*Not specified in the SQL editor → tests run normally.*<br/>To turn tests back on, remove the annotation. Useful while developing a node — iterate on the SQL first, then re-enable once the logic is settled.<br/>Example: `@disableTests` |
| `@tests(querySQL, continueOnFailure?, runOrder?)`**²** | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>[Refer to Node-Level Tests for more details.](#node-level-tests--tests)<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")` |
| `@preSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `before` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")` |
| `@postSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `after` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('WRK_NATION', CURRENT_TIMESTAMP())")` |

>**Note:** Quote style matters for **case-sensitive** identifiers when writing `@tests`, `@preSQL`, and `@postSQL` — see [Quote Style for Case-Sensitive Identifiers](#quote-style-for-case-sensitive-identifiers).

### Work Column Annotations

<img width="790" height="365" alt="image" src="https://github.com/user-attachments/assets/5ee65e14-e87f-4c72-9209-3c561f0cc57f" />

| **Property** | **Description** |
|---------|-------------|
| `@notNull` ***(reserved)*** | Marks column as NOT NULL.<br/>**Note:** Ignored on Views.<br/>Example: `@notNull` |
| `@description(<text>)` ***(reserved)*** | Adds column description.<br/>Example: `@description("timestamp column")` |
| `@defaultValue(<value>)` ***(reserved)*** | Adds default value.<br/>Quote to match the column's data type - <br/>number: `defaultValue("<num>")`<br/>string: `defaultValue("'<string>'")`<br/>**Note:** Ignored on Views.<br/>Example: `@defaultValue("20")` `@defaultValue("'NA'")` |
| `@inHash("<hashName>", <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>[Refer to Hash Columns for more details.](#hash-columns--get_hash)<br/>Example:<br/>`<col_name> AS <col_name> @inHash("GH_COL", 1),`<br/>`{{ get_hash('GH_COL') }}::STRING AS "GH_COL"`|


🚦 The full set of column-level data quality tests (`@not_null`, `@uniqueness`, `@empty`, `@accepted_values`, `@rejected_values`, `@min_max`, `@min_value`, `@max_value`, `@freshness`, `@relative_time`) applies to Work columns exactly as described in [Column-Level Data Quality Tests](#column-level-data-quality-tests).

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

## Dimension

The Dimension node is a specialized transformation node within Coalesce, used to materialize dimension tables that track descriptive attributes over time. It merges incoming source data into the target using a configurable change-detection strategy — plain upsert, column-based change tracking, or a last-modified timestamp — and, depending on that strategy and the columns marked on the node, produces either an SCD Type 1 (overwrite-in-place) or SCD Type 2 (versioned history) dimension, complete with a built-in library of column- and node-level data quality tests.

### Dimension Node Configuration

The Dimension Node type has three configuration groups:

* [General](#dimension-general-options)
* [Node Annotations](#dimension-node-annotations)
* [Column Annotations](#dimension-column-annotations)

#### Dimension General Options

<img width="538" height="299" alt="image" src="https://github.com/user-attachments/assets/47a6ea12-485c-4356-95dd-a17b653392b5" />

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Dimension table or view will be created |

### Dimension Node Annotations

<img width="638" height="695" alt="image" src="https://github.com/user-attachments/assets/3ce0bc6a-3294-4d2f-b41b-1e6c82280b49" />

| **Property** | **Description** |
|---------|-------------|
| `@id(id)` ***(reserved)*** | Unique identifier for the node.<br/>Static and auto-generated when the node is created — not meant to be edited. |
| `@nodeType(type)` ***(reserved)*** | Identifies the node's type.<br/>Set automatically based on the node type chosen when the node is created.|
| `@description(text)` ***(reserved)*** | Node-level description.<br/>Can be edited via this annotation or in the node description field below the node name in the UI.<br/>Example: `@description("Table description")` |
| `@materializationType(type)` ***(reserved)*** | table/view.<br/>Value is strictly case-sensitive — must be lowercase `table` or `view`.<br/>*Not specified in the SQL editor → defaults to **table**.*<br/>Example: `@materializationType("view")` |
| `@deployDisabled` ***(reserved)*** | Excludes this node from deployment. |
| `@writeMode("truncateInsert \| append")` | **truncateInsert** — clears the table before loading, replacing its contents entirely.<br/>**append** — inserts the new rows via merge, alongside whatever is already there.<br/>*Not specified in the SQL editor → defaults to **append**.*<br/>**Note:** Ignored on Views.<br/>Example: `@writeMode("truncateInsert")` |
| `@mergeStrategy("upsert \| changeTracking \| lastModified")` | Chooses how this dimension decides a row has changed, and therefore which column annotations it requires.<br/><br/>**upsert** — no change detection at all; a matched row is always updated, an unmatched row is inserted. Doesn't assert any SCD type of its own — if the upstream SELECT/CTE already implements SCD1/SCD2 logic, this strategy just merges that result through as-is. The SELECT/CTE should return one row per business key (de-duplicate upstream). System columns are optional; any that are present are written exactly as the SELECT/CTE computes them. `@lastModifiedTracking`/`@isChangeTracking` columns aren't used — if present, a warning is raised and they're ignored.<br/><br/>**changeTracking** — compares columns marked `@isChangeTracking` (or, if none are marked, every plain attribute column) to detect a change. SCD Type 2 if any column is marked `@isChangeTracking`, otherwise SCD Type 1. Doesn't use `@lastModifiedTracking` — if present, a warning is raised and it's ignored.<br/><br/>**lastModified** — compares a single `@lastModifiedTracking` timestamp column against the target's stored value. Requires exactly one column marked `@lastModifiedTracking` — a validation check flags it if none (or more than one) is present. SCD Type 1 or 2 comes from that column's own `scdType` parameter. Doesn't use `@isChangeTracking` — if present, a warning is raised and it's ignored.<br/>*Not specified in the SQL editor → defaults to **changeTracking** - SCD Type 1.*<br/><br/>The value is not case-sensitive; any other value is flagged by a validation check.<br/>Every strategy merges on the business key, so the SELECT/CTE must return exactly one row per business key, with no NULL business key — see [Duplicate or NULL Business Keys](#known-limitations) for a `Before` test that checks this.<br/>Under **changeTracking** / **lastModified** the load writes fixed system column values — see [System column values](#system-column-values).<br/>**Note:** Ignored on Views.<br/>Example: `@mergeStrategy("lastModified")` |
| `@zeroKey(surrogateKeyValue?, stringValue?, timestampValue?, booleanValue?)` | Inserts a default "zero key" record into the target — a placeholder row used to catch unresolved foreign key lookups.<br/>**surrogateKeyValue** — value used for the zero record's surrogate key column only. Default `"0"`.<br/>Numeric columns (integer, decimal, float) always get `0`; override any column with a column-level `@zeroKey(value)`.<br/>**stringValue** — default value for string/varchar columns, pasted into the SQL verbatim — include your own quotes. Default `"'UNKNOWN'"`.<br/>**timestampValue** — default value for date/time/timestamp columns. Default `"1900-01-01 00:00:00"`.<br/>**booleanValue** — default value for boolean columns. Default `true`.<br/>*Not specified in the SQL editor → the zero record is not inserted.*<br/>**Note:** Ignored on Views.<br/>Example: `@zeroKey("0", "'UNKNOWN'", "1900-01-01 00:00:00", true)`|
| `@disableTests`**²** | Controls whether configured tests are skipped.<br/>*Specified in the SQL editor → all node- and column-level tests are skipped.*<br/>*Not specified in the SQL editor → tests run normally.*<br/>To turn tests back on, remove the annotation. Useful while developing a node — iterate on the SQL first, then re-enable once the logic is settled.<br/>Example: `@disableTests` |
| `@tests(querySQL, continueOnFailure?, runOrder?)`**²** | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>[Refer to Node-Level Tests for more details.](#node-level-tests--tests)<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")`|
| `@preSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `before` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")` |
| `@postSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `after` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('DIM_NATION', CURRENT_TIMESTAMP())")` |

>**Note:** Quote style matters for **case-sensitive** identifiers when writing `@tests`, `@preSQL`, and `@postSQL` — see [Quote Style for Case-Sensitive Identifiers](#quote-style-for-case-sensitive-identifiers).

### Dimension Column Annotations

<img width="790" height="365" alt="image" src="https://github.com/user-attachments/assets/5ee65e14-e87f-4c72-9209-3c561f0cc57f" />

| **Property** | **Description** |
|---------|-------------|
| `@id("<value>")` | Stable column ID for lineage tracking.<br/>Required on every column — the SQL editor generates a fresh `@id("<value>")` for each column it creates, and a validation check flags any column that is missing one.<br/>Not for manual editing — value is a stable identifier generated once at creation time.<br/>**Column added later:** make sure it gets its own `@id` too. If you're editing by hand, add a new, unique 6-hex-digit `@id("<value>")` along with the column; an agent can generate one for you. Don't reuse a value already on the node.<br/>Example: `@id("110e75")` |
| `@notNull` ***(reserved)*** | Marks column as NOT NULL.<br/>**Note:** Ignored on Views.<br/>Example: `@notNull` |
| `@description(<text>)` ***(reserved)*** | Adds column description.<br/>Example: `@description("timestamp column")` |
| `@defaultValue(<value>)` ***(reserved)*** | Adds default value.<br/>Quote to match the column's data type - <br/>number: `defaultValue("<num>")`<br/>string: `defaultValue("'<string>'")`<br/>**Note:** Ignored on Views.<br/>Example: `@defaultValue("20")` `@defaultValue("'NA'")` |
| `@inHash("<hashName>", <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>[Refer to Hash Columns for more details.](#hash-columns--get_hash)<br/>Example:<br/>`<col_name> AS <col_name> @inHash("GH_COL", 1),`<br/>`{{ get_hash('GH_COL') }}::STRING AS "GH_COL"`|

<img width="648" height="455" alt="image" src="https://github.com/user-attachments/assets/74fe3375-b1cc-4d2a-8f40-81d97b02136c" />

| **Property** | **Description** |
|---------|-------------|
| `@isBusinessKey` ***(required)*** | Marks a column as part of the business key used to match existing rows during the merge.<br/>**Note:** Ignored on Views.<br/>Example: `@isBusinessKey` |
| `@lastModifiedTracking(scdType?)` | Marks the column used to detect newer source rows for an incremental load.<br/>Datatype — DATE/TIME or any incrementing NUMERIC type.<br/>Can only be applied to one column.<br/>Must not be NULL in the source — a pre-load check flags it, since a NULL value can never compare as newer: a row loaded with a NULL tracking value is never updated again.<br/>Only this column decides a change — other columns that change without a newer tracking value are never applied, even under SCD Type 1.<br/>**scdType** — `1` overwrites the row in place, `2` expires the row and inserts a new version. *Not specified → defaults to 1.*<br/>**Note:** Ignored on Views.<br/>Example: `@lastModifiedTracking(2)` |
| `@isChangeTracking` | Marks a column to be watched for changes that decide SCD type.<br/>Marked on any column → SCD Type 2 — a change expires the existing row and inserts a new version.<br/>Not marked on any column → SCD Type 1 — a change updates the row in place.<br/>**Note:** Ignored on Views.<br/>Example: `@isChangeTracking` |
| `@zeroKey(value)` | Adds a custom zero key value (ghost record) to this column, overriding the node-level `@zeroKey` defaults for it.<br/>The value is pasted into the SQL verbatim, so quote it to match the column's data type.<br/>**Note:** Ignored unless `@zeroKey` is enabled at the node level, and ignored on Views.<br/>Example: `@zeroKey("'N/A'")` |
| `@isSurrogateKey` | Marks this column as the node's surrogate key.<br/>Optional for SCD Type 1 — the merge logic joins and detects changes entirely off the business key.<br/>Recommended for SCD Type 2 — a stable surrogate key per version is the standard way to identify a versioned row, though it isn't enforced by the merge itself.<br/>Required only when the node-level `@zeroKey` is set, since the zero/ghost record is matched against the target by surrogate key value.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `0 AS "{{NODE_NAME}}_KEY" @isSurrogateKey` |
| `@isSystemVersion` | Marks this column as the SCD version number, incremented each time a business key gets a new version.<br/>Required for SCD Type 2 — shows which version of a row this is; each time a business key's row changes, the expired row is kept and a new row is inserted with this value incremented by 1.<br/>Optional for SCD Type 1 — new-vs-existing is detected off the business key alone, so this column can be dropped entirely; if kept, it is always written as 1 and never incremented.<br/>Optional for `upsert` — if kept, it is written exactly as the SELECT/CTE computes it.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `1 AS "SYSTEM_VERSION" @isSystemVersion` |
| `@isSystemCurrentFlag` | Marks this column as the SCD "is current" flag — `'Y'` on the active version of a row, overwritten to `'N'` when it's expired.<br/>Required for SCD Type 2 — used to filter the target down to each business key's one current row before comparing it against the incoming source row.<br/>Optional for SCD Type 1 — safe to omit; if kept, it is always written as `'Y'`.<br/>Optional for `upsert` — if kept, it is written exactly as the SELECT/CTE computes it (e.g. `'N'` for a row the CTE is expiring).<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag` |
| `@isSystemCreateDate` | Marks this column as the timestamp a row (or, under SCD Type 2, a specific row version) was first created.<br/>Required unless `@mergeStrategy` is `upsert` — under `changeTracking`/`lastModified` it's read back from the target and preserved unchanged on every row after its initial insert. Under `upsert`, no change detection reads the target at all, so this column isn't required; if kept, it is written from the SELECT/CTE on insert and never overwritten on update.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate` |
| `@isSystemUpdateDate` | Marks this column as the timestamp a row was last updated.<br/>Required for SCD Type 2 — read back from the target and refreshed to the current timestamp whenever a row is inserted as a new version or its prior current version is expired.<br/>Required for SCD Type 1 — recomputed to the current timestamp on every inserted or changed row, so every row change carries an audit trail of when it was last updated.<br/>Optional for `upsert` — if kept, it is written from the SELECT/CTE on every insert and update.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate` |
| `@isSystemEndDate` | Marks this column as the SCD Type 2 expiration timestamp — a far-future sentinel while the row is current, set to the actual expiry time once superseded.<br/>Required for SCD Type 2 — this is what makes a version's active window queryable; omitting it leaves expired versions with no expiry marker.<br/>Optional for SCD Type 1 (no versioning, so nothing ever expires) — safe to omit entirely.<br/>Optional for `upsert` — if kept, it is written exactly as the SELECT/CTE computes it.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate` |

🚦 The full set of column-level data quality tests (`@not_null`, `@uniqueness`, `@empty`, `@accepted_values`, `@rejected_values`, `@min_max`, `@min_value`, `@max_value`, `@freshness`, `@relative_time`) applies to Dimension columns exactly as described in [Column-Level Data Quality Tests](#column-level-data-quality-tests).

---

### Dimension SCD Type & System Column Requirements

`@mergeStrategy` picks the change-detection strategy; which SCD type it resolves to (and therefore which system columns are required) depends on that strategy and, for `changeTracking`/`lastModified`, on which columns are marked:

| `@mergeStrategy` | Resolves to | Driven by |
|---|---|---|
| `upsert` | Whatever SCD shape the upstream SELECT/CTE already implements — Coalesce doesn't detect or enforce SCD1/SCD2 here, it just merges the result through as-is. Out of the box (plain SELECT, one row per business key) this behaves as an SCD1 overwrite; SCD2 needs the CTE to do the versioning — see note ² | User's own SQL logic, not any column annotation |
| `lastModified` | SCD1 or SCD2, from that column's own `scdType` parameter | `@lastModifiedTracking(scdType)` |
| `changeTracking` (default) | SCD2 if any column is marked, otherwise SCD1 | `@isChangeTracking` |

Requirement level of each column annotation, by resolved strategy/SCD type:

| Annotation | Category | SCD1 (`changeTracking` / `lastModified`) | SCD2 (`changeTracking` / `lastModified`) | `upsert` |
|---|---|:---:|:---:|:---:|
| `@isBusinessKey` | Key | 🔴 | 🔴 | 🔴 |
| `@isSurrogateKey` | Key | ⚪ | 🟡 | ⚪ |
| `@isSystemCreateDate` | System column | 🔴 | 🔴 | ⚪|
| `@isSystemUpdateDate` | System column | 🔴 | 🔴 | ⚪ |
| `@isSystemVersion` | System column | ⚪ | 🔴 | ⚪ |
| `@isSystemCurrentFlag` | System column | ⚪  | 🔴 | ⚪ |
| `@isSystemEndDate` | System column | ⚪ | 🔴 | ⚪ |

**Legend:** 🔴 Required · 🟡 Recommended · ⚪ Optional¹

* ¹ `upsert` never reads the target back to compare, so no system column is needed for change detection. Any system column that is present is written exactly as the SELECT/CTE computes it — on insert and on every update — except `@isSystemCreateDate`, which keeps its first-inserted value. The default columns the SQL editor generates (`SYSTEM_VERSION` → 1, `SYSTEM_CURRENT_FLAG` → `'Y'`, `SYSTEM_END_DATE` → `'2999-12-31'`, create/update date → current timestamp) therefore still load as expected.<br/>
* ² SCD2 with `upsert`: the merge matches on the `@isBusinessKey` column(s) only, so to keep history mark a key that is unique **per version** as `@isBusinessKey` (e.g. a hash of the natural key and effective date, or your own version key — not the `@isSurrogateKey` identity column), and have the CTE return both rows: the existing version re-emitted with its expiry values (`SYSTEM_CURRENT_FLAG` → `'N'`, `SYSTEM_END_DATE` → now), which updates the old row, and the new version with a new key, which is inserted.<br/>
* `@lastModifiedTracking`/`@isChangeTracking` on an `upsert` node are never read — a warning is raised and they're ignored.<br/>
* Marking `@isChangeTracking` on any column is itself what makes the node SCD2 under `changeTracking`.<br/>

#### System column values

Under `changeTracking` and `lastModified` the load writes fixed values into the system columns. The expression the SELECT gives a system column is only used to derive the column's datatype — its value is ignored:

| Column | Value written |
|---|---|
| `@isSystemVersion` | `1` on a new key; previous version + 1 on a new SCD2 version |
| `@isSystemCurrentFlag` | `'Y'` on the current row; `'N'` on an expired SCD2 row |
| `@isSystemCreateDate` | `CURRENT_TIMESTAMP` on first insert, then kept |
| `@isSystemUpdateDate` | `CURRENT_TIMESTAMP` whenever the row is inserted, changed, or expired as an old SCD2 version |
| `@isSystemEndDate` | `'2999-12-31 00:00:00'` on the current row; the expiry time (one millisecond before the load) on an expired SCD2 row |

To use different values (e.g. `'Yes'`/`'No'` flags or another end-date sentinel), use `upsert` and compute them in the SELECT/CTE — `upsert` writes system columns exactly as the SELECT/CTE computes them.

---

### Dimension Deployment

#### Dimension Initial Deployment

When deployed for the first time into an Environment the Dimension Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Dimension Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Dimension View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Dimension View

A Dimension Node of materialization type view is a plain `CREATE OR REPLACE VIEW` over the node's SELECT:

* None of the Dimension validation checks run — `@isBusinessKey`, system columns, `@id` and `@mergeStrategy` aren't required or checked.
* There is no merge; the run shows **Load Skipped for View**. `@mergeStrategy`, `@writeMode`, `@zeroKey`, `@preSQL`, `@postSQL` and the tracking annotations are ignored.
* Any system column (surrogate key, version, current flag, create/update/end date) is selected as a typed `NULL`, keeping the column's datatype.
* Column-level data quality tests and node-level `@tests` still run.

#### Dimension Load

Every deployment of a Dimension Node of materialization type table runs its configured data quality tests, then merges data into the target using the stages below, depending on the resolved `@mergeStrategy` and SCD type:

| **Stage** | **Description** |
|-----------|----------------|
| **Pre Load Test `<n>`** | Node-level `@tests(..., "Before")` tests, in the order they appear. |
| **Missing Column IDs \| Missing Business Key \| Invalid configuration: … \| Missing Required System Columns** | Validation checks — rendered only when the node's annotations have a problem (a column without `@id`, no `@isBusinessKey`, an unrecognised or conflicting `@mergeStrategy`/tracking column, or a missing system column). Each one flags the problem; see the individual annotations for what triggers it. |
| **Check NULL values for `<column>` column** | Pre-load check for `@mergeStrategy("lastModified")` — flags a NULL `@lastModifiedTracking` value in the source. |
| **Pre-SQL `<n>`** | Each `@preSQL` statement, in the order they appear. |
| **Truncate table** | Executed only when `@writeMode("truncateInsert")` is set — clears the target before the merge. |
| **Load table Using Merge - Zero Key Record** | Executed only when node-level `@zeroKey` is set and a surrogate key column exists — merges the placeholder "zero key" row into the target. |
| **Load table Using Merge - Upsert** | Executed for `@mergeStrategy("upsert")` — merges source rows straight through with no change detection: every matched row is updated from the SELECT/CTE (system columns included, `@isSystemCreateDate` excepted) and every unmatched row is inserted. |
| **Load table Using Merge - Last Modified Comparison - SCD1 \| SCD2** | Executed for `@mergeStrategy("lastModified")` — compares the `@lastModifiedTracking` column against the target to detect changes, then updates in place (SCD1) or versions the row (SCD2) per that column's `scdType`. |
| **Load table Using Merge - Change Tracking - SCD1 \| SCD2** | Executed for `@mergeStrategy("changeTracking")` (the default) — compares `@isChangeTracking` columns (or, absent any, every plain attribute column) against the target, then updates in place (SCD1) or versions the row (SCD2). |
| **Post-SQL `<n>`** | Each `@postSQL` statement, in the order they appear. |
| **`<column>: <test>` \| Post Load Test `<n>`** | Column-level data quality tests and node-level `@tests(..., "After")` tests, run after the load. |

#### Dimension Redeployment

After the Dimension Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Dimension Table or recreating the Dimension table.

#### Altering the Dimension Tables

A few types of column or table changes will result in an ALTER statement to modify the Dimension Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Dimension Tables

If the materialization type is changed from Table to View, then the following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Drops the existing table |
| **Create View** | Recreates the node as a view |

#### Recreating the Dimension Views

The subsequent deployment of the Dimension Node of materialization type view with changes in view definition, adding table description or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |


### Removing a Dimension Node

If a Dimension Node of materialization type table is deleted from a SQL Workspace, that SQL Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Dimension Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a Dimension Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Dimension View in the target Environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing Dimension view from the target Environment |

---

## Fact

The Fact node is a specialized transformation node within Coalesce, used to materialize fact tables that hold measurable business events. It loads incoming source data into the target in one of three ways: a plain insert when neither `@mergeStrategy` nor a business key is set, an SCD Type 1 merge on the business key (`changeTracking` or `lastModified`), or a merge with no change detection (`upsert`, or `allColumnMatch`, which inserts only rows that don't already exist). Facts never keep versioned (SCD Type 2) history and have no surrogate key or zero key record. Like the other node types, it comes with a built-in library of column- and node-level data quality tests.

### Fact Node Configuration

The Fact Node type has three configuration groups:

* [General](#fact-general-options)
* [Node Annotations](#fact-node-annotations)
* [Column Annotations](#fact-column-annotations)

#### Fact General Options

<img width="511" height="311" alt="image" src="https://github.com/user-attachments/assets/8a8bd7d1-a705-4f5f-866b-ea53e5c9c6ef" />

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Fact table or view will be created |

### Fact Node Annotations

<img width="511" height="672" alt="image" src="https://github.com/user-attachments/assets/27b2ebed-c6f5-4598-b239-a683e5405ca9" />

| **Property** | **Description** |
|---------|-------------|
| `@id(id)` ***(reserved)*** | Unique identifier for the node.<br/>Static and auto-generated when the node is created — not meant to be edited. |
| `@nodeType(type)` ***(reserved)*** | Identifies the node's type.<br/>Set automatically based on the node type chosen when the node is created.|
| `@description(text)` ***(reserved)*** | Node-level description.<br/>Can be edited via this annotation or in the node description field below the node name in the UI.<br/>Example: `@description("Table description")` |
| `@materializationType(type)` ***(reserved)*** | table/view.<br/>Value is strictly case-sensitive — must be lowercase `table` or `view`.<br/>*Not specified in the SQL editor → defaults to **table**.*<br/>Example: `@materializationType("view")` |
| `@deployDisabled` ***(reserved)*** | Excludes this node from deployment. |
| `@writeMode("truncateInsert \| append")` | **truncateInsert** — clears the table before loading, replacing its contents entirely.<br/>**append** — loads the new rows alongside whatever is already there.<br/>*Not specified in the SQL editor → defaults to **append**.*<br/>**Note:** Ignored on Views.<br/>Example: `@writeMode("truncateInsert")` |
| `@mergeStrategy("changeTracking \| lastModified \| upsert \| allColumnMatch")` | Chooses how rows are matched against the target, and therefore which column annotations are required.<br/><br/>**changeTracking** — SCD Type 1. Compares every plain attribute column against the target; a changed row is overwritten in place, a new key is inserted. Doesn't use `@lastModifiedTracking` — if present, a warning is raised and it's ignored.<br/><br/>**lastModified** — SCD Type 1. Compares a single `@lastModifiedTracking` column against the target's stored value; a newer value overwrites the row in place. Requires exactly one column marked `@lastModifiedTracking` — a validation check flags it if none (or more than one) is present.<br/><br/>**upsert** — no change detection at all; a matched row is always updated, an unmatched row is inserted. The SELECT/CTE should return one row per business key (de-duplicate upstream). System columns are optional; any that are present are written exactly as the SELECT/CTE computes them. `@lastModifiedTracking` isn't used — if present, a warning is raised and it's ignored.<br/><br/>**allColumnMatch** — treats every non-system column as the business key: a source row is inserted only if no target row matches it on all of those columns, and an existing matching row is never updated. `@isBusinessKey` isn't needed — if present, a warning is raised, it's ignored and all columns are used for the comparison. `@lastModifiedTracking` isn't used either — a warning is raised and it's ignored. System columns are optional, are left out of the comparison, and are written exactly as the SELECT/CTE computes them.<br/><br/>*Not specified in the SQL editor → defaults to **changeTracking** - SCD Type 1 when a column is marked `@isBusinessKey`, otherwise the node is loaded as a [plain insert](#fact-load-behaviour).*<br/>The value is not case-sensitive; any other value is flagged by a validation check.<br/>When set, `@mergeStrategy` always takes priority: `changeTracking`, `lastModified` and `upsert` merge on the business key, so without an `@isBusinessKey` column a validation check fails and the load stops. `allColumnMatch` needs no `@isBusinessKey`.<br/>**Note:** Ignored on Views.<br/>Example: `@mergeStrategy("allColumnMatch")` |
| `@disableTests`**²** | Controls whether configured tests are skipped.<br/>*Specified in the SQL editor → all node- and column-level tests are skipped.*<br/>*Not specified in the SQL editor → tests run normally.*<br/>To turn tests back on, remove the annotation. Useful while developing a node — iterate on the SQL first, then re-enable once the logic is settled.<br/>Example: `@disableTests` |
| `@tests(querySQL, continueOnFailure?, runOrder?)`**²** | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>[Refer to Node-Level Tests for more details.](#node-level-tests--tests)<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_ID HAVING COUNT(*) > 1", false, "After")`|
| `@preSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `before` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@preSQL("DELETE FROM {{ this }} WHERE ORDER_DATE < DATEADD(DAY, -90, CURRENT_DATE())")` |
| `@postSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `after` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('FCT_ORDERS', CURRENT_TIMESTAMP())")` |

>**Note:** Quote style matters for **case-sensitive** identifiers when writing `@tests`, `@preSQL`, and `@postSQL` — see [Quote Style for Case-Sensitive Identifiers](#quote-style-for-case-sensitive-identifiers).

### Fact Column Annotations

<img width="517" height="514" alt="image" src="https://github.com/user-attachments/assets/6933718d-6148-49d6-8145-a7d6acec465f" />

| **Property** | **Description** |
|---------|-------------|
| `@id("<value>")` | Stable column ID for lineage tracking.<br/>Required on every column — the SQL editor generates a fresh `@id("<value>")` for each column it creates, and a validation check flags any column that is missing one.<br/>Not for manual editing — value is a stable identifier generated once at creation time.<br/>**Column added later:** make sure it gets its own `@id` too. If you're editing by hand, add a new, unique 6-hex-digit `@id("<value>")` along with the column; an agent can generate one for you. Don't reuse a value already on the node.<br/>Example: `@id("110e75")` |
| `@notNull` ***(reserved)*** | Marks column as NOT NULL.<br/>**Note:** Ignored on Views.<br/>Example: `@notNull` |
| `@description(<text>)` ***(reserved)*** | Adds column description.<br/>Example: `@description("timestamp column")` |
| `@defaultValue(<value>)` ***(reserved)*** | Adds default value.<br/>Quote to match the column's data type - <br/>number: `defaultValue("<num>")`<br/>string: `defaultValue("'<string>'")`<br/>**Note:** Ignored on Views.<br/>Example: `@defaultValue("20")` `@defaultValue("'NA'")` |
| `@inHash("<hashName>", <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>[Refer to Hash Columns for more details.](#hash-columns--get_hash)<br/>Example:<br/>`<col_name> AS <col_name> @inHash("GH_COL", 1),`<br/>`{{ get_hash('GH_COL') }}::STRING AS "GH_COL"`|
| `@isBusinessKey` | Marks a column as part of the business key used to match existing rows during the merge.<br/>Optional when `@mergeStrategy` isn't set — if no column is marked, there is no merge and every source row is simply inserted.<br/>Required for an explicit `changeTracking`, `lastModified` or `upsert` — without it the load stops with a validation error.<br/>Ignored under `@mergeStrategy("allColumnMatch")`, which uses every non-system column as the key (a warning is raised).<br/>**Note:** Ignored on Views.<br/>Example: `@isBusinessKey` |
| `@lastModifiedTracking` | Marks the column used to detect newer source rows for an incremental load (SCD Type 1).<br/>Datatype — DATE/TIME or any incrementing NUMERIC type.<br/>Can only be applied to one column.<br/>Must not be NULL in the source — a pre-load check flags it, since a NULL value can never compare as newer: a row loaded with a NULL tracking value is never updated again.<br/>Only this column decides a change — other columns that change without a newer tracking value are never applied.<br/>Used only by `@mergeStrategy("lastModified")`.<br/>**Note:** Ignored on Views.<br/>Example: `@lastModifiedTracking` |
| `@isSystemCreateDate` | Marks this column as the timestamp a row was first created.<br/>Required for `changeTracking`/`lastModified` — read back from the target and preserved unchanged on every row after its initial insert.<br/>Recommended for `allColumnMatch` and plain insert — rows are only ever inserted, so it's the record of when each row was loaded; it is written exactly as the SELECT/CTE computes it.<br/>Optional for `upsert` — if kept, it is written from the SELECT/CTE on insert and never overwritten on update.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate` |
| `@isSystemUpdateDate` | Marks this column as the timestamp a row was last updated.<br/>Required for `changeTracking`/`lastModified` — set to the current timestamp on every inserted or changed row.<br/>Optional for `upsert`, `allColumnMatch` and plain insert — if kept, it is written exactly as the SELECT/CTE computes it.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate` |

🚦 The full set of column-level data quality tests (`@not_null`, `@uniqueness`, `@empty`, `@accepted_values`, `@rejected_values`, `@min_max`, `@min_value`, `@max_value`, `@freshness`, `@relative_time`) applies to Fact columns exactly as described in [Column-Level Data Quality Tests](#column-level-data-quality-tests).

---

### Fact Load Behaviour

How a Fact table is loaded depends on `@mergeStrategy` and on whether any column is marked `@isBusinessKey`:

| `@isBusinessKey` | `@mergeStrategy` | Load |
|---|---|---|
| none | not set | Plain insert (default without a business key) |
| none | `changeTracking` / `lastModified` / `upsert` | ❌ Validation error — the load stops |
| marked | not set, or `changeTracking` | SCD1 merge on the business key (default with a business key) |
| marked | `lastModified` | SCD1 merge on the business key |
| marked | `upsert` | Merge on the business key |
| any (ignored, warning if marked) | `allColumnMatch` | Merge on every non-system column |

Requirement level of each column annotation, by load:

| Annotation | `changeTracking` / `lastModified` | `upsert` | `allColumnMatch` | Plain insert |
|---|:---:|:---:|:---:|:---:|
| `@isBusinessKey` | 🔴 | 🔴 | ⚪¹ | — |
| `@lastModifiedTracking` | 🔴<br/>for `lastModified` only | — | — | — |
| `@isSystemCreateDate` | 🔴 | ⚪ | 🟡 | 🟡 |
| `@isSystemUpdateDate` | 🔴 | ⚪ | ⚪ | ⚪ |

**Legend:** 🔴 Required · 🟡 Recommended · ⚪ Optional · — Not used

* ¹ Ignored if present — every non-system column is used as the business key and a warning is raised.
* Under `changeTracking` / `lastModified` the load writes fixed values into the system columns: `@isSystemCreateDate` gets `CURRENT_TIMESTAMP` on first insert and is then kept; `@isSystemUpdateDate` gets `CURRENT_TIMESTAMP` whenever the row is inserted or changed. The expression the SELECT gives them is only used to derive the column's datatype.
* Under `upsert`, `allColumnMatch` and plain insert, system columns are written exactly as the SELECT/CTE computes them. `@isSystemCreateDate` keeps its first-inserted value on an `upsert` update.
* Business key matching (including every column under `allColumnMatch`) uses plain equality, so a NULL never matches — see [Duplicate or NULL Business Keys](#known-limitations).

---

### Fact Deployment

#### Fact Initial Deployment

When deployed for the first time into an Environment the Fact Node will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Fact Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Fact View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Fact View

A Fact Node of materialization type view is a plain `CREATE OR REPLACE VIEW` over the node's SELECT:

* None of the Fact validation checks run — `@isBusinessKey`, system columns, `@id` and `@mergeStrategy` aren't required or checked.
* There is no load; the run shows **Load Skipped for View**. `@mergeStrategy`, `@writeMode`, `@preSQL`, `@postSQL` and `@lastModifiedTracking` are ignored.
* `@isSystemCreateDate` / `@isSystemUpdateDate` columns are selected as a typed `NULL`, keeping the column's datatype.
* Column-level data quality tests and node-level `@tests` still run.

#### Fact Load

Every deployment of a Fact Node of materialization type table runs its configured data quality tests, then loads data into the target using the stages below:

| **Stage** | **Description** |
|-----------|----------------|
| **Pre Load Test `<n>`** | Node-level `@tests(..., "Before")` tests, in the order they appear. |
| **Missing Column IDs \| Invalid configuration: … \| Missing Required System Columns** | Validation checks — rendered only when the node's annotations have a problem. |
| **Check NULL values for `<column>` column** | Pre-load check for `@mergeStrategy("lastModified")` — flags a NULL `@lastModifiedTracking` value in the source. |
| **Pre-SQL `<n>`** | Each `@preSQL` statement, in the order they appear. |
| **Truncate table** | Executed only when `@writeMode("truncateInsert")` is set — clears the target before the load. |
| **Load table Using Insert** | Executed when no `@mergeStrategy` is set and no column is marked `@isBusinessKey` — inserts every source row with `INSERT INTO … SELECT`. |
| **Load table Using Merge - Change Tracking - SCD1** | Executed for `@mergeStrategy("changeTracking")`, and by default when no `@mergeStrategy` is set and a column is marked `@isBusinessKey` — compares every plain attribute column against the target, then updates changed rows in place and inserts new keys. |
| **Load table Using Merge - Last Modified Comparison - SCD1** | Executed for `@mergeStrategy("lastModified")` — compares the `@lastModifiedTracking` column against the target, then updates newer rows in place and inserts new keys. |
| **Load table Using Merge - Upsert** | Executed for `@mergeStrategy("upsert")` — every matched row is updated from the SELECT/CTE (system columns included, `@isSystemCreateDate` excepted) and every unmatched row is inserted. |
| **Load table Using Merge - All Column Match** | Executed for `@mergeStrategy("allColumnMatch")` — matches on every non-system column and inserts only rows that don't already exist; nothing is updated. |
| **Post-SQL `<n>`** | Each `@postSQL` statement, in the order they appear. |
| **`<column>: <test>` \| Post Load Test `<n>`** | Column-level data quality tests and node-level `@tests(..., "After")` tests, run after the load. |

#### Fact Redeployment

After the Fact Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Fact Table or recreating the Fact table.

#### Altering the Fact Tables

A few types of column or table changes will result in an ALTER statement to modify the Fact Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Fact Tables

If the materialization type is changed from Table to View, then the following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Drops the existing table |
| **Create View** | Recreates the node as a view |

#### Recreating the Fact Views

The subsequent deployment of the Fact Node of materialization type view with changes in view definition, adding table description or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

### Removing a Fact Node

If a Fact Node of materialization type table is deleted from a SQL Workspace, that SQL Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Fact Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a Fact Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Fact View in the target Environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing Fact view from the target Environment |

---

## Common Reference

Concepts and reusable building blocks that apply across every node type in this package.

### Quote Style for Case-Sensitive Identifiers

Quote style matters for **case-sensitive** identifiers wherever raw SQL is pasted into an annotation, e.g. `@tests`, `@preSQL`, `@postSQL`.

Default — outer `"..."` double quotes, identifier unquoted:
```
@preSQL(" SELECT 1 FROM {{ this }} GROUP BY N_NAME HAVING COUNT(*) > 1 ")
```
If the column name's casing must be preserved exactly, swap the outer quotes to `'...'` single quotes, and wrap the identifier itself in `"..."` double quotes:
```
@preSQL(' SELECT 1 FROM {{ this }} GROUP BY "N_Name" HAVING COUNT(*) > 1 ')
```
Or keep the outer `"..."` double quotes and double each inner quote — `""` inside the annotation string becomes a single `"` in the SQL. Use this form when the SQL also needs single quotes, e.g. a `{{ ref('...', '...') }}` or a string literal:
```
@tests("SELECT ""Nation_Key"" FROM {{ ref('SRC', 'NATION') }} GROUP BY ""Nation_Key"" HAVING COUNT(*) > 1", false, "Before")
```
A backslash (`\"`) does not escape a quote inside an annotation string and fails with a syntax error.

### Column-Level Data Quality Tests

🚦 Applicable only when `@disableTests` is not set. Each runs **After** the load and continues the run on failure. *Not specified in the SQL editor → test is off.*

| **Property** | **Description** |
|---------|-------------|
| `@not_null` | Fails on rows where the column is NULL.<br/>Example: `@not_null` |
| `@uniqueness` | Fails when a value appears on more than one row.<br/>Example: `@uniqueness` |
| `@empty` | Fails on rows where the column trims to the empty string.<br/>NULL values pass this test — they're caught by `@not_null` instead.<br/>Example: `@empty` |
| `@accepted_values("<value>", ...)` | Fails on rows whose value is outside the allow list. NULL values pass.<br/>Repeatable — every occurrence on the column is merged into one list. Each call takes a comma-separated list or separate arguments —<br/>`accepted_values("1, 3, 5")`<br/>`accepted_values("1", "3", "5")`<br/>`accepted_values("1") accepted_values("3, 5")`<br/>Each value is pasted into the SQL verbatim, so write it as a valid SQL value for the column's data type —<br/>numeric: with or without double quotes<br/>string: single quotes inside double quotes, `"'<string>'"`<br/>boolean: `true`/`false`, with or without double quotes<br/>date/time: a date/time literal or expression in double quotes, with any literal inside it in single quotes, e.g. `"'2026-01-01'"` or `"DATE '2026-01-01'"`<br/>Example: `@accepted_values("'ALGERIA', 'ARGENTINA'")` |
| `@rejected_values("<value>", ...)` | Fails on rows whose value is in the deny list. NULL values pass.<br/>Same syntax and quoting rules as `accepted_values`.<br/>Example: `@rejected_values("'NA'")` |
| `@min_max("<min>", "<max>")` | Fails on rows outside the inclusive range. NULL values pass.<br/>Applies to numeric and date/time columns only.<br/>Each bound is pasted into the SQL verbatim, so write it as a valid SQL value for the column's data type —<br/>positive numeric (integer, decimal or float): with or without double quotes<br/>negative numeric (integer, decimal or float): double quotes required<br/>date/time: a date/time expression in double quotes, with any literal inside it in single quotes, e.g. `"DATE '2026-01-01'"` or `"CURRENT_TIMESTAMP"`<br/>Example: `@min_max("0", "4")` |
| `@min_value("<min>")` | Fails on rows below the bound. NULL values pass.<br/>Value formatting — see `min_max`.<br/>Example: `@min_value("0")` |
| `@max_value("<max>")` | Fails on rows above the bound. NULL values pass.<br/>Value formatting — see `min_max`.<br/>Example: `@max_value("100")` |
| `@freshness(<interval>, "<unit>")` | Fails when the newest value in the column is older than the given interval, or the table is empty.<br/>**interval** — how far back from now the newest value is allowed to be, expressed in the unit given by **unit**.<br/>**unit** — SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, or YEAR (defaults to DAY).<br/>**Note:** on a DATE column the value is truncated to midnight.<br/>Example: `@freshness(7, "DAY")` |
| `@relative_time("<operator>", "<other_column>")` | Compares this column against another date/time column on the same node.<br/>e.g. `@relative_time("<=", "END_DATE")` fails rows where this column's value is not `<=` END_DATE.<br/>Either side NULL → row is skipped (passes).<br/>Both columns should have the same datatype — e.g. comparing a `TIMESTAMP_TZ` with a `TIMESTAMP_NTZ` reads the NTZ value in the session's time zone and can give unexpected results.<br/>Example: `@relative_time("<", "L_M_2")` |

### Hash Columns — get_hash()

**¹** The hash transformation uses the reusable `get_hash()` macro:

```SQL
{{ get_hash("<hash_name>", "<algo>", "<delimiter>") }}
```

| Parameter | Description |
|-----------|-------------|
| `hash_name` | Hash name used across columns to identify the columns included in the hash. |
| `algo` | **(optional)** Hashing algorithm to use. Supported values include `SHA1`, `SHA256` and `MD5`. Defaults to `SHA1`. |
| `delimiter` | **(optional)** Delimiter used to separate column values when generating the hash. Defaults to `\|\|` and can be customized. |

#### get_hash() Examples

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
Using hash macro(algo=SHA256, delimiter='~' )
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
<col_name1> AS <col_name1> @inHash("GH_COL1", 1) @inHash("GH_COL2", 2),
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

### Node-Level Tests — tests()

**²** Node level tests are performed only when `disableTests` is OFF.
```text
@tests("<querySQL>", <continueOnFailure>, "<runOrder>")
```
| Parameter | Description |
|-----------|-------------|
| querySQL | SQL statement to execute as a validation test. The test fails if the query returns any records. |
| continueOnFailure |**(optional)** `true`(default) or `false`. Marks whether the run is meant to continue when the test fails. |
| runOrder |**(optional)** `Before` or `After`(default). Determines whether the test is executed before or after the load operation. |

#### tests() Examples

```text
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", true, "Before")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", false)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
```

---

### Notes & Supported SQL Functionality

- Verify that all **column datatypes** are successfully resolved before creating the object. Columns with an `UNKNOWN` datatype may cause stage generation or runtime failures. This typically happens when:
    * a CTE builds a column through a `UNION`/`UNION ALL` inside a derived table — wrap the column in an explicit `CAST(... AS <type>)` in the final SELECT;
    * the final SELECT reads a CTE by its bare name (`FROM "CUST"`, `"CUST"."C_NAME"`) — give the CTE a table alias and qualify the columns with it (`FROM "CUST" "CU"`, `"CU"."C_NAME"`), and every column then resolves to its real datatype. Nodes downstream of an `UNKNOWN` column inherit it, so fix it at the first node.

    The create dry-run still reports `passed` with `UNKNOWN` in the DDL, so check the rendered column list rather than the status.

- Any keyword that is valid immediately after **SELECT** is accepted in the final **SELECT** clause (right after any CTEs) — for example **DISTINCT** or **ALL**. This does not extend to keywords like `DEFAULT` that, while valid SQL keywords elsewhere, don't fit in a `SELECT` clause.

    ```sql
    SELECT DISTINCT TOP 10
         "N_REGIONKEY" AS "N_REGIONKEY",
         "N_NAME" AS "N_NAME"
    FROM {{ ref('SRC', 'NATION') }} "NATION"
    ```

- **Multi-Source Joins & Enrichment:** The ability to reference and join multiple upstream nodes (e.g., Joining ORDERS and CUSTOMER) within a single stage to flatten data or create enriched wide tables while maintaining full lineage for every source.

- **Conditional Logic via CASE Statements:** Support for complex business rules and data categorization using standard CASE WHEN syntax to create derived columns based on multiple logical conditions.

 - **Flexible Projection (SELECT * with Expressions):** Enhanced projection capabilities that allow for selecting all columns from a source (`SELECT *`) while simultaneously appending new calculated expressions, timestamps, or metadata in the same statement.<br/>**Note:** Column-level annotations (e.g. `@not_null`, `@inHash`) can only be attached to columns that are explicitly listed in the `SELECT` clause — they cannot be applied to columns pulled in via `SELECT *`.

- **Nested Subqueries:** Support for correlated and non-correlated subqueries within SELECT, FROM, or WHERE clauses, enabling granular filtering and complex lookups that don't require separate nodes.

- **Common Table Expressions (CTEs)**: Support for standard `WITH` clauses to break down complex, multi-step transformation logic into readable, modular blocks. Coalesce tracks lineage through each CTE and back to the source tables.

- **Recursive CTEs**: Full support for `WITH` RECURSIVE logic, enabling the transformation of hierarchical data and the programmatic generation of data sequences within a single node.
  
- If a CTE is referenced in templates that may include joins, always use a **table alias** and qualify all column references with that alias. This prevents ambiguous column errors and ensures the template remains extensible as additional joins are introduced.

---

### Known Limitations

Users should be aware of the following technical constraints when using SQL-first nodes:

* **Parsable SQL Only**:
 The node only supports SQL that can be fully parsed by the platform’s engine. Non-standard SQL or vendor-specific "semantic views" that bypass standard parsing will not work.

* **SELECT Statements Only**:  
This node only supports data retrieval and transformation logic. DML or DDL commands such as `CREATE`, `MERGE`, `DELETE`, `UPDATE`, or `TRUNCATE` are not supported and will cause execution failures.

* **Support for `UNION`, and `UNION ALL`**:  
`UNION`, and `UNION ALL` are fully supported when used within **Common Table Expressions (CTEs)**. While these keywords can also be used in standard `SELECT` statements without generating an error, they may not be parsed correctly by the platform. As a result, subsequent clauses (such as `JOIN`s) may be interpreted as part of a standard join structure, causing the generated SQL to differ from the intended query and potentially leading to inconsistent data loads. To ensure the SQL is parsed and executed as expected, always implement these operations inside a CTE.

* **Other Keywords**:  
**GROUP BY, ORDER BY and HAVING** clauses can be included as part of the join query and will be parsed and processed accordingly.

* **Reserved Keywords as Annotation Names**:  
Avoid naming custom annotations after words that are reserved keywords in the platform's SQL grammar — e.g. `UNIQUE`, `AS`, `PRIMARY`. The parser may fail to parse such annotations and throw a validation error.

* **Switching Between YAML and SQL Node Types**:  
Converting an existing YAML (`.yml`) node to a SQL (`.sql`) node, or vice versa, is not supported.

* **Large or High-Precision Numbers in Test Values**:  
An unquoted number in an annotation is read as a floating-point value, so integers beyond roughly 15–16 digits and decimals with more than about 16 significant digits are rounded before the test runs (e.g. `12345678901234567890` becomes `1.2345678901234567e+19`). Wrap such values in double quotes — `@accepted_values("12345678901234567890")` — to pass them through exactly.

* **Commas Inside String Values in `accepted_values`/`rejected_values`**:  
Values are split on every comma, trimmed, and re-joined with `", "`. A string written with exactly one space after each comma, like `"'4, 5'"`, is tested as written; any other spacing is normalised, so `"'A,B'"` is tested as `'A, B'`. Commas between arguments of a function call (e.g. `"TO_DATE('15/06/2026','DD/MM/YYYY')"`) are unaffected.

* **`truncateInsert` with SCD Type 2**:  
`@writeMode("truncateInsert")` empties the table before every load, so an SCD Type 2 dimension (`changeTracking` with an `@isChangeTracking` column, or `lastModified` with `@lastModifiedTracking(2)`) loses all its history on each run — every row is reloaded as version 1. The combination runs without error, but it defeats the purpose of SCD Type 2; use the default `append` for versioned dimensions.

* **Keys Deleted from the Source**:  
A business key that disappears from the source is left as it is in the target — under SCD Type 2 its current row stays current (`SYSTEM_CURRENT_FLAG` = `'Y'`, open `SYSTEM_END_DATE`), and under SCD Type 1 the row is kept unchanged. Deletes are never detected, expired or flagged; handle them separately (e.g. with `@postSQL`) if the dimension needs to reflect removed keys.

* **System Columns Added to a Loaded Table**:  
Adding `@isSystemCreateDate` / `@isSystemUpdateDate` to a table that already holds rows (for example when switching a node from `upsert` to `changeTracking`) adds the columns with NULL in every existing row. `@isSystemCreateDate` is carried over from the target on every later update, so it stays NULL for those rows; `@isSystemUpdateDate` is only filled once a row actually changes. Backfill them once (e.g. with `@postSQL`) or reload with `@writeMode("truncateInsert")` if they need values.

* **Duplicate or NULL Business Keys**:  
Every strategy merges on the business key, so the SELECT/CTE must return exactly one row per key, with no NULL key. Otherwise a duplicated key is inserted more than once on a first load and later merges fail with "Duplicate row detected during DML action", and a NULL key never matches, so that row is re-inserted on every run. De-duplicate upstream (e.g. `QUALIFY ROW_NUMBER() OVER (PARTITION BY <business key> ORDER BY <timestamp> DESC) = 1`). To check it before each load, add a `Before` node-level test — see [Duplicate or NULL Business Key Check](#duplicate-or-null-business-key-check).

---

### Usage Examples

Common ways to use the SQL nodes. The SQL patterns under Work Examples (CTEs, window functions, DISTINCT) work the same way in a Dimension or Fact node.

**Work Examples**
* [Sample Node with Annotations](#sample-node-with-annotations)
* [Sample Node with DISTINCT](#sample-node-with-distinct)
* [Basic Transformation and Cleaning](#basic-transformation-and-cleaning)
* [Aggregate Functions inside a CTE](#aggregate-functions-inside-a-cte)
* [Using CTEs](#using-ctes)
* [Multi-CTE Transformation with Window Functions](#multi-cte-transformation-with-window-functions)
* [Recursive CTE](#recursive-cte)
* [Recursive CTE Date Series](#recursive-cte-date-series)
* [CTE for Multi-Source Combine](#cte-for-multi-source-combine)

**Data Quality Test Examples**
* [Column Tests by Datatype](#column-tests-by-datatype)
* [Node-Level Tests](#node-level-tests)

**Dimension Examples**
* [Change Tracking SCD1](#change-tracking-scd1)
* [Change Tracking SCD2](#change-tracking-scd2)
* [Last Modified SCD1](#last-modified-scd1)
* [Last Modified SCD2](#last-modified-scd2)
* [Upsert](#upsert)
* [Zero Key Record](#zero-key-record)
* [Dimension as a View](#dimension-as-a-view)
* [Duplicate or NULL Business Key Check](#duplicate-or-null-business-key-check)
* [Upsert with Custom SCD Logic](#upsert-with-custom-scd-logic)

**Fact Examples**
* [Fact Plain Insert](#fact-plain-insert)
* [Fact Change Tracking SCD1](#fact-change-tracking-scd1)
* [Fact Last Modified SCD1](#fact-last-modified-scd1)
* [Fact Upsert](#fact-upsert)
* [Fact All Column Match](#fact-all-column-match)

#### Work Examples

##### Sample Node with Annotations

```sql
@writeMode("append")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} WHERE N_REGIONKEY IS NULL", true, "Before")
@description("Table description")
@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")
@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('WRK_NATION', CURRENT_TIMESTAMP())")
SELECT
    "N_NATIONKEY"                             AS "N_NATIONKEY"         @not_null @uniqueness @min_value(0) @max_value(100)  @accepted_values("1, 2, 3") @inHash("GH_COL1", 2),
    "N_NAME"                                  AS "N_NAME"              @not_null @empty @accepted_values("'ALGERIA', 'ARGENTINA'") @inHash("GH_COL1", 1),
    "N_REGIONKEY"                             AS "N_REGIONKEY"         @min_max(0, 4) @notNull @defaultValue("20"),
    "N_COMMENT"                               AS "N_COMMENT"           @rejected_values("'NA'"),
    "LAST_MODIFIED"                           AS L_M_1                 @freshness(7, "DAY") @relative_time("<", "L_M_2") @description("timestamp column"),
    "LAST_MODIFIED"                           AS L_M_2,
    CAST({{ get_hash('GH_COL1') }} AS STRING) AS "GH_COL1"             @description("Hash Column")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```

##### Sample Node with DISTINCT

```sql
@writeMode("append")
@description("Table description")
SELECT DISTINCT
    "N_NATIONKEY"                            AS "N_NATIONKEY",
    "N_NAME"                                 AS "N_NAME",
    "N_REGIONKEY"                            AS "N_REGIONKEY",
    "N_COMMENT"                              AS "N_COMMENT",
    "LAST_MODIFIED"                          AS L_M                   @freshness(7, "DAY")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```

##### Basic Transformation and Cleaning

Standard pattern for renaming columns and handling nulls.

```sql
SELECT
    "O_ORDERKEY"                             AS "O_ORDERKEY",
    "O_CUSTKEY"                              AS "O_CUSTKEY",
    UPPER("O_ORDERSTATUS")                   AS "O_ORDERSTATUS",
    COALESCE("O_TOTALPRICE", 0)              AS "O_TOTALPRICE",
    "O_ORDERDATE"                            AS "O_ORDERDATE"
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
WHERE "O_ORDERSTATUS" != 'F'
```

##### Aggregate Functions inside a CTE

```sql
WITH "ORDER_COUNTS" AS (
    SELECT
        MOD("ORDER_ID", 25) AS "NATION_KEY",
        COUNT(*) AS "ORDER_COUNT"
    FROM {{ ref('SRC', 'ORDERS_TEST') }}
    GROUP BY MOD("ORDER_ID", 25)
)
SELECT
    "NATION_KEY"                             AS "NATION_KEY",
    "ORDER_COUNT"                            AS "ORDER_COUNT"
FROM "ORDER_COUNTS"
```

##### Using CTEs

For more complex, multi-step logic

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

##### Multi-CTE Transformation with Window Functions

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

##### Recursive CTE

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
    "NC"."NATION_ID"                         AS "NATION_ID",
    "NC"."NATION_NAME"                       AS "NATION_NAME",
    "NC"."ORG_LEVEL"                         AS "ORG_LEVEL",
    "NC"."PATH"                              AS "PATH",
    COUNT("O"."ORDER_ID")                    AS "ORDER_COUNT"
FROM "NATION_CHAIN" "NC"
JOIN {{ ref('SRC', 'ORDERS_TEST') }} "O" ON "NC"."NATION_ID" = MOD("O"."ORDER_ID", 25)
GROUP BY "NC"."NATION_ID", "NC"."NATION_NAME", "NC"."ORG_LEVEL", "NC"."PATH"
```

##### Recursive CTE Date Series

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

##### CTE for Multi-Source Combine

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

#### Data Quality Test Examples

##### Column Tests by Datatype

Each column test runs **After** the load, continues the run on failure, and lets NULL values pass (except `@not_null`). Values are pasted into the SQL as written, so quote them to match the column's datatype.

```sql
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @not_null @uniqueness @min_value("1"),
    "NAME"                                   AS "NAME"                @not_null @empty,
    "SEGMENT"                                AS "SEGMENT"             @accepted_values("'RETAIL', 'CORPORATE'") @accepted_values("'SMB'"),
    "STATUS"                                 AS "STATUS"              @rejected_values("'DELETED'", "'TEST'"),
    "BALANCE"                                AS "BALANCE"             @min_max("-1000", "100000"),
    "DISCOUNT"                               AS "DISCOUNT"            @min_value("0") @max_value("0.5"),
    "IS_ACTIVE"                              AS "IS_ACTIVE"           @accepted_values(true),
    "SIGNUP_DATE"                            AS "SIGNUP_DATE"         @min_max("DATE '2000-01-01'", "CURRENT_DATE"),
    "CREATED_AT"                             AS "CREATED_AT"          @max_value("CURRENT_TIMESTAMP"),
    "UPDATED_AT"                             AS "UPDATED_AT"          @freshness(1, "DAY") @relative_time(">=", "CREATED_AT"),
    "OPEN_TIME"                              AS "OPEN_TIME"           @min_max("'08:00:00'", "'18:00:00'")
FROM {{ ref('SRC', 'CUSTOMER') }}
```
* **Number** — `@min_value("1")`, a negative bound in double quotes `"-1000"`, a decimal `"0.5"`.
* **String** — single quotes inside double quotes; `@accepted_values` can repeat and the lists are merged.
* **Boolean** — `true`/`false`. **Date/time** — a literal or expression, e.g. `"DATE '2000-01-01'"`, `"CURRENT_TIMESTAMP"`, `"'08:00:00'"`.
* `@relative_time` compares two columns of the same datatype.
* The same annotations work on a Dimension node — add an `@id("<value>")` to each column there.

##### Node-Level Tests

A node-level test fails when its query returns any rows. `Before` tests usually read the source; `After` tests read the loaded target through `{{ this }}`.

```sql
@tests("SELECT CUSTOMER_ID FROM {{ ref('SRC', 'CUSTOMER') }} GROUP BY CUSTOMER_ID HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ ref('SRC', 'CUSTOMER') }} HAVING COUNT(*) = 0", true, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE BALANCE < 0 AND STATUS = 'ACTIVE'")
@tests("SELECT 1 FROM {{ this }} HAVING COUNT(*) <> (SELECT COUNT(*) FROM {{ ref('SRC', 'CUSTOMER') }})", true, "After")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID",
    "BALANCE"                                AS "BALANCE",
    "STATUS"                                 AS "STATUS"
FROM {{ ref('SRC', 'CUSTOMER') }}
```
* Line 1 — duplicate keys in the source, before the load. Line 2 — an empty source. Line 3 — a business rule on the loaded rows (`After` by default). Line 4 — the target row count matches the source.
* `continueOnFailure` is the second argument.
* `@disableTests` on the node skips every node-level and column-level test.

#### Dimension Examples

##### Change Tracking SCD1

The default strategy. Any change in a non-key column overwrites the row.

```sql
@nodeType("718")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("a10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("a10002"),
    "CITY"                                   AS "CITY"                @id("a10003"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("a10008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("a10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Change Tracking SCD2

A change in a column marked `@isChangeTracking` keeps the old row and adds a new version. Other columns are updated in place.

```sql
@nodeType("718")
@mergeStrategy("changeTracking")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("b10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("b10002"),
    "CITY"                                   AS "CITY"                @id("b10003") @isChangeTracking,
    1                                        AS "SYSTEM_VERSION"      @id("b10005") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("b10006") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("b10007") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("b10008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("b10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Last Modified SCD1

A row is overwritten only when its `@lastModifiedTracking` value is newer than the stored one.

```sql
@nodeType("718")
@mergeStrategy("lastModified")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("c10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("c10002"),
    "UPDATED_AT"                             AS "UPDATED_AT"          @id("c10003") @lastModifiedTracking(1),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("c10008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("c10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Last Modified SCD2

Same as above, but a newer value keeps the old row and adds a new version.

```sql
@nodeType("718")
@mergeStrategy("lastModified")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("d10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("d10002"),
    "UPDATED_AT"                             AS "UPDATED_AT"          @id("d10003") @lastModifiedTracking(2),
    1                                        AS "SYSTEM_VERSION"      @id("d10005") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("d10006") @isSystemCurrentFlag,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("d10007") @isSystemEndDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("d10008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("d10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Upsert

No change detection: existing keys are updated, new keys inserted. System columns are optional.

```sql
@nodeType("718")
@mergeStrategy("upsert")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("e10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("e10002"),
    "CITY"                                   AS "CITY"                @id("e10003")
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Zero Key Record

Adds a placeholder row for unmatched lookups. Needs a surrogate key column.

```sql
@nodeType("718")
@zeroKey(0)
SELECT
    0                                        AS "CUSTOMER_KEY"        @id("f10000") @isSurrogateKey,
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("f10001") @isBusinessKey,
    "NAME"                                   AS "NAME"                @id("f10002") @zeroKey("'NA'"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("f10008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("f10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Dimension as a View

No business key or system columns needed; nothing is merged.

```sql
@nodeType("718")
@materializationType("view")
SELECT
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("0a0001"),
    "NAME"                                   AS "NAME"                @id("0a0002")
FROM {{ ref('SRC', 'CUSTOMER') }}
```

##### Duplicate or NULL Business Key Check

Every merge strategy matches rows on the business key, so the source must return exactly one row per key, with no NULL key. A `Before` test runs ahead of the load and fails if the source returns a duplicated or NULL key.

```sql
@nodeType("718")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY, N_NAME FROM {{ ref('SOURCE_DATA', 'NATION') }} GROUP BY N_NATIONKEY, N_NAME HAVING COUNT(*) > 1 OR N_NATIONKEY IS NULL OR N_NAME IS NULL", false, "Before")
SELECT
    0                                        AS "DIM_NATION_KEY"      @id("a1b2c3") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("b2c3d4") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("c3d4e5") @isBusinessKey,
    "N_REGIONKEY"                            AS "N_REGIONKEY"         @id("d4e5f6"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("e5f6a7") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("f6a7b8") @isSystemUpdateDate
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```
* The test query must read the same source, CTE and filters as the node's SELECT, so it checks the rows that are actually loaded. List every `@isBusinessKey` column in the `GROUP BY` and the `IS NULL` checks.
* For a case-sensitive column name, double each inner quote — `""Nation_Key""` — see [Quote Style for Case-Sensitive Identifiers](#quote-style-for-case-sensitive-identifiers).

##### Upsert with Custom SCD Logic

`upsert` writes each row exactly as the SELECT computes it, so the SELECT can implement its own change logic. This example keeps the previous `CITY` (SCD3 style): the SELECT joins the source to the node's own table, and when the city changes, the old value moves to `CITY_PREV`.

```sql
@nodeType("718")
@mergeStrategy("upsert")
WITH "EXISTING" AS (
    -- Current rows already in this dimension
    SELECT "CUSTOMER_ID", "CITY", "CITY_PREV", "CITY_CHANGED_DATE"
    FROM {{ ref('TARGET', 'DIM_CUSTOMER') }}
)
SELECT
    "SRC"."CUSTOMER_ID"                      AS "CUSTOMER_ID"         @id("0b0001") @isBusinessKey,
    "SRC"."NAME"                             AS "NAME"                @id("0b0002"),
    "SRC"."CITY"                             AS "CITY"                @id("0b0003"),
    CASE WHEN NOT EQUAL_NULL("SRC"."CITY", "EXISTING"."CITY") AND "EXISTING"."CUSTOMER_ID" IS NOT NULL
         THEN "EXISTING"."CITY"
         ELSE "EXISTING"."CITY_PREV" END     AS "CITY_PREV"           @id("0b0004"),
    CASE WHEN NOT EQUAL_NULL("SRC"."CITY", "EXISTING"."CITY") AND "EXISTING"."CUSTOMER_ID" IS NOT NULL
         THEN CURRENT_TIMESTAMP
         ELSE "EXISTING"."CITY_CHANGED_DATE" END AS "CITY_CHANGED_DATE" @id("0b0005"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("0b0008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("0b0009") @isSystemUpdateDate
FROM {{ ref('SRC', 'CUSTOMER') }} "SRC"
LEFT JOIN "EXISTING" ON "SRC"."CUSTOMER_ID" = "EXISTING"."CUSTOMER_ID"
```
* New customer — no match in `EXISTING`, so `CITY_PREV` and `CITY_CHANGED_DATE` are NULL.
* City changed — the old city moves to `CITY_PREV` and `CITY_CHANGED_DATE` is stamped.
* City unchanged — the stored `CITY_PREV` and `CITY_CHANGED_DATE` are kept.
* `EXISTING` reads the node's own target table by its full name (replace `MY_DB.TARGET.DIM_CUSTOMER`), because a node can't `ref()` itself.
* `@isSystemCreateDate` keeps its first-insert value on update; every other column is overwritten from the SELECT.

#### Fact Examples

##### Fact Plain Insert

No `@mergeStrategy` and no `@isBusinessKey` column, so every source row is inserted with no matching. System columns are optional and written as the SELECT computes them. Adding `@mergeStrategy("changeTracking")`, `"lastModified"` or `"upsert"` here without a business key would stop the load with a validation error.

```sql
@nodeType("724")
SELECT
    "ORDER_ID"                               AS "ORDER_ID"            @id("1a0001"),
    "CUSTOMER_ID"                            AS "CUSTOMER_ID"         @id("1a0002"),
    "AMOUNT"                                 AS "AMOUNT"              @id("1a0003"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("1a0008") @isSystemCreateDate
FROM {{ ref('SRC', 'ORDERS') }}
```

##### Fact Change Tracking SCD1

The default strategy. Any change in a non-key column overwrites the row; new keys are inserted.

```sql
@nodeType("724")
SELECT
    "ORDER_ID"                               AS "ORDER_ID"            @id("1b0001") @isBusinessKey,
    "STATUS"                                 AS "STATUS"              @id("1b0002"),
    "AMOUNT"                                 AS "AMOUNT"              @id("1b0003"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("1b0008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("1b0009") @isSystemUpdateDate
FROM {{ ref('SRC', 'ORDERS') }}
```

##### Fact Last Modified SCD1

A row is overwritten only when its `@lastModifiedTracking` value is newer than the stored one.

```sql
@nodeType("724")
@mergeStrategy("lastModified")
SELECT
    "ORDER_ID"                               AS "ORDER_ID"            @id("1c0001") @isBusinessKey,
    "STATUS"                                 AS "STATUS"              @id("1c0002"),
    "UPDATED_AT"                             AS "UPDATED_AT"          @id("1c0003") @lastModifiedTracking,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("1c0008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("1c0009") @isSystemUpdateDate
FROM {{ ref('SRC', 'ORDERS') }}
```

##### Fact Upsert

No change detection: existing keys are updated, new keys inserted. System columns are optional.

```sql
@nodeType("724")
@mergeStrategy("upsert")
SELECT
    "ORDER_ID"                               AS "ORDER_ID"            @id("1d0001") @isBusinessKey,
    "STATUS"                                 AS "STATUS"              @id("1d0002"),
    "AMOUNT"                                 AS "AMOUNT"              @id("1d0003")
FROM {{ ref('SRC', 'ORDERS') }}
```

##### Fact All Column Match

Every non-system column is compared; a row is inserted only if an identical row doesn't already exist. Nothing is ever updated, and no `@isBusinessKey` is needed.

```sql
@nodeType("724")
@mergeStrategy("allColumnMatch")
SELECT
    "ORDER_ID"                               AS "ORDER_ID"            @id("1e0001"),
    "PRODUCT_ID"                             AS "PRODUCT_ID"          @id("1e0002"),
    "QUANTITY"                               AS "QUANTITY"            @id("1e0003"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("1e0008") @isSystemCreateDate
FROM {{ ref('SRC', 'ORDER_LINES') }}
```
* `SYSTEM_CREATE_DATE` is left out of the comparison, so re-running the load doesn't insert the same row again.
* Matching uses plain equality — a row with a NULL in any compared column never matches and is inserted on every run.
* Two identical source rows that aren't in the target yet are both inserted — add `DISTINCT` to the SELECT if that's not wanted.

---

### Code

#### Work

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/run.sql.j2)

#### Dimension

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-718/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-718/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-718/run.sql.j2)

#### Fact

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Fact-724/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Fact-724/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Fact-724/run.sql.j2)

#### Macro

* [Macro](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/macros/macro-1.yml)

----
