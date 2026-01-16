# Conceptual Model
## Goal: 
- Map out the big picture for the business stakeholders. Focus on the "things" (Entities) and how they relate (Relationships).

![Conceptual Model](../assets/Conceptual.png)

## Entity Descriptions
| Entity                  | Description |
|-------------------------|-------------|
| **Student**             | A person studying at the school. A student enrolls in classes (2024, 2025, ...), then to Program of choice (Data Engineer,...) through enrollment process. Business rules control whether a student enrolls in a program class or standalone course classes within a given term. |
| **Class**               | An approved, time-bound delivery of a program or standalone course (e.g. 2024, 2025, 2026). A class represents a specific approval round. |
| **Program**             | A two-year education consisting of multiple courses. Each program is approved in three rounds, resulting in exactly three classes delivered over different years. A student may be enrolled in only one program per term. |
| **Course**              | A course that may either be part of a program or offered as a standalone course. Courses are delivered through education classes. Students enroll in standalone courses by enrolling in the corresponding class. A student may enroll in a maximum of two standalone course classes per term (business rule).|
| **Campus**              | A physical school location where programs and courses are delivered and where staff and consultants are assigned. The model supports future campus expansion. |
| **Staff**               | Internal employees of the school, such as program managers or administrative staff. Each staff member has exactly one active staff contract at a time. |
| **Consultant**          | External professionals hired to teach or support education classes. Consultants operate under time-limited contracts and may represent an external consultant company. |
| **Consultant Company**  | An external company that employs or represents one or more consultants providing services to the school. |
| **Staff Contract**      | A time-bound agreement defining a staff member’s role, campus assignment, salary, and employment period. Only one staff contract may be active per person at any time. |
| **Consultant Contract** | A time-bound agreement defining a consultant’s assignment, campus, compensation, and contract period. Only one consultant contract may be active per person at any time. |
| **Enrollment**          | Represents a student’s enrollment in an education class. Each enrollment links exactly one student to exactly one class. |
| **Private Details**     | Stores sensitive personal or company information, such as personal identity numbers and contact details. This data is isolated for security, privacy, and access control purposes. |
| **Program Manager**     | A staff role responsible for managing education classes. Each program manager manages exactly three classes, and each class has exactly one program manager. |




## Relationship Descriptions

| Entity A                   | Entity B                   | Cardinality           | Description                                                                                         |
| -------------------------- | -------------------------- | --------------------- | --------------------------------------------------------------------------------------------------- |
| Staff                      | Staff Contract             | 1 : 1                 | Each staff member has exactly one active staff contract. Each contract belongs to one staff member. |
| Consultant                 | Consultant Contract        | 1 : 1                 | Each consultant has exactly one consultant contract. Each contract belongs to one consultant.       |
| Consultant                 | Consultant Company         | N : 1                 | Each consultant works for one consultant company. A company can have many consultants.              |
| Staff                      | Private Details            | 1 : 1                 | Each staff member has exactly one private details record.                                           |
| Consultant                 | Private Details            | 1 : 1                 | Each consultant has exactly one private details record.                                             |
| Campus                     | Class                      | 1 : N                 | A campus offers many classes. Each class is offered at exactly one campus.                          |
| Program                    | Class                      | 1 : N                 | A program consists of many classes. Each class belongs to exactly one program.                      |
| Course                     | Class                      | 1 : N                 | A course can be delivered through multiple classes. Each class delivers exactly one course.         |
| Student                    | Enrollment                 | 1 : N                 | A student can have many enrollments. Each enrollment belongs to exactly one student.                |
| Class                      | Enrollment                 | 1 : N                 | A class can have many enrollments. Each enrollment refers to exactly one class.                     |
| Consultant                 | Class                      | 1 : N (0..1 on Class) | A consultant may teach multiple classes. A class may have zero or one consultant.                   |
| Project Manager Management | Class                      | 1 : N (max 3)         | A program manager manages up to three classes. Each class has exactly one program manager.          |
| Staff                      | Project Manager Management | 1 : N                 | A staff member may act as program manager for multiple classes through management assignments.      |

