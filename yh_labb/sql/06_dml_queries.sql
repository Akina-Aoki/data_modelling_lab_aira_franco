/* OK (Query on the video presentation)
Query 1: Students (name) + Contact Info (personal_identity_number, email)
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
JOIN enrollment e ON s.student_id = e.student_id
ORDER BY s.first_name, s.last_name;


/* !!!! Standlone fix
Query 2: Stundets + class + program enrolled in
Who are the students and which class and program are they enrolled in?
*/
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.class_name,
    program_name
FROM enrollment e
JOIN student s ON e.student_id = s.student_id
JOIN class c ON e.class_id = c.class_id
JOIN program p ON c.program_id = p.program_id
WHERE e.status = 'ACTIVE'
ORDER BY
    p.program_name,
    c.class_name,
    s.last_name,
    s.first_name;

/* OK
Query 3: Consultants (name) + Contact Info (email)
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


/* (Query on the video)
Query 4: Consultants + consultant company details (organization number, F-tax status, address, and hourly rate) + Contract Type
What are the company details of the consultans and their contract types?
*/
/* Query 4: Consultants + company + contract details */
SELECT
    c.first_name,
    c.last_name,
    cc.company_name,
    cc.organization_number,
    cc.f_tax_status,
    cc.address,
    con.role,
    con.contract_type,
    con.hourly_rate,
    con.campus_id
FROM consultant c
JOIN consultant_company cc
  ON c.consultant_company_id = cc.consultant_company_id
JOIN consultant_contract con
  ON c.consultant_id = con.consultant_id
WHERE con.status = 'ACTIVE'
ORDER BY
    c.first_name,
    c.last_name,
    cc.company_name;

/* OK
Query 5: Consultants (first_name, last_name) + Course (course_name) + Program (program_name) + Campus (campus_name)
Which courses and programs do consultants teach and which campus?
*/
SELECT
    c.first_name,
    c.last_name,
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
    c.first_name,
    c.last_name,
    p.program_name,
    crs.course_name;


/* OK
Query 6: Staffs (name) + Contact Info (personal_identity_number, email)
Who are the staffs, how can we contact them?
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
Query 7: Planned employment of permanent instructors (BONUS)
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
WHERE sc.contract_type = 'PERMANENT'
AND sc.role = 'INSTRUCTOR'
AND sc.status = 'ACTIVE'
ORDER BY
    ca.campus_name,
    sc.start_date,
    s.last_name;


/* OK
Query 8: Staff by Campus and Role
Who works at each campus and in what role?
*/
SELECT
    s.first_name,
    s.last_name,
    sc.role,
    ca.campus_name

FROM staff s
JOIN staff_contract sc ON s.staff_id = sc.staff_id
JOIN campus ca ON sc.campus_id = ca.campus_id
WHERE sc.status = 'ACTIVE'
ORDER BY
    ca.campus_name,
    sc.role,
    s.first_name,
    s.last_name;


/* OK
IMPORTANT: Query 9: Program Managers and their personal information
Who are the staffs that are program Managers in all campus and which classes are they in charge of? (Asnwer 3 classes per PM)
*/
SELECT
    s.first_name,
    s.last_name,
    sc.role,
    ca.campus_name,
    cl.class_name,
    cl.program_id,
    cl.academic_year

FROM program_manager_management pmm
JOIN staff_contract sc ON pmm.staff_contract_id = sc.staff_contract_id
JOIN staff s ON sc.staff_id = s.staff_id
JOIN campus ca ON sc.campus_id = ca.campus_id 
JOIN class cl ON pmm.class_id = cl.class_id
WHERE sc.role = 'PROGRAM_MANAGER'
    AND sc.status = 'ACTIVE'
    AND sc.staff_contract_id IN (
        SELECT staff_contract_id
        FROM program_manager_management
        GROUP BY staff_contract_id
        HAVING  COUNT(class_id) = 3
    )
ORDER BY
    ca.campus_name,
    s.first_name,
    s.last_name,
    cl.academic_year;


/* OK
Query 10: Courses per Program (Curriculum View)
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
Query 11: Classes per Program (Class View)
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
Query 12: Standalone Courses
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


/* OK
Query 13: Course Credits Validation. Each Program has 400 credits. Standalone is 100.*/
SELECT
    program_id,
    SUM(course_credits) AS total_credits
FROM course
WHERE program_id IS NOT NULL
GROUP BY program_id
ORDER BY program_id;
