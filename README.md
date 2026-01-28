# Data Modelling 
This repository contains an end-to-end data modeling and database implementation for YrkesCo, a vocational school operating across multiple campuses in Sweden. The project replaces fragmented Excel-based administration with a normalized, scalable, and auditable PostgreSQL data model, designed to support both business stakeholders and technical consumers.

# 💻 Tech Stack:
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-0db7ed?style=for-the-badge&logo=docker&logoColor=white)

## Presentation PDF
[📄 View Presentation (PDF)](yh_labb/documentation/presentation.pdf)

## Deliverables
- Conceptual, logical, and physical data models
- PostgreSQL implementation with enforced business rules
- Dockerized execution environment
- SQL demo queries proving data integrity

Presentation PDF and video pitch (linked in repository)

## Dockerized Architecture
- PostgreSQL runs in an isolated container
- SQL initialization scripts are mounted read-only
- Named volumes ensure data persistence across restarts
- Environment variables are managed via `.env`

## File Structure 

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

## Videos
[![Data Modelling Video](https://www.youtube.com/watch?v=L8Wg-WHX-T8)

## Project Pipeline
![Data Modeling Pipeline](assets/3.png)
