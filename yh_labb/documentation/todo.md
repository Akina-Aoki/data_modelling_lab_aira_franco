22 Students 

10 Staff (5 Stockholm + 5 Göteborg)
1 PM per Campus
3 classes per PM

4 Consultants (2 Stockholm + 2 Göteborg)

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

IMPORTANT TASK: TEST THAT MY CONSTRAINTS ARE VALID AND TRIGGERS INVALID INPUTS
- 1 Program Manager = 3 Classes MAX. Constraint violated. Verified after. GOOD!
-----------+-------------+--------------------------------------+----------------

Task: DEMO Uppsala Campus
Check if I can add new Campus and related tables and check all constraints are triggered.
-----------+-------------+--------------------------------------+----------------
