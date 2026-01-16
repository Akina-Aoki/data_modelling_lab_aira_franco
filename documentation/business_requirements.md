# Business Requirements Documentation
This document consolidates business domain / entity, and each section clearly describes business rules.

## 1. Core Design Principles
### 1.1 Modeling Scope
- The database models a vocational school, Yrkesco, operating across multiple campuses.
- The model supports programs, courses (including standalone courses), students, staff, consultants, education class, campus and contracts.
- All many-to-many relationships are resolved via associative entities.
- The model must satisfy Third Normal Form (3NF).

### 1.2 Security & Data Governance
- Sensitive personal or company-related data is isolated in a dedicated Private Details entity.
- Private Details is not publicly accessible and is referenced via foreign keys only.
- No sensitive attributes are duplicated across entities.

## 2. People & Identity
### 2.1 Student
- Business Rules
    - A student represents an individual studying at the school.
    - A student enrolls in education classes via enrollment records.

- A student can:
    - enroll in one program, OR
    - enroll in up to two standalone courses per term.
    - A student may not be enrolled in a program and standalone courses at the same time.

    - “how to enforce it?”, answer:
        - Partial unique constraints
        - CHECK constraints + subqueries
        - Triggers
        - Application-layer validation

### Logical / Normalization Rules
- Student stores only identity-level attributes.
- Sensitive attributes are stored in Private Details.

- Relationship:
    - Student 1 → many Enrollment

### 2.2 Staff
- A staff and consultant has exactly **one role at a time,** defined by their **active contract.**

| **Agreement**        | **Staff (Employee)**                       | **Consultant (External)**                   |
| -------------------- | ------------------------------------------ | ------------------------------------------- |
| Role status          | Internal employee of the school            | External service provider                   |
| Contract type        | Permanent Employment contract              | Consulting/service agreement                |
| Work scope (100%)    | Full-time employment                       | Full-time engagement (not employment)       |
| Tax & social charges | Handled and reported by the school         | Handled by the consultant                   |
| Legal responsibility | School is employer                         | Consultant is an independent business       |

- Business Rules
    - Staff are internal employees of the school.
    - Each staff member has exactly one active contract at a time.
    - Staff roles cannot change without ending the current contract.

- Logical / Normalization Rules
    - Staff references Contract and Private Details.

- Salary rules:
    - fixed_salary IS NOT NULL
    - hourly_rate IS NULL

### 2.3 Consultant
- Business Rules
    - Consultants are external service providers.
    - Consultants only teach education classes.

- Logical / Normalization Rules
    - Consultant references Contract and Private Details.

- Compensation rules:
    - hourly_rate IS NOT NULL
    - fixed_salary IS NULL

### 2.4 Private Details
- Business Rules
    - Stores sensitive personal or company information.
    - Includes personal identity number, email and address.

- Logical / Normalization Rules
    - One-to-one relationship with Student, Staff, and Consultant.
    - No transitive dependencies.

## 3. Contracts & Roles
### 3.1 Contract

- Business Rules
    - A contract defines contract type, dates, status, hourly_rate, fixed_salary, f_tax_status, campus_id.
    - Only one active contract is allowed per person.
    - Contracts support planned employment.
    - A role for staffs and consultants cannot change unless the **contract is ended and a new one is created.**
    - Contracts are private and cannot be publicly accessed.


- Logical / Normalization Rules
    - Contract binds to exactly one Campus.
    - Contract enforces role immutability during its active period.

    - `Staff` → `fixed_salary` **IS NOT NULL** AND `hourly_rate` **IS NULL**
    - `Consultant` → `hourly_rate` **IS NOT NULL** AND `fixed_salary` **IS NULL**

### 3.2 Staff Role

- Business Rules
    - Defines staff responsibilities (e.g., Program Manager, VD, Admin, etc.).

    - Each contract defines exactly one staff role.

## 4. Education Structure
### 4.1 Program

- Business Rules
    - A program is a two-year education consisting of multiple courses.
    - Includes mandatory internship (LIA).
    - Each program is approved multiple times, creating multiple education classes.

- Logical / Normalization Rules
    - Program 1 → many Education Classes

### 4.2 Course

- Business Rules
    - A course has course name, credits, description, and program_id.

- A course can either:
    - belong to 0 or more programs ie.(Python -> DE24, DE25), OR
    - be a standalone course.

- Logical / Normalization Rules
    - program_id nullable
    - Constraint-based classification:
    - IF `program_id` IS NOT NULL AND `course_id` IS NULL → program course
    - IF `program_id` IS NULL AND `course_id` IS NOT NULL → standalone course
    - And vice versa

### 4.3 Education Class
- Business Rules
    - An Education Class is the only entity that connects Students to Programs or Courses.
    - Represents an approved delivery of a program or course for a education_class and campus.
    - Must be associated with either one Program or 1 or 2 (2 max) Course, never both.


- Logical / Normalization Rules
    - Mutually exclusive foreign keys:
    - Exactly one of program_id or course_id must be populated.
    - IF `program_id` IS NULL AND `course_id` IS NOT NULL → Student studies COURSE
    - IF `program_id` IS NOT NULL AND `course_id` IS NULL → Student studies program

## 5. Enrollment
### 5.1 Enrollment

- Business Rules
    - Enrollment links one student to one education class.
    - An education class may have many enrollments.

- Logical / Normalization Rules
    - Resolves the many-to-many relationship between Student and Education Class.

## 6. Teaching & Management Assignments
### 6.1 Consultant Teaches
- Business Rules
    - Consultants may teach multiple education classes.
    - Education classes may be taught by multiple consultants.

- Logical / Normalization Rules
    - Resolves Consultant ↔ Education Class many-to-many relationship.

### 6.2 Program Manager Assignment
- Business Rules
    - Each education class must have exactly one program manager.
    - A program manager must manage at least three education classes.
    - Maximum of three concurrent classes per program manager.

- Logical / Normalization Rules
    - Staff 1 → many Program Manager Assignments
    - Education Class 1 → 1 Program Manager Assignment

## 7. Campus
### 7.1 Campus
- Business Rules
    - Represents a physical school location.
    - Current campuses: Gothenburg and Stockholm.
    - Supports future expansion.

- Logical / Normalization Rules
    - Campus 1 → many Education Classes

    - Campus 1 → many Contracts
    - Campus is derived via joins and not duplicated on dependent entities

## 8. ### `Staff Role` Associate Table
- The requirements mention different staff responsibilities but do not clearly define how staff roles are assigned.
- To model staff responsibilities clearly and ensure that each staff member has one active role at a time, a `Staff Role` entity has been added.
- This entity defines the role a staff member holds during an active contract.

## 9. `Consultant Teaches` Associate Table
- Instructors may be consultants but do not explain how consultants are assigned to education classes.
- To model this clearly and avoid many-to-many relationships, a `Consultant Teaches` entity has been added.
- This entity links a consultant to an education class they teach.

## 9. `Program Manager Assignment` Associate Table
- The requirements state that each education class must have a program manager, but do not explain how this assignment is handled.
- To model this clearly and enforce the responsibility rules, a Program Manager Assignment entity has been added.
- This entity links a program manager to the education classes they manage.