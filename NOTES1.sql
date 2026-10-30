-- ============================================================================
-- MASTER SQL SCRIPT: Comprehensive Demonstration of All SQL Commands & Keywords
-- ============================================================================

-- 1. TRANSACTION CONTROL LANGUAGE (TCL) & SESSION SETUP
-- BEGIN: Starts a new transaction (A transaction in SQL is a single unit of work that groups one or more operations (INSERT, UPDATE, DELETE)) block.
BEGIN;

-- SET TRANSACTION: Configures transaction-level characteristics like isolation level.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- SET CONSTRAINTS: Controls when constraint checks are evaluated (e.g., DEFERRED).
SET CONSTRAINTS ALL DEFERRED;

-- 2. SESSION-LEVEL CONFIGURATION (SET, SHOW, RESET)
-- SET: Modifies runtime parameters for the session.
SET search_path TO public;

-- SHOW: Displays the current value of a runtime parameter.
SHOW search_path;

-- RESET: Restores a runtime parameter to its default value.
RESET search_path;

-- 3. DATA DEFINITION LANGUAGE (DDL)
-- CREATE: Defines and builds a new database object (Table).
CREATE TABLE employees_audit (
    emp_id INT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC
);

-- ALTER: Modifies the structure of an existing database object.
ALTER TABLE employees_audit ADD COLUMN status VARCHAR(20) DEFAULT 'ACTIVE';

-- SAVEPOINT: Sets a point within a transaction to which you can roll back.
SAVEPOINT sp_after_ddl;

-- 4. DATA MANIPULATION LANGUAGE (DML)
-- INSERT: Adds new rows of data into a table.
INSERT INTO employees_audit (emp_id, emp_name, department, salary) 
VALUES (1, 'Alice Smith', 'Engineering', 95000);

-- UPDATE: Modifies existing data within a table.
UPDATE employees_audit 
SET salary = salary * 1.10 
WHERE department = 'Engineering';

-- MERGE: Conditionally inserts, updates, or deletes rows in a target table based on source data.
MERGE INTO employees_audit AS target
USING (VALUES (1, 'Alice Smith', 'Engineering', 104500)) AS source (emp_id, emp_name, department, salary)
ON target.emp_id = source.emp_id
WHEN MATCHED THEN
    UPDATE SET salary = source.salary;

-- COPY: Copies data between a table and standard file-system input/output streams.
-- COPY employees_audit TO STDOUT WITH CSV;

-- 5. DATA QUERY LANGUAGE (DQL), CONJUNCTIONS & PREPOSITIONS
-- SELECT: Retrieves rows from one or more tables.
-- TABLE: Shortcut equivalent to SELECT * FROM table_name.
-- VALUES: Computes a row value or set of row values.
-- FROM: Specifies the source table or relation data originates from.
-- AS: Acts as an alias bridge, renaming tables or columns for the query scope.
-- BETWEEN, AND, OR, NOT, LIKE, ILIKE, IN: Filtering conditions and logical/relational connectors.
SELECT 
    emp_id, 
    emp_name, 
    department, 
    salary
FROM employees_audit AS e
WHERE e.salary BETWEEN 50000 AND 120000
  AND (e.department LIKE 'Eng%' OR e.department ILIKE 'eng%')
  AND e.emp_id NOT IN (999)
  AND e.department IN ('Engineering', 'R&D');

-- SET CONJUNCTIONS & OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT)
-- UNION: Combines result sets and removes duplicates.
SELECT emp_name FROM employees_audit WHERE department = 'Engineering'
UNION
-- UNION ALL: Combines result sets retaining all duplicates.
SELECT emp_name FROM employees_audit WHERE salary > 90000
-- INTERSECT: Returns only rows common to both query results.
INTERSECT
SELECT emp_name FROM employees_audit
-- EXCEPT: Returns rows from the first query that do not appear in the second.
EXCEPT
SELECT emp_name FROM employees_audit WHERE emp_id = 999;

-- GROUP BY, HAVING, ORDER BY, BY: Directional connectors for aggregation and sorting.
SELECT department, COUNT(*) AS total_employees
FROM employees_audit
GROUP BY department
HAVING COUNT(*) > 0
ORDER BY total_employees DESC;

-- 6. PERFORMANCE ANALYSIS & UTILITIES
-- EXPLAIN: Analyzes and outputs the query execution plan (vital for query optimization).
EXPLAIN SELECT * FROM employees_audit;

-- PREPARE / EXECUTE / DEALLOCATE: Precompiled statements for parameterized execution.
PREPARE get_emp (INT) AS 
    SELECT emp_name FROM employees_audit WHERE emp_id = $1;
EXECUTE get_emp(1);
DEALLOCATE get_emp;

-- 7. CURSORS (DECLARE, FETCH, MOVE, CLOSE)
-- DECLARE: Defines a cursor for fetching massive datasets in chunks.
DECLARE emp_cursor CURSOR FOR SELECT emp_name FROM employees_audit;
-- FETCH: Retrieves rows from a cursor.
FETCH 1 FROM emp_cursor;
-- MOVE: Moves the cursor position without retrieving data.
MOVE FORWARD 1 FROM emp_cursor;
-- CLOSE: Closes a cursor, releasing its associated resources.
CLOSE emp_cursor;

-- 8. ASYNCHRONOUS MESSAGING & ROUTINE EXECUTION
-- NOTIFY: Sends an asynchronous notification signal inside the database.
NOTIFY emp_channel, 'Employee records updated';
-- LISTEN: Listens for asynchronous notifications on a database channel.
LISTEN emp_channel;
-- CALL: Invokes a stored procedure or routine (utility execution wrapper).
-- CALL process_monthly_payroll();

-- 9. DATABASE MAINTENANCE (VACUUM, REINDEX, CLUSTER, TRUNCATE)
-- VACUUM: Reclaims storage space and updates statistics under heavy write loads.
VACUUM ANALYZE employees_audit;

-- REINDEX: Rebuilds corrupted or bloated database indexes.
REINDEX TABLE employees_audit;

-- CLUSTER: Physically reorders tables based on an index.
-- CLUSTER employees_audit USING idx_emp_id;

-- TRUNCATE: Rapidly empties a table of all rows (utility wrapper).
-- TRUNCATE TABLE employees_audit;

-- 10. DATA CONTROL LANGUAGE (DCL), SCOPING & OBJECT REMOVAL
-- REVOKE: Removes previously granted administrative or access privileges.
REVOKE SELECT ON employees_audit FROM PUBLIC;

-- GRANT: Directs access privileges TO a user, role, or target.
GRANT SELECT ON employees_audit TO PUBLIC;

-- OF: Specifies ownership or targeted attributes (e.g., OWNED BY or security labels).
-- ALTER TABLE employees_audit OWNER TO admin_user;

-- FOR: Denotes specific scoping or concurrency intent (e.g., FOR UPDATE).
SELECT * FROM employees_audit FOR UPDATE;

-- DROP: Removes an existing database object.
DROP TABLE employees_audit;

-- 11. TRANSACTION FINALIZATION
-- ROLLBACK; -- Reverts transaction changes if an error occurs.
COMMIT;     -- Permanently saves all transaction changes.