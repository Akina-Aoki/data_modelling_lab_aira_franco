CREATE TABLE program (
  program_id PRIMARY KEY CHECK (program_id ~ '^[A-Za-z0-9]+$'),
  program_name VARCHAR(20) NOT NULL,
  program_credits INTEGER NOT NULL CHECK (program_credits > 0),
  program_description TEXT
);


CREATE TABLE campus (
  campus_id PRIMARY KEY CHECK (campus_id ~ '^[A-Za-z0-9]+$'),
  campus_name VARCHAR(30),
  city(10)
);

CREATE TABLE private_details (
  private_details_id PRIMARY KEY CHECK (private_details_id ~ '^[A-Za-z0-9]+$'),
  personal_identity_number VARCHAR(12) NOT NULL UNIQUE CHECK (personal_identity_number ~ '^[0-9]{12}$'),
  email VARCHAR(255) NOT NULL UNIQUE,
  address TEXT NOT NULL
);

CREATE TABLE consultant_company (
  consultant_company_id INTEGER PRIMARY KEY,
  company_name VARCHAR(30) NOT NULL,
  organization_number CHAR(10) NOT NULL UNIQUE CHECK (organization_number ~ '^[0-9]{10}$'),
  f_tax_status BOOLEAN NOT NULL,
  address TEXT NOT NULL
);

CREATE TABLE staff (
  staff_id INTEGER PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  private_details_id INTEGER NOT NULL UNIQUE,

  FOREIGN KEY (private_details_id)
    REFERENCES private_details(private_details_id)
);

CREATE TABLE consultant (
  consultant_id INTEGER PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,

  private_details_id INTEGER NOT NULL UNIQUE
    REFERENCES private_details(private_details_id),

  consultant_company_id INTEGER NOT NULL
    REFERENCES consultant_company(consultant_company_id)
);

CREATE TABLE student (
  student_id VARCHAR(10) PRIMARY KEY CHECK (student_id ~ '^[A-Za-z0-9]+$'),
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,

  private_details_id INTEGER NOT NULL UNIQUE
    REFERENCES private_details(private_details_id)
);

CREATE TABLE course ();

CREATE TABLE class (
  class_id VARCHAR(10) PRIMARY KEY CHECK (class_id ~ '^[A-Z0-9]+$'),
  program_id VARCHAR(10) NOT NULL,
  campus_id INTEGER NOT NULL,
  class_name VARCHAR(20) NOT NULL,
  class_code VARCHAR(20) NOT NULL,
  academic_year VARCHAR(9) NOT NULL,
);

CREATE TABLE staff_contract ();

CREATE TABLE consultant_contract ();

CREATE TABLE enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id VARCHAR(10) NOT NULL,
  class_id INTEGER NOT NULL,
  enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
  status VARCHAR(20) NOT NULL,

  CONSTRAINT fk_enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES student(student_id)
    ON DELETE RESTRICT,

  CONSTRAINT chk_enrollment_status
    CHECK (status IN ('ACTIVE', 'COMPLETED', 'WITHDRAWN'))
);

CREATE TABLE consultant_teach ();

CREATE TABLE program_manager_management ();