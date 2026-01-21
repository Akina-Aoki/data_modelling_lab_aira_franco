22 Students 

10 Staff (5 Stockholm + 5 Göteborg)
1 PM per Campus
3 classes per PM

4 Consultants (2 Stockholm + 2 Göteborg)

Task: In the implementation later, try that my script will raise an error if I add another class

------------------------------------------------------------------------------------------------

Task: Query 2:  STUDENTS AND CLASS AND PROGRAM Query:
For SU101, SU102 and SU103 
- Should not be included in program (standalone course)
 SU103      | Mira       | Remote    | Standalone Distance Cohort | Data Engineering
 SU101      | Sana       | Remote    | Standalone Distance Cohort | Data Engineering
 SU102      | Viktor     | Remote    | Standalone Distance Cohort | Data Engineering


student_id | first_name | last_name |         class_name         |   program_name   
------------+------------+-----------+----------------------------+------------------
 SU001      | Amina      | Berg      | DE Cohort 2023-2025        | Data Engineering
 SU002      | Noah       | Lind      | DE Cohort 2023-2025        | Data Engineering
 SU004      | William    | Nystrom   | DE Cohort 2024-2026        | Data Engineering
 SU003      | Ella       | Svens     | DE Cohort 2024-2026        | Data Engineering
 SU005      | Olivia     | Dahl      | DE Cohort 2025-2027        | Data Engineering
 SU006      | Lucas      | Ek        | DE Cohort 2025-2027        | Data Engineering
 SU103      | Mira       | Remote    | Standalone Distance Cohort | Data Engineering
 SU101      | Sana       | Remote    | Standalone Distance Cohort | Data Engineering
 SU102      | Viktor     | Remote    | Standalone Distance Cohort | Data Engineering
 SU008      | Hugo       | Fors      | UX Cohort 2023-2025        | UX Design
 SU007      | Hanna      | Holm      | UX Cohort 2023-2025        | UX Design
 SU010      | Adam       | Sund      | UX Cohort 2024-2026        | UX Design
 SU009      | Freja      | Wall      | UX Cohort 2024-2026        | UX Design
 SU011      | Stella     | Borg      | UX Cohort 2025-2027        | UX Design
 SU012      | Leo        | Kvist     | UX Cohort 2025-2027        | UX Design
(15 rows)

------------------------------------------------------------------------------------------------

Task: Where did Query 1 go?
/* 
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

------------------------------------------------------------------------------------------------

Task: DONE
psql:/sql/06_dml_queries.sql:78: ERROR:  column cc.consultant_company does not exist
LINE 8:     cc.consultant_company,

-------------------------------------------------------------------------------------------------

Task DONE: 
psql:/sql/06_dml_queries.sql:236: ERROR:  column p.program does not exist
LINE 6:     p.program,

Task: Check

When I check which course is not tied to any program, it is correct 
 course_id | course_code |             course_name              | course_credits
-----------+-------------+--------------------------------------+----------------
 SC100     | SC-100      | Standalone: Data Literacy (Distance) |            100
(1 row)

AND

In Query number 5: Standalone shows correctly
 Karin      | Data      | SQL & Relational Modeling            | Data Engineering | Stockholm Campus  | Stockholm
 Karin      | Data      | Standalone: Data Literacy (Distance) |                  | Stockholm Campus  | Stockholm
 Mikael     | Pipes     | Cloud & DevOps for Data              | Data Engineering | Stockholm Campus  | Stockholm
 Mikael     | Pipes     | Data Pipelines & Orchestration       | Data Engineering | Stockholm Campus  | Stockholm

