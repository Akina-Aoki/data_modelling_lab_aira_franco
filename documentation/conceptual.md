# Conceptual Model
## Goal: 
- Map out the big picture. Focus on the "things" (Entities) and how they relate (Relationships).

## Extra Business Clarifications
### 1. Contract of staffs:
- A staff member has exactly **one role at a time,** defined by their **active contract.**
- A staff member has only one role (1 role = 1 contract)
- Consultants and staffs are assigned **strictly to one campus per contract.**
- A role for staffs and consultants cannot change unless the **contract is ended and a new one is created.**
- Each education class has exactly one project manager.
- A project manager can hold at least one Education Class ie (DE 24, DE 25, AI 24, AI 25, ...)
- The Campus table currently includes Gothenburg and Stockholm and allows future campuses to be added.
- Planned employment of permanent instructors / consultants are handled through the Contract entity by allowing future-dated permanent contracts.

![Conceptual Model](../assets/Conceptual.png)

## Entity Descriptions

### Conceptual ERD – Entity Descriptions

| Entity | Description |
|------|------------|
| Student | Represents an individual enrolled in one or more education classes. |
| Education Class | A specific round intake of a program, course or standalone course for a given year and campus. ie (DE 24, DE 25, AI 24, AI 25, ...) |
| Program | A 2 year education consisting of multiple courses with defined credits and content. |
| Course | A weeks long duration course with defined credits and content, not part of a program. |
| Standalone Course | A course offered independently, not linked to a program. |
| Campus | A physical school location where Education Classes, consultants and staffs are assigned. |
| Staff | Internal employees such as program managers and administrative staff. |
| Staff Role | Defines the role a staff member has in relation to an education class. For this assignment, only the Program Manager role is modeled, but the structure supports additional roles.|
| Consultant | External personnel contracted to teach or support education classes. |
| Consultant Teaches | Associative entity linking consultants to education classes they teach. |
| Enrollment | Represents a student’s enrollment in an education class. |
| Contract | Stores employment or consultancy contract information. |
| Sensitive Information | Holds protected personal data, separated for access control. |


## Relationship Description:

| Entity A          | Entity B              | Cardinality | Relationship Statement                                                   |
| ----------------- | --------------------- | ----------- | ------------------------------------------------------------------------ |
| Program           | Education Class       | 1 → many    | One program is taught in multiple education classes (approval years).    |
| Course            | Education Class       | 1 → many    | One course can be taught in multiple education classes.                  |
| Standalone Course | Education Class       | 1 → many    | One standalone course can be offered through multiple education classes. |
| Campus            | Education Class       | 1 → many    | One campus hosts multiple education classes.                             |
| Campus            | Staff                 | 1 → many    | One campus employs many staff members.                                   |
| Campus            | Consultant            | 1 → many    | One campus employs many consultants.                                     |
| Campus            | Student               | 1 → many    | One campus takes many students.                                          |
| Staff             | StaffRole             | many → 1    | One staff member has the one role (one role = one contract rule).        |
| StaffRole         | Staff                 | 1  → many   | Each staff role can be assigned to different staff members.              |
| StaffRole         | Education Class       | 1  → many   | A staff role can handle multiple education classes. ie.(Each program manager is responsible for three classes )|
| Education Class   | Staff Role            | many  → 1   | Each Education Class can be handled by one Staff Roles                  |
| Staff             | Contract              | 1 → 1       | Each staff member can have one set of active contract.                   |
| Staff             | Sensitive Information | 1 → 1       | Each staff member has exactly one set of sensitive personal data.        |
| Consultant        | Contract              | 1 → 1       | Each staff member can have one set of active contract.                   |
| Consultant        | Sensitive Information | 1 → 1       | Each consultant has exactly one set of sensitive personal data.          |
| Consultant        | Consultant Teaches    | 1 → many    | One consultant can teach multiple education classes.                     |
| ConsultantTeaches | Consultant            | many → 1    | Each teaching assignment belongs to exactly one consultant.              |
| Education Class   | Consultant Teaches    | 1 → many    | One education class can be taught by multiple consultants.               |
| ConsultantTeaches | EducationClass        | many → 1    | Each teaching assignment belongs to exactly one education class.         |
| Education Class   | Enrollment            | 1 → many    | One education class has many student enrollments.                        |
| Enrollment        | EducationClass        | many → 1    | Each enrollment belongs to exactly one education class.                  |
| Student           | Enrollment            | 1 → many    | One student can be enrolled in multiple education classes.               |
| Enrollment        | Student               | many → 1    | Each enrollment belongs to exactly one student.                          |
| Student           | Sensitive Information | 1 → 1       | Each student has exactly one set of sensitive personal data.             |
