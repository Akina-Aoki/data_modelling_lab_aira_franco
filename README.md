# data_modelling_lab_aira_franco
The purpose of this lab is to apply knowledge of data modelling by designing a database for a vocational school.

# Project Environment Set up
- In bash terminal, run the following commands under folder of choice:
```bash
git clone <repository_url>
```
<br>

- Set up and activate a virtual environment in VSCode Terminal:
```bash
python -m venv .venv
```

```bash
source .venv/Scripts/activate
```

<br>

- Validate that the virtual environment is activated and using the correct Python version:
```bash
python --version
which python
```

<br>

- (Optional) Set up Docker if not installed 
[Instructions here](https://github.com/AIgineerAB/data_modeling_course/tree/main/05_setup_postgres)

<br>

- Add PostgreSQL Extension
**PostgreSQL** extension by Chris Kolkman in VSCode
- DBML Entity-Relationship Diagrams visualizer

- pip install packages (in the repo instructions)

```bash
pip install ipykernel openpyxl pandas psycopg2-binary python-dotenv sqlalchemy
```

#### This provisions:
- `ipykernel` – Jupyter kernel integration for VS Code
- `openpyxl` – Excel I/O
- `pandas` – data manipulation layer
- `psycopg2-binary` – PostgreSQL driver
- `python-dotenv` – environment variable injection
- `sqlalchemy` – ORM / SQL abstraction layer

- Might need updating, then run:

```bash
python.exe -m pip install --upgrade pip
```

- Expected Output:

```bash
Successfully installed pip-25.3
(.venv) 
```