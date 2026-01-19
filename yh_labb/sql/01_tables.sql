/* =========================================================
   1. CORE REFERENCE TABLES (no foreign keys)
   ========================================================= */

CREATE TABLE program (
  program_id VARCHAR(10) PRIMARY KEY,
  program_name VARCHAR(50) NOT NULL,
  program_credits INTEGER NOT NULL CHECK (program_credits > 0),
  program_description TEXT
);

CREATE TABLE campus (
  campus_id VARCHAR(10) PRIMARY KEY,
  campus_name VARCHAR(30) NOT NULL,
  city VARCHAR(30) NOT NULL
);

CREATE TABLE private_details (
  private_details_id VARCHAR(10) PRIMARY KEY,
  personal_identity_number CHAR(12) NOT NULL UNIQUE
    CHECK (personal_identity_number ~ '^[0-9]{12}$'),
  email VARCHAR(255) NOT NULL UNIQUE,
  address TEXT NOT NULL
);

CREATE TABLE consultant_company (
  consultant_company_id VARCHAR(10) PRIMARY KEY,
  company_name VARCHAR(100) NOT NULL,
  organization_number CHAR(10) NOT NULL UNIQUE
    CHECK (organization_number ~ '^[0-9]{10}$'),
  f_tax_status BOOLEAN NOT NULL,
  address TEXT NOT NULL
);

/* =========================================================
   2. PEOPLE TABLES
   ========================================================= */

CREATE TABLE staff (
  staff_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,

  FOREIGN KEY (private_details_id)
    REFERENCES private_details(private_details_id)
    ON DELETE RESTRICT
);

CREATE TABLE consultant (
  consultant_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,
  consultant_company_id VARCHAR(10) NOT NULL,

  FOREIGN KEY (private_details_id)
    REFERENCES private_details(private_details_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (consultant_company_id)
    REFERENCES consultant_company(consultant_company_id)
    ON DELETE RESTRICT
);

CREATE TABLE student (
  student_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,

  FOREIGN KEY (private_details_id)
    REFERENCES private_details(private_details_id)
    ON DELETE RESTRICT
);

/* =========================================================
   3. EDUCATION STRUCTURE
   ========================================================= */

CREATE TABLE course (
  course_id VARCHAR(10) PRIMARY KEY,
  program_id VARCHAR(10),
  course_code VARCHAR(20) NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  course_credits INTEGER NOT NULL CHECK (course_credits > 0),
  course_description TEXT,

  FOREIGN KEY (program_id)
    REFERENCES program(program_id)
    ON DELETE RESTRICT
);

CREATE TABLE class (
  class_id VARCHAR(10) PRIMARY KEY,
  program_id VARCHAR(10) NOT NULL,
  campus_id VARCHAR(10) NOT NULL,
  class_name VARCHAR(50) NOT NULL,
  class_code VARCHAR(20) NOT NULL,
  academic_year VARCHAR(9) NOT NULL,

  FOREIGN KEY (program_id)
    REFERENCES program(program_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (campus_id)
    REFERENCES campus(campus_id)
    ON DELETE RESTRICT
);

/* =========================================================
   4. CONTRACTS
   ========================================================= */

CREATE TABLE staff_contract (
  staff_contract_id VARCHAR(10) PRIMARY KEY,
  staff_id VARCHAR(10) NOT NULL,
  role VARCHAR(30) NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  salary NUMERIC(10,2) NOT NULL,
  campus_id VARCHAR(10) NOT NULL,

  FOREIGN KEY (staff_id)
    REFERENCES staff(staff_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (campus_id)
    REFERENCES campus(campus_id)
    ON DELETE RESTRICT,

  CHECK (end_date >= start_date),
  CHECK (status IN ('ACTIVE','ENDED','PAUSED','PLANNED'))
);

CREATE TABLE consultant_contract (
  consultant_contract_id VARCHAR(10) PRIMARY KEY,
  consultant_id VARCHAR(10) NOT NULL,
  role VARCHAR(30) NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  hourly_rate NUMERIC(10,2) NOT NULL,
  campus_id VARCHAR(10) NOT NULL,

  FOREIGN KEY (consultant_id)
    REFERENCES consultant(consultant_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (campus_id)
    REFERENCES campus(campus_id)
    ON DELETE RESTRICT,

  CHECK (end_date >= start_date),
  CHECK (status IN ('ACTIVE','ENDED','PAUSED','PLANNED'))
);


/* =========================================================
   5. ASSOCIATIVE TABLES
   ========================================================= */

CREATE TABLE enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id VARCHAR(10) NOT NULL,
  class_id VARCHAR(10) NOT NULL,
  enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
  status VARCHAR(20) NOT NULL,

  FOREIGN KEY (student_id)
    REFERENCES student(student_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (class_id)
    REFERENCES class(class_id)
    ON DELETE RESTRICT,

  CHECK (status IN ('ACTIVE','COMPLETED','WITHDRAWN'))
);


CREATE TABLE consultant_teach (
  consultant_teach_id SERIAL PRIMARY KEY,
  consultant_id VARCHAR(10) NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,

  FOREIGN KEY (consultant_id)
    REFERENCES consultant(consultant_id)
    ON DELETE RESTRICT,

  FOREIGN KEY (course_id)
    REFERENCES course(course_id)
    ON DELETE RESTRICT,

  CHECK (end_date >= start_date)
);

/* =========================================================
   6. PROGRAM MANAGER MANAGEMENT
   ========================================================= */

CREATE TABLE program_manager_management (
  pm_management_id VARCHAR(10) PRIMARY KEY,
  staff_contract_id VARCHAR(10) NOT NULL,
  class_id VARCHAR(10) NOT NULL,

  FOREIGN KEY (staff_contract_id)
    REFERENCES staff_contract(staff_contract_id)
    ON DELETE RESTRICT,
    
  FOREIGN KEY (class_id)
    REFERENCES class(class_id)
    ON DELETE RESTRICT
);
