/* One active staff contract per staff */
CREATE UNIQUE INDEX uq_one_active_staff_contract
ON staff_contract (staff_id)
WHERE status = 'ACTIVE';

/* One active consultant contract per consultant */
CREATE UNIQUE INDEX uq_one_active_consultant_contract
ON consultant_contract (consultant_id)
WHERE status = 'ACTIVE';

/* One active enrollment per student */
CREATE UNIQUE INDEX uq_one_active_enrollment_per_student
ON enrollment (student_id)
WHERE status = 'ACTIVE';

/* Exactly one Program Manager per Class */
CREATE UNIQUE INDEX uq_one_pm_per_class
ON program_manager_management (class_id);

/* Prevent duplicate PM assignment rows */
CREATE UNIQUE INDEX uq_pm_assignment_unique
ON program_manager_management (staff_contract_id, class_id);

/* Prevent duplicate teaching assignment rows for the same period */
CREATE UNIQUE INDEX uq_consultant_teach_period
ON consultant_teach (consultant_id, course_id, start_date, end_date);

/* Ensure course codes are unique within a program
allows same course code in different programs
allows standalone courses (NULL program_id)*/
CREATE UNIQUE INDEX uq_course_code_per_program
ON course (program_id, course_code)
WHERE program_id IS NOT NULL;
