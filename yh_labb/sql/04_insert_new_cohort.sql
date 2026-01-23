/* =========================================================
    Demonstrate DB integrity in a Scenario: Additional DE class for 2026-2028.
   Add that class to the data engineering program in Stockholm Campus, add 2 students there who are ACTIVE, 
   add an additional INSTRUCTOR to teach this class, not a consultant, 
   and an additional PM for that class since the 2 available PM already has 3 classes,
   etc. USE INSERTS. Just a very simple demo that my db works.

   ========================================================= */

-- A) Baseline sanity checks (shows existing DB is populated)
SELECT COUNT(*) AS total_campuses FROM campus;
SELECT COUNT(*) AS total_programs FROM program;
SELECT COUNT(*) AS total_students FROM student;
SELECT COUNT(*) AS total_staff_contracts FROM staff_contract;
SELECT COUNT(*) AS pm_assignments FROM program_manager_management;

-- Add a new DE class (2026–2028)
INSERT INTO class
  (class_id, program_id, campus_id, class_name, class_code, academic_year)
VALUES
  ('DE2628','DE','STH','DE Cohort 2026–2028','DE-26-28','2026-2028');

-- Add private details for 2 new students
INSERT INTO private_details
  (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD301','200701010301','student13@yrkesco.se','Studentvagen 7, Stockholm'),
  ('PD302','200702020302','student14@yrkesco.se','Studentvagen 8, Stockholm');


-- Add the students 
INSERT INTO student
  (student_id, first_name, last_name, private_details_id)
VALUES
  ('SU201','Liam','Andersson','PD301'),
  ('SU202','Emma','Karlsson','PD302');


-- ENROLL the new students in the new class
INSERT INTO enrollment
  (student_id, class_id, status)
VALUES
  ('SU201','DE2628','ACTIVE'),
  ('SU202','DE2628','ACTIVE');


-- Add new Internal instructor
-- private details
INSERT INTO private_details
  (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD401','198901010401','instructor.new@yrkesco.se','Odengatan 20, Stockholm');

-- INSERT INTO staff record
INSERT INTO staff
  (staff_id, first_name, last_name, private_details_id)
VALUES
  ('ST011','Anna','Larsson','PD401');


-- Staff contract
INSERT INTO staff_contract
  (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id)
VALUES
  ('SCT11','ST011','INSTRUCTOR','PERMANENT','2026-09-01','2030-08-31','ACTIVE',52000,'STH');


-- Add new PM since PM are full of 3 classes
INSERT INTO private_details
  (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD402','198505050402','pm.new@yrkesco.se','Sveavagen 20, Stockholm');

-- Staff PM info
INSERT INTO staff
  (staff_id, first_name, last_name, private_details_id)
VALUES
  ('ST012','Marcus','Holm','PD402');


-- PM contract
INSERT INTO staff_contract
  (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id)
VALUES
  ('SCT12','ST012','PROGRAM_MANAGER','PERMANENT','2026-09-01','2030-08-31','ACTIVE',68000,'STH');


-- Assign the new PM to the new class
INSERT INTO program_manager_management
  (pm_management_id, staff_contract_id, class_id)
VALUES
  ('PMM07','SCT12','DE2628');


SELECT
  c.class_id,
  p.program_name,
  pmm.pm_management_id,
  e.student_id,
  e.status
FROM class c
LEFT JOIN program p ON c.program_id = p.program_id
LEFT JOIN program_manager_management pmm ON c.class_id = pmm.class_id
LEFT JOIN enrollment e ON c.class_id = e.class_id
WHERE c.class_id = 'DE2628';


-- Students enrolled in the new DE 2026–2028 class (primary ask)
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.class_name,
    c.academic_year,
    p.program_name,
    e.status
FROM enrollment e
JOIN student s ON e.student_id = s.student_id
JOIN class c ON e.class_id = c.class_id
JOIN program p ON c.program_id = p.program_id
WHERE c.class_id = 'DE2628'
  AND e.status = 'ACTIVE'
ORDER BY s.last_name, s.first_name;


-- Full integrity Snapshot of the New Cohort
SELECT
    p.program_name,
    c.class_name,
    c.academic_year,
    pm.first_name AS pm_first_name,
    pm.last_name  AS pm_last_name,
    st.first_name AS student_first_name,
    st.last_name  AS student_last_name
FROM class c
JOIN program p ON c.program_id = p.program_id
JOIN program_manager_management pmm ON c.class_id = pmm.class_id
JOIN staff_contract sc ON pmm.staff_contract_id = sc.staff_contract_id
JOIN staff pm ON sc.staff_id = pm.staff_id
JOIN enrollment e ON c.class_id = e.class_id
JOIN student st ON e.student_id = st.student_id
WHERE c.class_id = 'DE2628'
  AND e.status = 'ACTIVE'
ORDER BY st.last_name;
