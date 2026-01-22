22 Students 

10 Staff (5 Stockholm + 5 Göteborg)
1 PM per Campus
3 classes per PM

4 Consultants (2 Stockholm + 2 Göteborg)

------------------------------------------------------------------------------------------------

Task: Query 2:  STUDENTS AND CLASS AND PROGRAM Query:
For SU101, SU102 and SU103 
- Should not be included in program (standalone course)
 SU103      | Mira       | Remote    | Standalone Distance Cohort | Data Engineering
 SU101      | Sana       | Remote    | Standalone Distance Cohort | Data Engineering
 SU102      | Viktor     | Remote    | Standalone Distance Cohort | Data Engineering


- Fix: This old query will fail `Student → Enrollment → Class → Program` because:
    - queries are deriving program_name via Class → Program, but standalone classes must not be program-backed
Solution is: Program comes from Course.program_id, not from Class.program_id.

- Standalone courses have course.program_id IS NULL
- Therefore program_name becomes NULL
- Students SU101, SU102, SU103 now correctly show no program

------------------------------------------------------------------------------------------------


Task: OK

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


-----------+-------------+--------------------------------------+----------------

Task: OK
Query 11: Standalone should not have a Data Engineering program

 program_id |   program_name   |         class_name         | class_code | academic_year |    campus_name
------------+------------------+----------------------------+------------+---------------+-------------------
 DE         | Data Engineering | Standalone Distance Cohort | SC-23-24   | 2023-2024     | Stockholm Campus
 DE         | Data Engineering | DE Cohort 2023-2025        | DE-23-25   | 2023-2025     | Stockholm Campus
 DE         | Data Engineering | DE Cohort 2024-2026        | DE-24-26   | 2024-2026     | Gothenburg Campus
 DE         | Data Engineering | DE Cohort 2025-2027        | DE-25-27   | 2025-2027     | Stockholm Campus
 UX         | UX Design        | UX Cohort 2023-2025        | UX-23-25   | 2023-2025     | Gothenburg Campus
 UX         | UX Design        | UX Cohort 2024-2026        | UX-24-26   | 2024-2026     | Stockholm Campus
 UX         | UX Design        | UX Cohort 2025-2027        | UX-25-27   | 2025-2027     | Gothenburg Campus
(7 rows)

------------+------------------+----------------------------+------------+---------------+-------------------

IMPORTANT TASK: TEST THAT MY CONSTRAINTS ARE VALID AND TRIGGERS INVALID INPUTS

-----------+-------------+--------------------------------------+----------------

Task: Try testing my constraint on PM by adding one more class to a PM.
Constraint should be triggered.
