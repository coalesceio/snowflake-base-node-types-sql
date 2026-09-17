# SQL-First NodeTypes

The [SQL-first nodes](https://docs.coalesce.io/docs/build-your-pipeline/v2-node-types) is a transformation tool within Coalesce that lets developers write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent with the standard UI, and ships with a built-in library of column- and node-level data quality tests. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

# Coalesce Base Node Types - SQL Package

The Coalesce Base Node Types - SQL Package includes:

* [Work](#work)
* [Dimension](#dimension)

Concepts shared across every node type — quote style, hash columns, data quality tests, known limitations, and usage examples — are documented once in [Common Reference](#common-reference) and linked to from each node type below.

## Node Type Comparison

A side-by-side view of which annotations each node type supports, so it's easy to see what a given node type is missing compared to the others. `Fact` is a placeholder for when that node type is documented.

### Node Annotations Matrix

| Annotation | Work | Dimension | Fact |
|---|---|---|---|
| `@description` ***(reserved)*** | ✅ | ✅ | TBD |
| `@materializationType` ***(reserved)*** | ✅ | ✅ | TBD |
| `@writeMode` | ✅ (`truncateInsert` \| `append`) | ✅ (`truncateInsert` \| `append`) | TBD |
| `@mergeStrategy` | ➖ Not applicable | ✅ (`upsert` \| `changeTracking` \| `lastModified`) | TBD |
| `@zeroKey` (node-level) | ➖ Not applicable | ✅ | TBD |
| `@disableTests` | ✅ | ✅ | TBD |
| `@tests` | ✅ | ✅ | TBD |
| `@preSQL` | ✅ | ✅ | TBD |
| `@postSQL` | ✅ | ✅ | TBD |

### Column Annotations Matrix

| Annotation | Work | Dimension | Fact |
|---|---|---|---|
| `@notNull` ***(reserved)*** | ✅ | ✅ | TBD |
| `@description` ***(reserved)*** | ✅ | ✅ | TBD |
| `@defaultValue` ***(reserved)*** | ✅ | ✅ | TBD |
| `@inHash` | ✅ | ✅ | TBD |
| `@isBusinessKey` | ➖ Not applicable | ✅ ***(required)*** | TBD |
| `@lastModifiedTracking` | ➖ Not applicable | ✅ | TBD |
| `@isChangeTracking` | ➖ Not applicable | ✅ | TBD |
| `@zeroKey` (column-level) | ➖ Not applicable | ✅ | TBD |
| `@isSurrogateKey` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@isSystemVersion` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@isSystemCurrentFlag` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@isSystemCreateDate` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@isSystemUpdateDate` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@isSystemEndDate` | ➖ Not applicable | ✅ *(agentic creation only)* | TBD |
| `@not_null` / `@uniqueness` / `@empty` / `@accepted_values` / `@rejected_values` / `@min_max` / `@min_value` / `@max_value` / `@freshness` / `@relative_time` | ✅ | ✅ | TBD |

> **Legend:** ✅ Supported · ➖ Not applicable to this node type's model · **TBD** node type not yet documented.<br/>See [Column-Level Data Quality Tests](#column-level-data-quality-tests) for the shared quality-test annotations in the last row.

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
| `@tests(querySQL, continueOnFailure?, runOrder?)`**²** | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>[Refer to Node-Level Tests for more details.](#node-level-tests---tests)<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")` |
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
| `@inHash("<hashName>", <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>[Refer to Hash Columns for more details.](#hash-columns---get_hash)<br/>Example:<br/>`<col_name> AS <col_name> @inHash("GH_COL", 1),`<br/>`{{ get_hash('GH_COL') }}::STRING AS "GH_COL"`|

<img width="792" height="824" alt="image" src="https://github.com/user-attachments/assets/b8559c63-db38-4c09-ad5b-5ae12fb0c870" />

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

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Dimension table or view will be created |

> **Note:** `Deploy Enabled` (the setting that lets a Node be excluded from — or dropped during — redeployment based on a TRUE/FALSE toggle) is **not supported** on this node types.

### Dimension Node Annotations

| **Property** | **Description** |
|---------|-------------|
| `@id(id)` ***(reserved)*** | Unique identifier for the node.<br/>Static and auto-generated when the node is created — not meant to be edited. |
| `@nodeType(type)` ***(reserved)*** | Identifies the node's type.<br/>Set automatically based on the node type chosen when the node is created.|
| `@description(text)` ***(reserved)*** | Node-level description.<br/>Can be edited via this annotation or in the node description field below the node name in the UI.<br/>Example: `@description("Table description")` |
| `@materializationType(type)` ***(reserved)*** | table/view.<br/>Value is strictly case-sensitive — must be lowercase `table` or `view`.<br/>*Not specified in the SQL editor → defaults to **table**.*<br/>Example: `@materializationType("view")` |
| `@writeMode("truncateInsert \| append")` | **truncateInsert** — clears the table before loading, replacing its contents entirely.<br/>**append** — inserts the new rows via merge, alongside whatever is already there.<br/>*Not specified in the SQL editor → defaults to **append**.*<br/>**Note:** Ignored on Views.<br/>Example: `@writeMode("truncateInsert")` |
| `@mergeStrategy("upsert \| changeTracking \| lastModified")` | Chooses how this dimension decides a row has changed, and therefore which column annotations it requires.<br/>**upsert** — no change detection at all; a matched row is always updated, an unmatched row is inserted. Doesn't assert any SCD type of its own — if the upstream SELECT/CTE already implements SCD1/SCD2 logic, this strategy just merges that result through as-is. Requires no `@lastModifiedTracking`/`@isChangeTracking` columns — the run fails if either is present.<br/>**changeTracking** — compares columns marked `@isChangeTracking` (or, if none are marked, every plain attribute column) to detect a change. SCD Type 2 if any column is marked `@isChangeTracking`, otherwise SCD Type 1. Requires no `@lastModifiedTracking` column — the run fails if one is present.<br/>**lastModified** — compares a single `@lastModifiedTracking` timestamp column against the target's stored value. Requires exactly one column marked `@lastModifiedTracking`. SCD Type 1 or 2 comes from that column's own `scdType` parameter.<br/>*Not specified in the SQL editor → defaults to **changeTracking** - SCD Type 1.*<br/>**Note:** Ignored on Views.<br/>Example: `@mergeStrategy("lastModified")` |
| `@zeroKey(surrogateKeyValue?, stringValue?, timestampValue?, booleanValue?)` | Inserts a default "zero key" record into the target — a placeholder row used to catch unresolved foreign key lookups.<br/>**surrogateKeyValue** — value used for the zero record's surrogate key column. Default `"0"`.<br/>**stringValue** — default value for string/varchar columns. Default `"UNKNOWN"`.<br/>**timestampValue** — default value for date/time/timestamp columns. Default `"1900-01-01 00:00:00"`.<br/>**booleanValue** — default value for boolean columns. Default `true`.<br/>*Not specified in the SQL editor → the zero record is not inserted.*<br/>**Note:** Ignored on Views.<br/>Example: `@zeroKey("0", "UNKNOWN", "1900-01-01 00:00:00", true)` |
| `@disableTests`**²** | Controls whether configured tests are skipped.<br/>*Specified in the SQL editor → all node- and column-level tests are skipped.*<br/>*Not specified in the SQL editor → tests run normally.*<br/>To turn tests back on, remove the annotation. Useful while developing a node — iterate on the SQL first, then re-enable once the logic is settled.<br/>Example: `@disableTests` |
| `@tests(querySQL, continueOnFailure?, runOrder?)`**²** | ***(repeatable)*** Node-level data quality test.<br/>Runs `querySQL` against the target; fails if it returns any records.<br/>Skipped entirely when **@disableTests** is set.<br/>[Refer to Node-Level Tests for more details.](#node-level-tests---tests)<br/>Example: `@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")` |
| `@preSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `before` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@preSQL("DELETE FROM {{ this }} WHERE N_LOAD_DATE < DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)")` |
| `@postSQL(querySQL)` | ***(repeatable)*** SQL statement to execute `after` the data load operation.<br/>Repeat the annotation to run multiple statements, in the order they appear.<br/>**Note:** Ignored on Views.<br/>Example: `@postSQL("INSERT INTO {{ ref('AUDIT', 'LOAD_LOG') }} (TABLE_NAME, LOAD_TS) VALUES ('DIM_NATION', CURRENT_TIMESTAMP())")` |

>**Note:** Quote style matters for **case-sensitive** identifiers when writing `@tests`, `@preSQL`, and `@postSQL` — see [Quote Style for Case-Sensitive Identifiers](#quote-style-for-case-sensitive-identifiers).

### Dimension Column Annotations

| **Property** | **Description** |
|---------|-------------|
| `@isBusinessKey` ***(required)*** | Marks a column as part of the business key used to match existing rows during the merge.<br/>**Note:** Ignored on Views.<br/>Example: `@isBusinessKey` |
| `@lastModifiedTracking(scdType?)` | Marks the column used to detect newer source rows for an incremental load.<br/>Datatype — DATE/TIME or any incrementing NUMERIC type.<br/>Can only be applied to one column.<br/>**scdType** — `1` overwrites the row in place, `2` expires the row and inserts a new version. *Not specified → defaults to 1.*<br/>**Note:** Ignored on Views.<br/>Example: `@lastModifiedTracking(2)` |
| `@isChangeTracking` | Marks a column to be watched for changes that decide SCD type.<br/>Marked on any column → SCD Type 2 — a change expires the existing row and inserts a new version.<br/>Not marked on any column → SCD Type 1 — a change updates the row in place.<br/>**Note:** Ignored on Views.<br/>Example: `@isChangeTracking` |
| `@zeroKey(value)` | Adds a custom zero key value (ghost record) to this column, overriding the node-level `@zeroKey` defaults for it.<br/>The value is pasted into the SQL verbatim, so quote it to match the column's data type.<br/>**Note:** Ignored unless `@zeroKey` is enabled at the node level, and ignored on Views.<br/>Example: `@zeroKey("'N/A'")` |
| `@inHash("<hashName>", <hashOrder>)`**¹** | ***(repeatable)*** Marks a column as an input to a generated hash key.<br/>**hashName** — columns sharing the same value are grouped together into the same hash.<br/>**hashOrder** — this column's position within that group.<br/>Call `get_hash("<hashName>")` elsewhere in the SELECT to produce the hash column from the marked columns.<br/>[Refer to Hash Columns for more details.](#hash-columns---get_hash)<br/>Example:<br/>`<col_name> AS <col_name> @inHash("GH_COL", 1),`<br/>`{{ get_hash('GH_COL') }}::STRING AS "GH_COL"`|
| `@isSurrogateKey` | Marks this column as the node's surrogate key.<br/>Optional for SCD Type 1 — the merge logic joins and detects changes entirely off the business key.<br/>Recommended for SCD Type 2 — a stable surrogate key per version is the standard way to identify a versioned row, though it isn't enforced by the merge itself.<br/>Required only when the node-level `@zeroKey` is set, since the zero/ghost record is matched against the target by surrogate key value.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `0 AS "{{NODE_NAME}}_KEY" @isSurrogateKey` |
| `@isSystemVersion` | Marks this column as the SCD version number, incremented each time a business key gets a new version.<br/>Required for SCD Type 2 — shows which version of a row this is; each time a business key's row changes, the expired row is kept and a new row is inserted with this value incremented by 1.<br/>Optional for SCD Type 1 — new-vs-existing is detected off the business key alone, so this column can be dropped entirely; if kept, it is always written as 1 and never incremented.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `1 AS "SYSTEM_VERSION" @isSystemVersion` |
| `@isSystemCurrentFlag` | Marks this column as the SCD "is current" flag — `'Y'` on the active version of a row, overwritten to `'N'` when it's expired.<br/>Required for SCD Type 2 — used to filter the target down to each business key's one current row before comparing it against the incoming source row.<br/>Optional for SCD Type 1 — safe to omit; if kept, it is always written as `'Y'`.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag` |
| `@isSystemCreateDate` | Marks this column as the timestamp a row (or, under SCD Type 2, a specific row version) was first created.<br/>Required unless `@mergeStrategy` is `upsert` — under `changeTracking`/`lastModified` it's read back from the target and preserved unchanged on every row after its initial insert. Under `upsert`, no change detection reads the target at all, so this column isn't required.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate` |
| `@isSystemUpdateDate` | Marks this column as the timestamp a row was last updated.<br/>Required for SCD Type 2 — read back from the target and refreshed to the current timestamp whenever a row is inserted as a new version or its prior current version is expired.<br/>Required for SCD Type 1 — recomputed to the current timestamp on every inserted or changed row, so every row change carries an audit trail of when it was last updated.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate` |
| `@isSystemEndDate` | Marks this column as the SCD Type 2 expiration timestamp — a far-future sentinel while the row is current, set to the actual expiry time once superseded.<br/>Required for SCD Type 2 — this is what makes a version's active window queryable; omitting it leaves expired versions with no expiry marker.<br/>Optional for SCD Type 1 (no versioning, so nothing ever expires) — safe to omit entirely.<br/>**Note:** Ignored on Views. Agentic creation only — manual creation adds this column automatically.<br/>Expected expression: `CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate` |

🚦 The full set of column-level data quality tests (`@not_null`, `@uniqueness`, `@empty`, `@accepted_values`, `@rejected_values`, `@min_max`, `@min_value`, `@max_value`, `@freshness`, `@relative_time`) applies to Dimension columns exactly as described in [Column-Level Data Quality Tests](#column-level-data-quality-tests).

---

### Dimension SCD Type & System Column Requirements

`@mergeStrategy` picks the change-detection strategy; which SCD type it resolves to (and therefore which system columns are required) depends on that strategy and, for `changeTracking`/`lastModified`, on which columns are marked:

| `@mergeStrategy` | Resolves to | Driven by |
|---|---|---|
| `upsert` | Whatever SCD shape the upstream SELECT/CTE already implements — Coalesce doesn't detect or enforce SCD1/SCD2 here, it just merges the result through as-is | User's own SQL logic, not any column annotation |
| `lastModified` | SCD1 or SCD2, from that column's own `scdType` parameter | `@lastModifiedTracking(scdType)` |
| `changeTracking` (default) | SCD2 if any column is marked, otherwise SCD1 | `@isChangeTracking` |

Requirement level of each column annotation, by resolved strategy/SCD type:

| Annotation | Category | SCD1 (`changeTracking` / `lastModified`) | SCD2 (`changeTracking` / `lastModified`) | `upsert` |
|---|---|:---:|:---:|:---:|
| `@isBusinessKey` | Key | 🔴 Required | 🔴 Required | 🔴 Required |
| `@isSurrogateKey` | Key | ⚪ Optional | 🟡 Recommended | ⚪ Optional |
| `@isSystemCreateDate` | System column | 🔴 Required | 🔴 Required | ⚪ Optional¹ |
| `@isSystemUpdateDate` | System column | 🔴 Required | 🔴 Required | ⚪ Optional¹ |
| `@isSystemVersion` | System column | ⚪ Optional | 🔴 Required | ⚪ Optional¹ |
| `@isSystemCurrentFlag` | System column | ⚪ Optional | 🔴 Required | ⚪ Optional¹ |
| `@isSystemEndDate` | System column | ⚪ Optional | 🔴 Required | ⚪ Optional¹ |
| `@lastModifiedTracking` | Change-detection driver | ⚪ Optional | ⚪ Optional | 🚫 Not allowed² |
| `@isChangeTracking` | Change-detection driver | N/A³ | ⚪ Optional³ | 🚫 Not allowed² |
| `@zeroKey` (column) | Ghost record override | ⚪ Optional⁴ | ⚪ Optional⁴ | ⚪ Optional⁴ |
| `@inHash` | Utility | ⚪ Optional | ⚪ Optional | ⚪ Optional |

**Legend:** 🔴 Required · 🟡 Recommended · ⚪ Optional · 🚫 Not allowed

¹ If present, Coalesce auto-populates it on insert/update with a sensible default (e.g. `SYSTEM_VERSION` → 1, `SYSTEM_CURRENT_FLAG` → `'Y'`) rather than reading it from the source — `upsert` never reads the target back to compare, so these aren't required for change detection.<br/>
² The run fails if either is present on an `upsert` node — they'd silently be ignored otherwise.<br/>
³ Marking `@isChangeTracking` on any column is itself what makes the node SCD2 under `changeTracking`.<br/>
⁴ Only meaningful if node-level `@zeroKey` is set.

---

### Dimension Deployment

#### Dimension Initial Deployment

When deployed for the first time into an Environment the Dimension Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Dimension Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Dimension View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Dimension Load

Every deployment of a Dimension Node of materialization type table runs its configured data quality tests, then merges data into the target using the stages below, depending on the resolved `@mergeStrategy` and SCD type:

| **Stage** | **Description** |
|-----------|----------------|
| **Truncate table** | Executed only when `@writeMode("truncateInsert")` is set — clears the target before the merge. |
| **Load table Using Merge - Zero Key Record** | Executed only when node-level `@zeroKey` is set and a surrogate key column exists — merges the placeholder "zero key" row into the target. |
| **Load table Using Merge - Upsert** | Executed for `@mergeStrategy("upsert")` — merges source rows straight through with no change detection. |
| **Load table Using Merge - Last Modified Comparison - SCD1 \| SCD2** | Executed for `@mergeStrategy("lastModified")` — compares the `@lastModifiedTracking` column against the target to detect changes, then updates in place (SCD1) or versions the row (SCD2) per that column's `scdType`. |
| **Load table Using Merge - Change Tracking - SCD1 \| SCD2** | Executed for `@mergeStrategy("changeTracking")` (the default) — compares `@isChangeTracking` columns (or, absent any, every plain attribute column) against the target, then updates in place (SCD1) or versions the row (SCD2). |

#### Dimension Redeployment

After the Dimension Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Dimension Table or recreating the Dimension table, following the same rules as [Work Redeployment](#work-redeployment) — changing table names, dropping existing columns, altering column data types, or adding new columns all result in an ALTER statement via clone-and-swap, while changing materialization type from Table to View drops and recreates the object.

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

### Column-Level Data Quality Tests

🚦 Applicable only when `@disableTests` is not set. Each runs **After** the load and continues the run on failure. *Not specified in the SQL editor → test is off.*

| **Property** | **Description** |
|---------|-------------|
| `@not_null` | Fails on rows where the column is NULL.<br/>Example: `@not_null` |
| `@uniqueness` | Fails when a value appears on more than one row.<br/>Example: `@uniqueness` |
| `@empty` | Fails on rows where the column trims to the empty string.<br/>NULL values pass this test — they're caught by `@not_null` instead.<br/>Example: `@empty` |
| `@accepted_values("<value>")` | ***(repeatable)*** Fails on rows whose value is outside the allow list.<br/>Repeat once per permitted value.<br/>Quote to match the column's data type — <br/>number: `accepted_values("<num>")`<br/>string: `accepted_values("'<string>'")`.<br/>Example: `@accepted_values("'ALGERIA'")` |
| `@rejected_values("<value>")` | ***(repeatable)*** Fails on rows whose value is in the deny list.<br/>Repeat once per forbidden value.<br/>Same quoting rules as `accepted_values`.<br/>Example: `@rejected_values("'NA'")` |
| `@min_max("<min>", "<max>")` | Fails on rows outside the inclusive range.<br/>Bounds are pasted into the SQL verbatim —<br/>number: `"0"`,<br/>date: `"DATE '2026-01-01'"`.<br/>Example: `@min_max("0", "4")` |
| `@min_value("<min>")` | Fails on rows below the bound.<br/>Value formatting — see `min_max`.<br/>Example: `@min_value("0")` |
| `@max_value("<max>")` | Fails on rows above the bound.<br/>Value formatting — see `min_max`.<br/>Example: `@max_value("100")` |
| `@freshness(<interval>, "<unit>")` | Fails when the newest value in the column is older than the given interval, or the table is empty.<br/>**interval** — how far back from now the newest value is allowed to be, expressed in the unit given by **unit**.<br/>**unit** — SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, or YEAR (defaults to DAY).<br/>**Note:** on a DATE column the value is truncated to midnight.<br/>Example: `@freshness(7, "DAY")` |
| `@relative_time("<operator>", "<other_column>")` | Compares this column against another date/time column on the same node.<br/>e.g. `@relative_time("<=", "END_DATE")` fails rows where this column's value is not `<=` END_DATE.<br/>Either side NULL → row is skipped (passes).<br/>Example: `@relative_time("<", "L_M_2")` |

### Hash Columns — get_hash()

**¹** The hash transformation uses the reusable `get_hash()` macro:

```SQL
{{ get_hash("<hash_name>", "<algo>", "<delimiter>") }}
```

| Parameter | Description |
|-----------|-------------|
| `hash_name` | Hash name used across columns to identify the columns included in the hash. |
| `algo` | **(optional)** Hashing algorithm to use. Supported values include `SHA1` and `SHA256`. Defaults to `SHA1`. |
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

### Node-Level Tests — tests()

**²** Node level tests are performed only when `disableTests` is OFF.
```text
@tests("<querySQL>", <continueOnFailure>, "<runOrder>")
```
| Parameter | Description |
|-----------|-------------|
| querySQL | SQL statement to execute as a validation test. The test fails if the query returns any records. |
| continueOnFailure |**(optional)** `true`(default) or `false`. Determines whether execution continues when the test fails. |
| runOrder |**(optional)** `Before` or `After`(default). Determines whether the test is executed before or after the load operation. |

#### tests() Examples

```text
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", true, "Before")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", false)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
```

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
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null @uniqueness @min_value("0") @max_value("100")  @accepted_values("1") @inHash("GH_COL1", 2),
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

### Code

#### Work

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Work-707/run.sql.j2)

#### Dimension

* [Node definition](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-4a720337-2713-45a5-b3f2-2d47d7abe3e5/definition.yml)
* [Create Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-4a720337-2713-45a5-b3f2-2d47d7abe3e5/create.sql.j2)
* [Run Template](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/nodeTypes/Dimension-4a720337-2713-45a5-b3f2-2d47d7abe3e5/run.sql.j2)

#### Macro

* [Macro](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/macros/macro-1.yml)

