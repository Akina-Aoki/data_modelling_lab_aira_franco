
SELECT class_id, class_name, campus_id, academic_year
FROM class
WHERE class_id = 'DE2628';

-- ---------------------------------------------------------
-- D) Insert 4 new DE courses (Uppsala-specific curriculum)
-- NOTE: In this model, courses are tied to program, not campus.
-- These become part of DE program curriculum globally.
-- ---------------------------------------------------------
INSERT INTO course (course_id, program_id, course_code, course_name, course_credits, course_description)
VALUES
  ('DE201', 'DE', 'DE-201', 'DE Uppsala: Streaming Fundamentals', 100, 'Streaming & event-driven basics.'),
  ('DE202', 'DE', 'DE-202', 'DE Uppsala: Data Quality & Observability', 100, 'Dq checks, monitoring, alerting.'),
  ('DE203', 'DE', 'DE-203', 'DE Uppsala: Platform Engineering for Data', 100, 'Infra as code, deployment.'),
  ('DE204', 'DE', 'DE-204', 'DE Uppsala: Analytics Engineering', 100, 'Semantic models, dbt-style practices.')
ON CONFLICT (course_id) DO NOTHING;

-- Verify the new courses exist
SELECT course_id, program_id, course_code, course_name, course_credits
FROM course
WHERE course_id IN ('DE201','DE202','DE203','DE204')
ORDER BY course_id;

-- Credit validation for DE (will now exceed 400 because DE already had 4 courses)
-- This is expected with your current model because course belongs to program.
SELECT program_id, SUM(course_credits) AS total_credits
FROM course
WHERE program_id IS NOT NULL
GROUP BY program_id
ORDER BY program_id;

-- ---------------------------------------------------------
-- E) New standalone course (program_id NULL)
-- ---------------------------------------------------------
INSERT INTO course (course_id, program_id, course_code, course_name, course_credits, course_description)
VALUES ('SC200', NULL, 'SC-200', 'Standalone: Intro to Data (Remote)', 100, 'Standalone remote course not tied to a program.')
ON CONFLICT (course_id) DO NOTHING;

SELECT course_id, course_code, course_name
FROM course
WHERE program_id IS NULL
ORDER BY course_code;

-- ---------------------------------------------------------
-- F) Hire new staff for Uppsala (same roles as other campuses)
-- We will insert: private_details -> staff -> staff_contract
-- ---------------------------------------------------------

-- Private details (5 staff in Uppsala)
INSERT INTO private_details (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD301', '199201010301', 'pm.upp@yrkesco.se', 'Uppsala Staff Address 1'),
  ('PD302', '198801010302', 'admin.upp@yrkesco.se', 'Uppsala Staff Address 2'),
  ('PD303', '197701010303', 'accounting.upp@yrkesco.se', 'Uppsala Staff Address 3'),
  ('PD304', '199501010304', 'secretary.upp@yrkesco.se', 'Uppsala Staff Address 4'),
  ('PD305', '199001010305', 'instructor.upp@yrkesco.se', 'Uppsala Staff Address 5')
ON CONFLICT (private_details_id) DO NOTHING;

-- Staff rows
INSERT INTO staff (staff_id, first_name, last_name, private_details_id)
VALUES
  ('ST201', 'Patrik', 'Manager',  'PD301'),
  ('ST202', 'Annika', 'Admin',    'PD302'),
  ('ST203', 'Kalle', 'Finance',  'PD303'),
  ('ST204', 'Sara', 'Support',  'PD304'),
  ('ST205', 'Mina', 'Instructor',  'PD305')
ON CONFLICT (staff_id) DO NOTHING;

-- Staff contracts (4 ACTIVE roles + 1 PLANNED instructor)
-- This demonstrates status CHECK constraint and partial unique index on ACTIVE
INSERT INTO staff_contract
  (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id)
VALUES
  ('SCT21', 'ST201', 'PROGRAM_MANAGER', 'PERMANENT', '2026-09-01', '2028-08-31', 'ACTIVE', 66000.00, 'UPP'),
  ('SCT22', 'ST202', 'ADMINISTRATOR', 'PERMANENT', '2026-09-01', '2028-08-31', 'ACTIVE', 43000.00, 'UPP'),
  ('SCT23', 'ST203', 'ACCOUNTANT', 'PERMANENT', '2026-09-01', '2028-08-31', 'ACTIVE', 53000.00, 'UPP'),
  ('SCT24', 'ST204', 'SECRETARY', 'PERMANENT', '2026-09-01', '2028-08-31', 'ACTIVE', 39000.00, 'UPP'),
  -- Planned instructor for the next academic year
  ('SCT25', 'ST205', 'INSTRUCTOR', 'PERMANENT', '2026-09-01', '2028-08-31', 'PLANNED', 51000.00, 'UPP')
ON CONFLICT (staff_contract_id) DO NOTHING;

-- Verify Uppsala staff + contracts exist
SELECT s.staff_id, s.first_name, s.last_name, sc.role, sc.status, sc.campus_id
FROM staff s
JOIN staff_contract sc ON s.staff_id = sc.staff_id
WHERE sc.campus_id = 'UPP'
ORDER BY sc.role;

-- ---------------------------------------------------------
-- G) New students enrolling (Uppsala cohort + standalone-only)
-- ---------------------------------------------------------

