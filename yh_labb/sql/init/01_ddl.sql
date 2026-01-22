/* =========================================================
   01_DDL.SQL — FULL SCHEMA (IDEMPOTENT)
   Tables, constraints, indexes, functions, triggers
   ========================================================= */

/* -------------------------
   CORE REFERENCE TABLES
   ------------------------- */
CREATE TABLE IF NOT EXISTS program (
  program_id VARCHAR(10) PRIMARY KEY,
  program_name VARCHAR(50) NOT NULL,
  program_credits INTEGER NOT NULL CHECK (program_credits > 0),
  program_description TEXT
);

CREATE TABLE IF NOT EXISTS campus (
  campus_id VARCHAR(10) PRIMARY KEY,
  campus_name VARCHAR(30) NOT NULL,
  city VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS private_details (
  private_details_id VARCHAR(10) PRIMARY KEY,
  personal_identity_number CHAR(12) NOT NULL UNIQUE
    CHECK (personal_identity_number ~ '^[0-9]{12}$'),
  email VARCHAR(255) NOT NULL UNIQUE,
  address TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS consultant_company (
  consultant_company_id VARCHAR(10) PRIMARY KEY,
  company_name VARCHAR(100) NOT NULL,
  organization_number CHAR(10) NOT NULL UNIQUE
    CHECK (organization_number ~ '^[0-9]{10}$'),
  f_tax_status BOOLEAN NOT NULL,
  address TEXT NOT NULL
);

/* -------------------------
   PEOPLE
   ------------------------- */
CREATE TABLE IF NOT EXISTS staff (
  staff_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,
  FOREIGN KEY (private_details_id) REFERENCES private_details(private_details_id)
);

CREATE TABLE IF NOT EXISTS consultant (
  consultant_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,
  consultant_company_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (private_details_id) REFERENCES private_details(private_details_id),
  FOREIGN KEY (consultant_company_id) REFERENCES consultant_company(consultant_company_id)
);

CREATE TABLE IF NOT EXISTS student (
  student_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  private_details_id VARCHAR(10) NOT NULL UNIQUE,
  FOREIGN KEY (private_details_id) REFERENCES private_details(private_details_id)
);

/* -------------------------
   EDUCATION STRUCTURE
   ------------------------- */
CREATE TABLE IF NOT EXISTS course (
  course_id VARCHAR(10) PRIMARY KEY,
  program_id VARCHAR(10),
  course_code VARCHAR(20) NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  course_credits INTEGER NOT NULL CHECK (course_credits > 0),
  course_description TEXT,
  FOREIGN KEY (program_id) REFERENCES program(program_id)
);

CREATE TABLE IF NOT EXISTS class (
  class_id VARCHAR(10) PRIMARY KEY,
  program_id VARCHAR(10),
  campus_id VARCHAR(10) NOT NULL,
  class_name VARCHAR(50) NOT NULL,
  class_code VARCHAR(20) NOT NULL,
  academic_year VARCHAR(9) NOT NULL,
  FOREIGN KEY (program_id) REFERENCES program(program_id),
  FOREIGN KEY (campus_id) REFERENCES campus(campus_id)
);

/* -------------------------
   CLASS BUSINESS RULES
   ------------------------- */
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'chk_standalone_class'
  ) THEN
    ALTER TABLE class
    ADD CONSTRAINT chk_standalone_class
    CHECK (
      program_id IS NULL
      OR class_code NOT LIKE 'SC-%'
    );
  END IF;
END $$;

/* -------------------------
   CONTRACTS
   ------------------------- */
CREATE TABLE IF NOT EXISTS staff_contract (
  staff_contract_id VARCHAR(10) PRIMARY KEY,
  staff_id VARCHAR(10) NOT NULL,
  role VARCHAR(30) NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  salary NUMERIC(10,2) NOT NULL,
  campus_id VARCHAR(10) NOT NULL,
  CHECK (end_date >= start_date),
  CHECK (status IN ('ACTIVE','ENDED','PAUSED','PLANNED')),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
  FOREIGN KEY (campus_id) REFERENCES campus(campus_id)
);

CREATE TABLE IF NOT EXISTS consultant_contract (
  consultant_contract_id VARCHAR(10) PRIMARY KEY,
  consultant_id VARCHAR(10) NOT NULL,
  role VARCHAR(30) NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  hourly_rate NUMERIC(10,2) NOT NULL,
  campus_id VARCHAR(10) NOT NULL,
  CHECK (end_date >= start_date),
  CHECK (status IN ('ACTIVE','ENDED','PAUSED','PLANNED')),
  FOREIGN KEY (consultant_id) REFERENCES consultant(consultant_id),
  FOREIGN KEY (campus_id) REFERENCES campus(campus_id)
);

/* -------------------------
   ASSOCIATIVE TABLES
   ------------------------- */
CREATE TABLE IF NOT EXISTS enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id VARCHAR(10) NOT NULL,
  class_id VARCHAR(10) NOT NULL,
  enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
  status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE','COMPLETED','WITHDRAWN')),
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE IF NOT EXISTS consultant_teach (
  consultant_teach_id SERIAL PRIMARY KEY,
  consultant_id VARCHAR(10) NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL CHECK (end_date >= start_date),
  FOREIGN KEY (consultant_id) REFERENCES consultant(consultant_id),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE IF NOT EXISTS program_manager_management (
  pm_management_id VARCHAR(10) PRIMARY KEY,
  staff_contract_id VARCHAR(10) NOT NULL,
  class_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (staff_contract_id) REFERENCES staff_contract(staff_contract_id),
  FOREIGN KEY (class_id) REFERENCES class(class_id)
);

/* -------------------------
   INDEXES (SAFE)
   ------------------------- */
CREATE UNIQUE INDEX IF NOT EXISTS uq_one_active_staff_contract
ON staff_contract (staff_id) WHERE status = 'ACTIVE';

CREATE UNIQUE INDEX IF NOT EXISTS uq_one_active_consultant_contract
ON consultant_contract (consultant_id) WHERE status = 'ACTIVE';

CREATE UNIQUE INDEX IF NOT EXISTS uq_one_active_enrollment_per_student
ON enrollment (student_id) WHERE status = 'ACTIVE';

CREATE UNIQUE INDEX IF NOT EXISTS uq_one_pm_per_class
ON program_manager_management (class_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_pm_assignment_unique
ON program_manager_management (staff_contract_id, class_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_consultant_teach_period
ON consultant_teach (consultant_id, course_id, start_date, end_date);

CREATE UNIQUE INDEX IF NOT EXISTS uq_course_code_per_program
ON course (program_id, course_code) WHERE program_id IS NOT NULL;

/* -------------------------
   FUNCTIONS
   ------------------------- */
CREATE OR REPLACE FUNCTION enforce_max_three_classes()
RETURNS TRIGGER AS $$
BEGIN
  IF (SELECT COUNT(*) FROM program_manager_management
      WHERE staff_contract_id = NEW.staff_contract_id) >= 3 THEN
    RAISE EXCEPTION 'A Program Manager may manage at most 3 classes';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION enforce_pm_role()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM staff_contract
    WHERE staff_contract_id = NEW.staff_contract_id
      AND role = 'PROGRAM_MANAGER'
  ) THEN
    RAISE EXCEPTION 'Staff contract is not PROGRAM_MANAGER';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* -------------------------
   TRIGGERS (DROP + CREATE)
   ------------------------- */
DROP TRIGGER IF EXISTS trg_max_three_classes ON program_manager_management;
CREATE TRIGGER trg_max_three_classes
BEFORE INSERT ON program_manager_management
FOR EACH ROW EXECUTE FUNCTION enforce_max_three_classes();

DROP TRIGGER IF EXISTS trg_enforce_pm_role ON program_manager_management;
CREATE TRIGGER trg_enforce_pm_role
BEFORE INSERT ON program_manager_management
FOR EACH ROW EXECUTE FUNCTION enforce_pm_role();
