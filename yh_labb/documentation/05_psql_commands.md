# PostgreSQL psql Terminal Commands

Commands to use when working in psql via VS Code terminal
Includes meta-commands (\), SQL, and workflow essentials

## Session and Navigation
| Command              | Category | Description          | Example                          |
| -------------------- | -------- | -------------------- | -------------------------------- |
| `psql -U user -d db` | Shell    | Connect to database  | `psql -U postgres -d yrkesco_db` |
| `\q`                 | Meta     | Quit `psql`          | `\q`                             |
| `\conninfo`          | Meta     | Show connection info | `\conninfo`                      |
| `\c dbname`          | Meta     | Switch database      | `\c test_db`                     |
| `\password`          | Meta     | Change user password | `\password postgres`             |

## Database Management
| Command           | Category | Description     | Example                                 |
| ----------------- | -------- | --------------- | --------------------------------------- |
| `\l`              | Meta     | List databases  | `\l`                                    |
| `CREATE DATABASE` | SQL      | Create database | `CREATE DATABASE lab_db;`               |
| `DROP DATABASE`   | SQL      | Delete database | `DROP DATABASE lab_db;`                 |
| `ALTER DATABASE`  | SQL      | Modify database | `ALTER DATABASE lab_db RENAME TO lab2;` |

## Schema Management
| Command           | Category | Description   | Example                       |
| ----------------- | -------- | ------------- | ----------------------------- |
| `\dn`             | Meta     | List schemas  | `\dn`                         |
| `SET search_path` | SQL      | Set schema    | `SET search_path TO public;`  |
| `CREATE SCHEMA`   | SQL      | Create schema | `CREATE SCHEMA school;`       |
| `DROP SCHEMA`     | SQL      | Drop schema   | `DROP SCHEMA school CASCADE;` |

## Table Inspection
| Command        | Category | Description          | Example          |
| -------------- | -------- | -------------------- | ---------------- |
| `\dt`          | Meta     | List tables          | `\dt`            |
| `\dt schema.*` | Meta     | List schema tables   | `\dt school.*`   |
| `\d table`     | Meta     | Table structure      | `\d student`     |
| `\d+ table`    | Meta     | Table + storage info | `\d+ enrollment` |

## Table Management
| Command          | Category | Description     | Example                                        |
| ---------------- | -------- | --------------- | ---------------------------------------------- |
| `CREATE TABLE`   | SQL      | Create table    | `CREATE TABLE student (...);`                  |
| `DROP TABLE`     | SQL      | Drop table      | `DROP TABLE student;`                          |
| `TRUNCATE TABLE` | SQL      | Delete all rows | `TRUNCATE TABLE enrollment;`                   |
| `ALTER TABLE`    | SQL      | Modify table    | `ALTER TABLE student ADD COLUMN email TEXT;`   |
| `RENAME TABLE`   | SQL      | Rename table    | `ALTER TABLE class RENAME TO education_class;` |

## Constraints and Keys
| Command       | Category | Description        | Example                                                   |
| ------------- | -------- | ------------------ | --------------------------------------------------------- |
| `PRIMARY KEY` | SQL      | Unique identifier  | `PRIMARY KEY (student_id)`                                |
| `FOREIGN KEY` | SQL      | Relationship       | `FOREIGN KEY (program_id) REFERENCES program(program_id)` |
| `UNIQUE`      | SQL      | Enforce uniqueness | `email TEXT UNIQUE`                                       |
| `NOT NULL`    | SQL      | Disallow NULL      | `name TEXT NOT NULL`                                      |
| `CHECK`       | SQL      | Validate values    | `CHECK (credits > 0)`                                     |
## Data Manipulation (DML)
| Command       | Category | Description | Example                                     |
| ------------- | -------- | ----------- | ------------------------------------------- |
| `INSERT INTO` | SQL      | Add data    | `INSERT INTO student VALUES (...);`         |
| `SELECT`      | SQL      | Query data  | `SELECT * FROM student;`                    |
| `UPDATE`      | SQL      | Update data | `UPDATE student SET name='Aira';`           |
| `DELETE FROM` | SQL      | Delete rows | `DELETE FROM enrollment WHERE term='2025';` |

## Joins and Querying
| Command      | Category | Description         | Example                                   |
| ------------ | -------- | ------------------- | ----------------------------------------- |
| `INNER JOIN` | SQL      | Matching rows       | `FROM student s JOIN enrollment e ON ...` |
| `LEFT JOIN`  | SQL      | Include non-matches | `LEFT JOIN consultant`                    |
| `GROUP BY`   | SQL      | Aggregation         | `GROUP BY program_id`                     |
| `HAVING`     | SQL      | Filter groups       | `HAVING COUNT(*) > 1`                     |
| `ORDER BY`   | SQL      | Sorting             | `ORDER BY created_at DESC`                |

## Indexes and Performance
| Command        | Category | Description   | Example                                             |
| -------------- | -------- | ------------- | --------------------------------------------------- |
| `CREATE INDEX` | SQL      | Speed queries | `CREATE INDEX idx_student_email ON student(email);` |
| `DROP INDEX`   | SQL      | Remove index  | `DROP INDEX idx_student_email;`                     |
| `EXPLAIN`      | SQL      | Query plan    | `EXPLAIN SELECT * FROM student;`                    |

## Users and Roles
| Command       | Category | Description       | Example                               |
| ------------- | -------- | ----------------- | ------------------------------------- |
| `\du`         | Meta     | List roles        | `\du`                                 |
| `CREATE ROLE` | SQL      | Create role       | `CREATE ROLE analyst;`                |
| `GRANT`       | SQL      | Give permission   | `GRANT SELECT ON student TO analyst;` |
| `REVOKE`      | SQL      | Remove permission | `REVOKE ALL ON student FROM analyst;` |

## Import and Export
| Command       | Category | Description      | Example                                             |
| ------------- | -------- | ---------------- | --------------------------------------------------- |
| `\i file.sql` | Meta     | Run SQL file     | `\i schema.sql`                                     |
| `COPY`        | SQL      | Import CSV       | `COPY student FROM '/data/student.csv' CSV HEADER;` |
| `\copy`       | Meta     | Local CSV import | `\copy student FROM 'student.csv' CSV HEADER`       |

## Transaction Control
| Command     | Category | Description       | Example          |
| ----------- | -------- | ----------------- | ---------------- |
| `BEGIN`     | SQL      | Start transaction | `BEGIN;`         |
| `COMMIT`    | SQL      | Save changes      | `COMMIT;`        |
| `ROLLBACK`  | SQL      | Undo changes      | `ROLLBACK;`      |
| `SAVEPOINT` | SQL      | Partial rollback  | `SAVEPOINT sp1;` |

## Help and Debuggin
| Command | Category | Description   | Example             |
| ------- | -------- | ------------- | ------------------- |
| `\?`    | Meta     | psql help     | `\?`                |
| `\h`    | Meta     | SQL help      | `\h SELECT`         |
| `SHOW`  | SQL      | Show settings | `SHOW search_path;` |
