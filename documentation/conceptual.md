# Conceptual Model
## Goal: 
- Map out the big picture for the business stakeholders. Focus on the "things" (Entities) and how they relate (Relationships).

![Conceptual Model](../assets/Conceptual.png)

## Entity Descriptions

| Entity                 | Description                                                                                                                                                                                                           |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Student**            | A person studying at the school. A student enrolls in education classes through enrollment records. Business rules control whether a student enrolls in a program class or standalone course classes in a given term. |
| **Education Class**    | A concrete, approved delivery of a program or course for a specific year and campus (for example, DE 24 or AI 25). Teaching, management, and student enrollment happen at this level.                                 |
| **Program**            | A two-year education consisting of multiple courses, including a mandatory internship (LIA). Each program can be approved multiple times, resulting in multiple education classes over different years.               |
| **Course**             | A standalone course with defined credits, duration, and content. Courses are not part of programs and do not include LIA. Each course can be delivered through multiple education classes over time.                  |
| **Campus**             | A physical school location where education classes are held and where staff and consultants are assigned. The model supports future campus expansion.                                                                 |
| **Staff**              | Internal employees of the school, such as program managers or administrative staff. Each staff member has exactly one active contract at a time.                                                                      |
| **Staff Role**         | Defines the role a staff member holds during a contract period. In this model, Program Manager is explicitly modeled, with the ability to add more roles later.                                                       |
| **Consultant**         | External professionals hired to teach or support education classes. Consultants work under time-limited contracts and may represent an external company.                                                              |
| **Contract**           | A time-bound agreement for staff or consultants that defines role, campus assignment, and employment period. Only one contract may be active per person at any time.                                                  |
| **Consultant Teaches** | A bridge entity that represents teaching assignments between consultants and education classes, resolving a many-to-many relationship.                                                                                |
| **Enrollment**         | Represents a student’s enrollment in an education class. Each enrollment links exactly one student to exactly one education class.                                                                                    |
| **Private Details**    | Stores sensitive personal or company information, such as personal identity numbers, contact details, and consultant company data. This data is isolated for security and access control purposes.                    |


## Relationship Descriptions

| Entity A                    | Entity B                    | Cardinality    | Relationship Statement                                                                                |
| --------------------------- | --------------------------- | -------------- | ----------------------------------------------------------------------------------------------------- |
| **Program**                 | **Education Class**         | 1 → many       | One program can be approved and delivered through multiple education classes over different years.    |
| **Course**                  | **Education Class**         | 1 → many       | One course can be delivered through multiple education classes over time.                             |
| **Campus**                  | **Education Class**         | 1 → many       | One campus hosts multiple education classes.                                                          |
| **Staff**                   | **Contract**                | 1 → 1 (active) | Each staff member has exactly one active contract at a time.                                          |
| **Consultant**              | **Contract**                | 1 → 1 (active) | Each consultant has exactly one active contract at a time.                                            |
| **Staff Role**              | **Contract**                | 1 → many       | A staff role can be assigned to many contracts over time, but each contract defines exactly one role. |
| **Education Class**         | **Staff (Program Manager)** | many → 1       | Each education class is managed by exactly one staff member acting as Program Manager.                |
| **Staff (Program Manager)** | **Education Class**         | 1 → many       | One program manager is responsible for multiple education classes, with a minimum of three.           |
| **Consultant**              | **Consultant Teaches**      | 1 → many       | One consultant can have multiple teaching assignments.                                                |
| **Education Class**         | **Consultant Teaches**      | 1 → many       | One education class can have multiple consultant teaching assignments.                                |
| **Consultant Teaches**      | **Consultant**              | many → 1       | Each teaching assignment belongs to exactly one consultant.                                           |
| **Consultant Teaches**      | **Education Class**         | many → 1       | Each teaching assignment belongs to exactly one education class.                                      |
| **Education Class**         | **Enrollment**              | 1 → many       | One education class can have many student enrollments.                                                |
| **Enrollment**              | **Education Class**         | many → 1       | Each enrollment belongs to exactly one education class.                                               |
| **Student**                 | **Enrollment**              | 1 → many       | One student can have multiple enrollments over time.                                                  |
| **Enrollment**              | **Student**                 | many → 1       | Each enrollment belongs to exactly one student.                                                       |
| **Student**                 | **Private Details**         | 1 → 1          | Each student has exactly one set of private personal information.                                     |
| **Staff**                   | **Private Details**         | 1 → 1          | Each staff member has exactly one set of private personal information.                                |
| **Consultant**              | **Private Details**         | 1 → 1          | Each consultant has exactly one set of private personal or company-related information.               |
| **Staff**                      | **Program Manager Assignment** | 1 → many    | One staff member can have multiple program manager assignments over time. |
| **Education Class**            | **Program Manager Assignment** | 1 → many     | Each education class have exactly one program manager assignment.    |
| **Program Manager Assignment** | **Staff**                      | many → 1    | Each assignment belongs to exactly one staff member.                      |
| **Program Manager Assignment** | **Education Class**            | 1 → 1       | Each Project Manager assignment links to many (max 3) education class.         |
