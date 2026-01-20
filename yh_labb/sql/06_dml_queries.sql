/* 
    *Query 1: Students (name) + Contact Info (personal_identity_number, email) + Class + Program
    Who are the students, how can we contact them, and which class and program are they enrolled in?
    */

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    pd.personal_identity_number,
    pd.email,
    c.class_id,
    c.class_name,
    p.program_id,
    p.program_name

FROM student s
JOIN private_details pd ON s.private_details_id = pd.private_details_id
JOIN enrollment e ON s.student_id = e.student_id
JOIN class c ON e.class_id = c.class_id
JOIN program p ON c.program_id = p.program_id
ORDER BY c.class_name, p.program_name, s.first_name, s.last_name

      /* 
    Query : Consultants and their contract information 
    + consultant company (organization number, F-tax status, address, and hourly rate)
    */


   /* =========================================================
    Query : Program Managers and their personal information
    Private Details Table is sensitive information and access must be controlled.
   ========================================================= */

      /* =========================================================
    Query : Staffs and their contract information
   ========================================================= */

   

   /* =========================================================
    Query : Program Managers per Class
    Who is responsible for each class?
   ========================================================= */


   /* =========================================================
    Query : Staff by Campus and Role
    Who works at each campus and in what role?
   ========================================================= */


   /* =========================================================
    Query : Consultants, Companies, and Courses Taught
    Which consultants teach which courses, and which company do they belong to?
   ========================================================= */


   /* =========================================================
    Query : Courses per Program (Curriculum View)
    What courses belong to each program?
   ========================================================= */

   /* =========================================================
    Query : Standalone Courses
    Which courses are not tied to any program?
   ========================================================= */

