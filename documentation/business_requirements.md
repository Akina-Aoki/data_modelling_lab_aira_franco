# Business Requirements Documentation
This document consolidates business domain / entity, and each section clearly describes business rules.

## 1. Core Design Principles
### 1.1 Modeling Scope
- The database models a vocational school, Yrkesco, operating across multiple campuses.
- The model supports programs, courses (standalone courses are just courses that doesn't exist in a program), students, staff, private details, consultants, consultant company, class, campus,  staff contract and consultant contract.
- All many-to-many relationships are resolved via associative entities.
- The model must satisfy Third Normal Form (3NF).

### 1.2 Security & Data Governance
- Sensitive personal or company-related data is isolated in a dedicated Private Details entity.
- Private Details is not publicly accessible and is referenced via foreign keys only.
- No sensitive attributes are duplicated across entities.

## 2. People & Identity
### 2.1 Student
- Business Rules
- A student can:
    - enroll in one program per term, OR
    - enroll in ONE standalone courses (courses that does not exist in program) per term.
    - A student may not be enrolled in a program and standalone course at the same time.

### Logical / Normalization Rules
- Student stores only identity-level attributes.
- Sensitive attributes are stored in Private Details.

- Relationship:
    - Student 1 → many Enrollment
    - Student 1  →  many Campus

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
    - Teaching can be performed by internal staff or external consultants.

- Logical / Normalization Rules
    - Staff references Contract and Private Details.

### 2.3 Consultant
- Business Rules
    - Consultants are external service providers.
    - Consultants only teach classes.
    - A consultant may teach multiple courses through Consultant Teach.
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

### 3.2 Planned Employment of Permanent Instructors
- Instructor is modeled as a role rather than a separate entity.
- Teaching responsibilities may be fulfilled by either consultants or permanent staff, depending on the active or planned contract.
- Planned employment of permanent instructors is represented through future-dated staff contracts.

- This requirement is about time.
- This is supported in the attributes in the `contract` table for (both allowed to teach) Consultants and Staff by having the following attributes:
     - `start_date`
     - `end_date`
     - `status`
     - `contract_type`

## 4. Program Manager Management
    - Each class class must have exactly one program manager.
    - A program manager must manage at least three education classes.
    - Maximum of three concurrent classes per program manager.
    - A staff contract with role = `PROGRAM_MANAGER` may be assigned to manage classes.
        - This aligns all three requirements:
        - Instructor role
        - Planned employment
        - Max 3 classes constraint

## 5. Education Structure
### 5.1 Program
- A program is a two-year education consisting of multiple courses, including mandatory internship (LIA). 
- A program may be approved multiple times over different years; each approval creates one Class (e.g., DE24, DE25, DE26). 
- Each Class belongs to exactly one Program.

### 5.2 Course
- A course has a course name, course code, credits, and a short description. 
- A course may either:
    - belong to one Program (program course), or
    - belong to no Program (standalone course). 
- Courses are delivered to classes through teaching/delivery assignments; courses are not owned directly by classes (conceptually).
- A course may be taught by multiple consultants through Consultant Teach across different terms. Each Consultant Teach record references exactly one Course

- Logical / Normalization Rules
    - program_id nullable
    - Constraint-based classification:
    - IF `program_id` IS NOT NULL AND `course_id` IS NULL → program course
    - IF `program_id` IS NULL AND `course_id` IS NOT NULL → standalone course
    - And vice versa

### 5.3 Class
- A Class (e.g., DE24, DE25, DE26) represents an approved delivery instance of a Program.
- A class groups students who study together under the same program approval round and is delivered at one campus.
- Students enroll in a class; students do not enroll directly in programs or courses.

## 6. Enrollment
### 6.1 Enrollment

- Business Rules
    - Enrollment links one student to one class.
    - A class may have many enrollments.

- Logical / Normalization Rules
    - Resolves the many-to-many relationship between Student and Education Class.


## 7. Campus
### 7.1 Campus
- Business Rules
    - Represents a physical school location.
    - Current campuses: Gothenburg and Stockholm.
    - Supports future expansion.

- Logical / Normalization Rules
    - Campus 1 → many Classes