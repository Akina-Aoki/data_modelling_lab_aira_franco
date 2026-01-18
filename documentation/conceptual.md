# Conceptual Model
## Goal: 
- Map out the big picture for the business stakeholders. Focus on the "things" (Entities) and how they relate (Relationships).

![Conceptual Model](../assets/Conceptual.png)

## Entity Descriptions

| Entity                         | Description                                                                                                                                                                                              |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1. **Student**                    | A person enrolled at the school. A student belongs to exactly one class. Students do not enroll directly in programs or courses; enrollment is always mediated through a class.       |
| 2. **Class**                      | An approved, time-bound delivery of an education program (e.g. DE24, DE25). A class represents a specific approval round of a program, is assigned to one campus, and groups students studying together. |
| 3. **Program**                    | A two-year education offering consisting of multiple predefined courses. A program defines the curriculum and may be approved multiple times over different years, resulting in multiple classes.        |
| 4. **Course**                     | A unit of education with defined content, credits, and learning objectives. A course may belong to one program or exist independently as a standalone course. Courses are not directly owned by classes. |
| 5. **Campus**                     | A physical school location where classes are delivered. Each class is associated with exactly one campus.                                                                                                |
| 6. **Staff**                      | Internal employees of the school, such as program managers or administrative personnel. Each staff member operates under exactly one active staff contract at a time.                                    |
| 7. **Staff Contract**             | A time-bound employment agreement defining a staff member’s role, campus assignment, compensation, and employment period. Only one staff contract may be active per staff member at any time.            |
| 8. **Consultant**                 | External professionals engaged by the school to teach or support classes. Consultants operate under consultant contracts and may be associated with a consultant company.                                |
| 9. **Consultant Contract**        | A time-bound agreement defining a consultant’s assignment, compensation, campus affiliation, and contract period. Only one active contract may exist per consultant at a time.                           |
| 10. **Consultant Company**         | An external organization that employs or represents one or more consultants providing services to the school.                                                                                            |
| 11. **Private Details**            | A secured entity containing sensitive personal or company information, such as personal identity numbers and contact details. Access is restricted for privacy and compliance reasons.                   |
| 12. **Project Manager Management** | An assignment entity representing the responsibility of a staff member acting as program manager for education classes. It enforces managerial constraints between staff and classes.                    |
| 13. **Consulant Teach** | Represents the actual delivery of teaching: a consultant teaching a specific course to a specific class during a defined period. |
| 14. **Enrollment** | Represents a student’s registration in a specific class for a given academic term. Enrollment enforces business rules ensuring that a student is enrolled in either one program class or one standalone course per term, but not both. |



## Relationship Descriptions

| Entity A                       | Entity B                       | Cardinality   | Description                                                                                                                              |
| ------------------------------ | ------------------------------ | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Staff**                      | **Staff Contract**             | 1 : 1         | Each staff member has exactly one active staff contract, and each staff contract belongs to exactly one staff member.                    |
| **Staff Contract**         | **Campus**                       | N : 1           | Each staff contract is associated with exactly one campus, while a campus may have many staff contracts. |
| **Consultant**                 | **Consultant Contract**        | 1 : 1         | Each consultant operates under exactly one active consultant contract, and each contract belongs to one consultant.                      |
| **Consultant**                 | **Consultant Company**         | N : 1         | Each consultant is associated with one consultant company. A consultant company may represent many consultants.                          |
| **Staff**                      | **Private Details**            | 1 : 1         | Each staff member has exactly one private details record storing sensitive information.                                                  |
| **Consultant**                 | **Private Details**            | 1 : 1         | Each consultant has exactly one private details record storing sensitive information.                                                    |
| **Consultant Contract**    | **Campus**                       | N : 1           | Each consultant contract is bound to exactly one campus, while a campus may be associated with many consultant contracts. |
| **Campus**                     | **Class**                      | 1 : N         | A campus may host many classes. Each class is delivered at exactly one campus.                                                           |
| **Program**                    | **Class**                      | 1 : N         | A program may be approved multiple times, resulting in multiple classes over different years. Each class belongs to exactly one program. |
| **Class**                  | **Enrollment**                  | 1 : N           | A class may have many enrollments, while each enrollment links to exactly one class. |
| **Program**                    | **Course**                     | 1 : N         | A program consists of one or more courses that define its curriculum.                                                                    |
| **Course**                     | **Program**                    | 0 : 1         | A course may belong to one program or exist independently as a standalone course.                                                        |
| **Student**                    | **Class**                      | N : 1         | Each student belongs to exactly one class per term. A class may contain many students.                                                   |
| **Consultant**                 | **Course**                      | 0..N : 0..N   | A consultant may teach multiple courses, and a course may be taught by zero or more consultants.                                          |
| **Staff**                      | **Project Manager Management** | 1 : N         | A staff member may be assigned as program manager for multiple classes through management assignments.                                   |
| **Project Manager Management** | **Class**                      | 1 : N (max 3) | Each program manager manages up to three classes. Each class is managed by exactly one program manager.                                  |
| **Consultant**             | **Consultant Teach**             | 1 : N           | A consultant may teach multiple courses through Consultant Teach. |
| **Course**                 | **Consultant Teach**             | 1 : N           | A course may be taught by multiple consultants through Consultant Teach across different terms. Each Consultant Teach record references exactly one Course. |
| **Consultant Teach**        | **Consultant**       | 1 : N           | A course may be taught by 1 consultant through Consultant Teach. |
| **Student** | **Enrollment** | 1 : N | A student may have multiple enrollments over time, but at most one enrollment per academic term, while each enrollment belongs to exactly one student. |

