/* (Query on the video) Students (name) + Contact Info (personal_identity_number, email)
Who are the students, how can we contact them?
*/
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    pd.personal_identity_number,
    pd.email

FROM student s
JOIN private_details pd ON s.private_details_id = pd.private_details_id
LEFT JOIN enrollment e ON s.student_id = e.student_id
ORDER BY s.first_name, s.last_name;

/* OK
Query 1.a (paste): Stundets + class + program enrolled in
Who are the students and which class and program are they enrolled in?
Result: 3 students enrolled in each course that are ACTIVE
*/
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
LEFT JOIN program p ON c.program_id = p.program_id
WHERE e.status = 'ACTIVE'
ORDER BY
    p.program_name,
    c.class_name,
    s.last_name,
    s.first_name;

/* OK
Query 1.b (paste): Stundets + class + program enrolled in
Who are the students and which class and program are they enrolled in?
Result: 3 students enrolled in each course that have graduated (COMPLETED)
*/
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
LEFT JOIN program p ON c.program_id = p.program_id
WHERE e.status = 'COMPLETED'
ORDER BY
    p.program_name,
    c.class_name,
    s.last_name,
    s.first_name;


/* OK
Query 1.c (paste): Stundets + class + program enrolled in
Who are the students and which class and program are they enrolled in?
Result: 3 students enrolled in each course that have (WITHDRAWN)
*/
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
LEFT JOIN program p ON c.program_id = p.program_id
WHERE e.status = 'WITHDRAWN'
ORDER BY
    p.program_name,
    c.class_name,
    s.last_name,
    s.first_name;


-- Query 1.d: Sanity checks
SELECT COUNT(*) AS student_count FROM student;
SELECT COUNT(*) AS active_enrollment FROM enrollment WHERE status='ACTIVE';
SELECT COUNT(*) AS completed_enrollment FROM enrollment WHERE status='COMPLETED';
SELECT COUNT(*) AS withdrawn_enrollment FROM enrollment WHERE status='WITHDRAWN';

/* OK
Query 2: Consultants (name) + Contact Info (email)
Who are the consultants, how can we contact them?
*/
SELECT 
    c.consultant_id,
    c.first_name,
    c.last_name,
    pd.email

FROM consultant c
JOIN private_details pd ON c.private_details_id = pd.private_details_id
ORDER BY
    c.last_name,
    c.first_name;

/* OK
Query 3: Staffs (name) + from Private Details Table = Contact Info (personal_identity_number, email)
Who are the staffs, their personal identity number, how can we contact them?
*/
SELECT
    s.first_name,
    s.last_name,
    pd.personal_identity_number,
    pd.email
FROM staff s
JOIN private_details pd ON s.private_details_id = pd.private_details_id
ORDER BY
    s.first_name,
    s.last_name;


/* OK
Query 4: Staff by Campus and Role
Who works at each campus and in what role?
*/
SELECT
    s.first_name,
    s.last_name,
    sc.role,
    ca.campus_name,
    sc.role,
    sc.status,
    sc.contract_type

FROM staff s
JOIN staff_contract sc ON s.staff_id = sc.staff_id
JOIN campus ca ON sc.campus_id = ca.campus_id
WHERE sc.status IN ('ACTIVE', 'PAUSED')
ORDER BY
    ca.campus_name,
    sc.role,
    s.first_name,
    s.last_name;

/* OK
Query 5: Planned employment of permanent instructors (BONUS)
Staffs (INSTRUCTORS) and their contract information, roles, campus, date,
*/
SELECT
    s.first_name,
    s.last_name,
    sc.role,
    sc.contract_type,
    sc.start_date,
    sc.end_date,
    sc.status,
    ca.campus_id,
    ca.city

FROM staff s
JOIN staff_contract sc ON s.staff_id = sc.staff_id
JOIN campus ca ON sc.campus_id = ca.campus_id
WHERE sc.contract_type = 'PAUSED'
AND sc.role = 'INSTRUCTOR'
AND sc.status = 'PAUSED'
ORDER BY
    ca.campus_name,
    sc.start_date,
    s.last_name;