-- Private details for new students (4 Uppsala + 1 standalone-only)
INSERT INTO private_details (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD401', '200701010401', 'upp_student01@yrkesco.se', 'Uppsala Student Address 1'),
  ('PD402', '200702020402', 'upp_student02@yrkesco.se', 'Uppsala Student Address 2'),
  ('PD403', '200703030403', 'upp_student03@yrkesco.se', 'Uppsala Student Address 3'),
  ('PD404', '200704040404', 'upp_student04@yrkesco.se', 'Uppsala Student Address 4'),
  ('PD405', '200705050405', 'standalone04@yrkesco.se',  'Distance Only')
ON CONFLICT (private_details_id) DO NOTHING;

-- Student rows
INSERT INTO student (student_id, first_name, last_name, private_details_id)
VALUES
  ('SU201', 'Elin',  'Simpons', 'PD401'),
  ('SU202', 'Olle',  'GOT', 'PD402'),
  ('SU203', 'Nora',  'Futurama', 'PD403'),
  ('SU204', 'Ivar',  'Hans', 'PD404'),
  ('SU205', 'Tove',  'Remote',  'PD405')
ON CONFLICT (student_id) DO NOTHING;

-- Enrollments:
-- 4 Uppsala students -> DE2628
-- 1 standalone-only student -> existing distance cohort placeholder (SC2324)
INSERT INTO enrollment (student_id, class_id, enrollment_date, status)
VALUES
  ('SU201', 'DE2628', '2026-09-05', 'ACTIVE'),
  ('SU202', 'DE2628', '2026-09-05', 'ACTIVE'),
  ('SU203', 'DE2628', '2026-09-05', 'ACTIVE'),
  ('SU204', 'DE2628', '2026-09-05', 'ACTIVE'),
  ('SU205', 'SC2324', '2026-01-10', 'ACTIVE')
ON CONFLICT DO NOTHING;

-- Verify enrollments
SELECT e.student_id, s.first_name, s.last_name, e.class_id, c.class_name, e.status
FROM enrollment e
JOIN student s ON e.student_id = s.student_id
JOIN class c ON e.class_id = c.class_id
WHERE e.student_id IN ('SU201','SU202','SU203','SU204','SU205')
ORDER BY e.class_id, e.student_id;

-- ---------------------------------------------------------
-- H) Program Manager assignment for the new class (trigger + unique per class)
-- 1 PM per class enforced by index uq_one_pm_per_class
-- PM role enforced by trigger enforce_pm_role()
-- Max 3 classes per PM enforced by trigger enforce_max_three_classes()
-- ---------------------------------------------------------
INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id)
VALUES ('PMM21', 'SCT21', 'DE2628')
ON CONFLICT (pm_management_id) DO NOTHING;

-- Verify PM assignment
SELECT pmm.staff_contract_id, sc.role, c.class_id, c.class_name, c.academic_year, sc.campus_id
FROM program_manager_management pmm
JOIN staff_contract sc ON pmm.staff_contract_id = sc.staff_contract_id
JOIN class c ON pmm.class_id = c.class_id
WHERE c.class_id = 'DE2628';

-- =========================================================
-- I) BUSINESS RULE DEMO: Program Manager max 3 classes
-- =========================================================

-- Create demo-only classes (no PMs assigned yet)
INSERT INTO class (class_id, program_id, campus_id, class_name, class_code, academic_year)
VALUES
  ('DE2729', 'DE', 'UPP', 'DE Cohort 2027–2029', 'DE-27-29', '2027-2029'),
  ('DE2830', 'DE', 'UPP', 'DE Cohort 2028–2030', 'DE-28-30', '2028-2030'),
  ('DE2931', 'DE', 'UPP', 'DE Cohort 2029–2031', 'DE-29-31', '2029-2031')
ON CONFLICT DO NOTHING;

-- Assign the same PM to three classes (allowed)
INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id)
VALUES
  ('PMM22', 'SCT21', 'DE2729'),
  ('PMM23', 'SCT21', 'DE2830')
ON CONFLICT DO NOTHING;

-- Attempt a 4th assignment (must fail)
SAVEPOINT sp_pm_limit;

INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id)
VALUES ('PMM24', 'SCT21', 'DE2931');

ROLLBACK TO SAVEPOINT sp_pm_limit;

-- Proof query
SELECT
  staff_contract_id,
  COUNT(*) AS classes_managed
FROM program_manager_management
WHERE staff_contract_id = 'SCT21'
GROUP BY staff_contract_id;


-- ---------------------------------------------------------
-- J) Demonstrate PARTIAL UNIQUE INDEX (intentional failure)
-- One ACTIVE staff contract per staff (uq_one_active_staff_contract)
-- ---------------------------------------------------------
SAVEPOINT sp_active_contract;
-- ST201 already has ACTIVE SCT21; this should violate the partial unique index
INSERT INTO staff_contract
  (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id)
VALUES
  ('SCT26', 'ST201', 'PROGRAM_MANAGER', 'PERMANENT', '2026-09-01', '2028-08-31', 'ACTIVE', 67000.00, 'UPP');
ROLLBACK TO SAVEPOINT sp_active_contract;

-- Proof: only one ACTIVE contract for ST201
SELECT staff_id, staff_contract_id, status
FROM staff_contract
WHERE staff_id = 'ST201'
ORDER BY status, staff_contract_id;

-- ---------------------------------------------------------
-- K) Demonstrate relationship traversal (campus -> class -> enrollments -> students)
-- ---------------------------------------------------------
SELECT
  ca.campus_name,
  cl.class_name,
  s.student_id,
  s.first_name,
  s.last_name
FROM campus ca
JOIN class cl ON ca.campus_id = cl.campus_id
JOIN enrollment e ON cl.class_id = e.class_id
JOIN student s ON e.student_id = s.student_id
WHERE ca.campus_id = 'UPP'
ORDER BY cl.class_name, s.last_name, s.first_name;

-- ---------------------------------------------------------
-- L) Standalone course proof (course.program_id IS NULL)
-- ---------------------------------------------------------
SELECT course_id, course_code, course_name, course_credits
FROM course
WHERE program_id IS NULL
ORDER BY course_code;
