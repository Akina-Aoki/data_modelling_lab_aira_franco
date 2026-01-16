-- Contract Constraints
IF contract_type = 'Staff'
THEN fixed_salary IS NOT NULL
AND hourly_rate IS NULL
AND f_tax_status IS NULL

IF contract_type = 'Consultant'
THEN hourly_rate IS NOT NULL
AND f_tax_status IS NOT NULL
AND fixed_salary IS NULL


-- Mandatory constraint for program and course
-- A student, -> enrollment -> education class -> program/course
(program_id IS NOT NULL AND course_id IS NULL)
OR
(program_id IS NULL AND course_id IS NOT NULL)


CREATE TABLE "Member" (
  "member_id" INTEGER PRIMARY KEY,
  "member_name" VARCHAR NOT NULL,
  "phone" INTEGER NOT NULL
);