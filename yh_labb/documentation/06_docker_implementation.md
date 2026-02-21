# Process runbook for DML in PosgreSQL inside Docker container

Check if venv is active
```
python -c "import sys; print(sys.executable)"
```

Expected Output:
```
...data_modelling_lab_aira_franco/.venv/Scripts/python.exe
```

## Target State
- Docker Desktop is running
- A Postgres container is running via docker compose
- SQL scripts are available inside the container (via a bind mount to ./sql)
- Execute, in order:
    - \i /sql/03_queries.sql
    - \i /sql/04_demo.sql


## Path
- Check that `.env` and `docker-compose.yml` is accurate. 
- Check that all neccessary files `.env` and `docker-compose.yml` are inside `yh_labb`

## cd into the compose root
- Docker looks for relative paths
    - cd into the right root `~/de25/data_modelling_lab_aira_franco/yh_labb`

-----
# Follow this commands as a guide:
## Docker compose
- Run:
- `docker compose down -v`
- `docker compose up -d`

Expected output:
```
[+] Running 3/3
 ✔ Network yh_labb_default       Created  
 ✔ Volume yh_labb_postgres_data  Created                                                                            
 ✔ Container yrkesco_postgres    Started 
```

- verify: `docker ps`
- should see:
```Container: yrkesco_postgres
Status: Up (or Up (healthy))
Ports: 0.0.0.0:5432->5432/tcp```
- If see that → networking is fixed.

- * Run to debugg if docker status is **restarting** `docker logs yrkesco_postgres --tail 50``
- resulted chaning tag from latest to 16

## State Confirmation
- Docker container: running
- Image: postgres:16 (pinned, correct)
- Volume: fresh and compatible
- Port: 5432 bound successfully
- Env vars: valid
- SQL scripts: mounted

## Enter Linux Shell
- `docker exec -it yrkesco_postgres bash`
- Output: `root@<container_id>:/#`

- Verify sql scripts
- `ls /sql`


## Enter PostgreSQL
- `psql -U yrkesco -d yrkesco_db`
- Output: `yrkesco_db=# `
    - Means that authentication works, database exists, postgres is healthy

- schema check
    - `\dt`

### Run sql scripts:
```
    - \i /sql/03_queries.sql
    - \i /sql/04_insert_new_cohort.sql
```


----

# To Exit: Re-run scripts in psql
### Option A: Rerun ust that script
- After cleaning up typos, run `the folder name` to just re run that script.
- `\! clear` or CTRL + L to clear terminal.

### Option B: Full clean reset
#### Step 1:
- `\q` or `exit`
- gets back to `~/yh_labb`

#### Step 2: Destroy DB + volume (hard reset)
- `docker compose down -v`

#### Step 3: Start fresh
- `docker compose up -d
docker ps`

#### Step 4: Re-enter postgres
- `docker exec -it yrkesco_postgres bash
psql -U yrkesco -d yrkesco_db`

#### Step 5: Re run all files
```
\i /sql/filename.sql
```