/* OK
Query 6: Consultants (first_name, last_name) + Course (course_name) + Program (program_name) + Campus (campus_name) + city
Which courses and programs do consultants teach and which campus?
*/
SELECT
    c.consultant_id,
    c.first_name,
    c.last_name,
    c.consultant_company_id,
    crs.course_name,
    p.program_name,
    ca.campus_name,
    ca.city
FROM consultant_teach ct
JOIN consultant c ON ct.consultant_id = c.consultant_id
JOIN course crs ON ct.course_id = crs.course_id
LEFT JOIN program p ON crs.program_id = p.program_id  -- LEFT JOIN because standalone course has NULL program_id
JOIN consultant_contract cc ON c.consultant_id = cc.consultant_id
JOIN campus ca ON cc.campus_id = ca.campus_id
WHERE cc.status = 'ACTIVE'
ORDER BY
    c.consultant_id,
    c.first_name,
    c.last_name,
    p.program_name,
    crs.course_name;


/* OK
IMPORTANT BONUS: Query 7: Program Managers: 
Who are the staffs that are program Managers in all campus and which classes are they in charge of? (Asnwer 3 classes per PM)
*/
SELECT
  s.first_name,
  s.last_name,
  sc.staff_contract_id,
  sc.role,
  p.program_name,
  c.class_name,
  c.academic_year
FROM program_manager_management pmm
JOIN staff_contract sc
  ON pmm.staff_contract_id = sc.staff_contract_id
JOIN staff s
  ON sc.staff_id = s.staff_id
JOIN class c
  ON pmm.class_id = c.class_id
JOIN program p
  ON c.program_id = p.program_id
ORDER BY
  s.last_name,
  s.first_name,
  c.academic_year;

/* ========================================================= 
VIOLATE PROGRAM MANAGER RULE:
I want to try violate my constraints for the rule 1 Program Manager can manage 3 max classes. 
I wanna see fif my constraint works.
========================================================= */

-- Before violating anything, confirm how many classes a Program Manager already manages.
-- Use this for the integrity check later after violating rule
SELECT
  staff_contract_id,
  COUNT(*) AS classes_managed
FROM program_manager_management
GROUP BY staff_contract_id;

-- Attempt the invalid insert
INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id)
VALUES ('PMM99', 'SCT01', 'UX2325');


/* OK
Query 8: Courses per Program (Curriculum View)
What courses belong to each program?
*/
SELECT
    p.program_name,
    co.course_name,
    co.course_code,
    co.course_credits,
    co.course_description
    
FROM program p
JOIN course co ON p.program_id = co.program_id
ORDER BY
    p.program_name,
    co.course_code;


/* OK
Query 9: Classes per Program (Class View)
What classes belong to each program?
*/
SELECT
    p.program_id,
    p.program_name,
    cl.class_name,
    cl.class_code,
    cl.academic_year,
    ca.campus_name

FROM program p
JOIN class cl ON p.program_id = cl.program_id
JOIN campus ca ON cl.campus_id = ca.campus_id
ORDER BY
    p.program_name,
    cl.academic_year,
    ca.campus_name;


/* OK 
Program stand alone problem
Query 10a: Standalone Courses
Which courses are not tied to any program?
*/
SELECT
    c.course_id,
    c.course_code,
    c.course_name,
    c.course_credits
FROM course c
WHERE c.program_id IS NULL
ORDER BY
    c.course_code;

/* Query 10b standalone + students*/
SELECT
    cl.class_id,
    cl.class_name,
    cl.class_code,
    s.student_id,
    s.first_name,
    s.last_name
FROM class cl
JOIN enrollment e
    ON cl.class_id = e.class_id
JOIN student s
    ON e.student_id = s.student_id
WHERE cl.program_id IS NULL
  AND e.status = 'ACTIVE'
ORDER BY
    cl.class_code,
    s.last_name,
    s.first_name;


/* OK
Query 11: Course (belongs to a program) Credits Validation. Each Program has 400 credits. Standalone is 100.*/
SELECT
    program_id,
    SUM(course_credits) AS total_credits
FROM course
WHERE program_id IS NOT NULL
GROUP BY program_id
ORDER BY program_id;


