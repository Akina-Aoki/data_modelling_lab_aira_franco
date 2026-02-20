# Data Modelling 
This repository contains an end-to-end data modeling and database implementation for YrkesCo, a vocational school operating across multiple campuses in Sweden. The project replaces fragmented Excel-based administration with a normalized, scalable, and auditable PostgreSQL data model, designed to support both business stakeholders and technical consumers.

### 💻 Tech Stack:
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-0db7ed?style=for-the-badge&logo=docker&logoColor=white)

### Repository Structure 

```
data_modelling_lab_aira_franco/
├── .venv/                         
├── assets/                        # Diagrams and images
├── test_python_docker/            # Docker + Python testing
│
├── yh_labb/                       # Main lab folder
│   ├── documentation/             # Business rules, documentations and notes
│   ├── models/                    # Conceptual, logical and physical models
│   └── sql/
│       ├── init/
│       │   ├── 01_ddl.sql         # Database schema
│       │   ├── 02_seed.sql        # Test data, populate data
│       ├── 03_queries.sql          # Demo queries
│       └── 04_insert_new_cohort.sql # Demo INSERT new values queries
│
├── .env                           # Environment variables
├── docker-compose.yml             # Docker setup
├── requirements.txt               # Python dependencies
├── .gitignore
├── 00_env_setup.md                # Repository Setup instructions
└── README.md
* All scripts are idempotent and safe to re-run.
```

### Table of Contents
- [File Structure](#file-structure)
- [Video](#video)
- [Deliverables](#deliverables)
- [⚡ Quick Start (Replicate This Project)](#-quick-start-replicate-this-project)
- [Prerequisites](#prerequisites)
- [Verification Checklist](#verification-checklist)
- [Conceptual & Logical Model Diagrams](#conceptual--logical-model-diagrams)
- [Documentation Index](#documentation-index)
- [Presentation PDF](#presentation-pdf)


### Project Pipeline
![Data Modeling Pipeline for this project](assets/3.png)


### Video
[![Data Modelling Video](https://img.youtube.com/vi/avt6hy4nbxQ/hqdefault.jpg)](https://youtu.be/avt6hy4nbxQ)

### Deliverables
- Conceptual, logical, and physical data models
- PostgreSQL implementation with enforced business rules
- Dockerized execution environment
- SQL demo queries proving data integrity

----

## ⚡ Quick Start (Replicate This Project)
Use the steps below to run the same workflow end-to-end. Each step links to detailed guidance in `yh_labb/documentation/`.
All scripts are idempotent and safe to re-run.

1. **Prepare your local environment**
   - Follow [00_env_setup.md](00_env_setup.md) for required tooling (`git`, `docker`, `python`) and setup checks.

2. **Review project scope and modeling decisions**
   - Business context: [01_business_requirements.md](yh_labb/documentation/01_business_requirements.md)
   - Physical model assumptions: [02_physical_model_guide.md](yh_labb/documentation/02_physical_model_guide.md)
   - 3NF justification: [03_3NF_defense.md](yh_labb/documentation/03_3NF_defense.md)

3. **Start PostgreSQL with Docker**
   - Run from `yh_labb/`:
     ```bash
     docker compose up -d
     ```
   - Command reference: [04_docker_commands.md](yh_labb/documentation/04_docker_commands.md)

4. **Initialize and verify the database**
   - Schema and seed scripts are auto-loaded from `yh_labb/sql/init/` on first container start.
   - Validate with psql: [05_psql_commands.md](yh_labb/documentation/05_psql_commands.md)
   - Full implementation walkthrough: [06_docker_implementation.md](yh_labb/documentation/06_docker_implementation.md)

5. **Run example SQL checks**
   - Execute `yh_labb/sql/03_queries.sql` and optionally `yh_labb/sql/04_insert_new_cohort.sql` to reproduce demo outputs.

6. **Shut down services when done**
   ```bash
   docker compose down
   ```

## Prerequisites
- Docker + Docker Compose
- Git
- Python 3.x (used for companion testing scripts)
- A `.env` file configured for the PostgreSQL container

For setup details, use [00_env_setup.md](00_env_setup.md).

## Verification Checklist
After startup, you should be able to verify the environment with:

```bash
# 1) Containers are running
cd yh_labb && docker compose ps

# 2) Database is reachable
# (see detailed commands in documentation/05_psql_commands.md)

# 3) Demo queries execute
# Run yh_labb/sql/03_queries.sql against the running database
```

If something fails, consult:
- Docker troubleshooting and command variants: [04_docker_commands.md](yh_labb/documentation/04_docker_commands.md)
- End-to-end implementation notes: [06_docker_implementation.md](yh_labb/documentation/06_docker_implementation.md)

----
### Conceptual Model
![Conceptual Model](yh_labb/models/Conceptual.png)

### Logical Model
![Logical Model](yh_labb/models/Logical.png)

----


## Documentation Index
- [01 Business Requirements](yh_labb/documentation/01_business_requirements.md)
- [02 Physical Model Guide](yh_labb/documentation/02_physical_model_guide.md)
- [03 3NF Defense](yh_labb/documentation/03_3NF_defense.md)
- [04 Docker Commands](yh_labb/documentation/04_docker_commands.md)
- [05 psql Commands](yh_labb/documentation/05_psql_commands.md)
- [06 Docker Implementation](yh_labb/documentation/06_docker_implementation.md)
- [Conceptual Model Notes](yh_labb/models/00_conceptual.md)
- [Logical Model Notes](yh_labb/models/01_logical.md)
- [Physical Model SQL](yh_labb/models/02_physical.sql)

### Presentation PDF
[📄 View Presentation (PDF)](yh_labb/documentation/presentation.pdf)