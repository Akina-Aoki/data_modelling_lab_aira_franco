# Logical Model & Normalization (1NF -> 2NF -> 3NF)
## Goal: 
- Refine the conceptual model into a formal structure. This is where I define primary keys and ensure my tables and attributes are 3NF validated.

![Logical Model](../assets/Logical.png)

## Consultant, Staff and Staff Role → Contract
nforces “one role per active contract”
- All attributes are still fully dependent on the primary key
- No attribute is dependent on another isolated attribute 
- No data redundancy exists if constraints are enforced in the model and business requirements
    - `Staff` → `fixed_salary` **IS NOT NULL** AND `hourly_rate` **IS NULL**
    - `Consultant` → `hourly_rate` **IS NOT NULL** AND `fixed_salary` **IS NULL**

## Campus → Contract
- One campus can be associated with many contracts. Each contract is assigned to exactly one campus.

## Staff, Consultant and Student → Private Details
- Sensitive personal data is isolated in a dedicated Private Details entity. 
- Staff, Consultant, and Student reference this entity via foreign keys, ensuring that all non-key attributes depend solely on their respective primary keys. 
- No sensitive attributes are duplicated, and no transitive dependencies exist.

## Staff → Program Manager Assignment →  Education Class
- Staff 1 → many Program Manager Assignments
- Education Class 1 → 1 Program Manager Assignment
- Each class has exactly one Program Manager
- A Program Manager manages multiple classes (max 3)

## Consultant → Consultant Teaches →  Education Class
Consultant Teaches is modeled as a pure associative entity resolving the many-to-many relationship between Consultant and Education Class. It contains no descriptive attributes and introduces no transitive dependencies, ensuring Third Normal Form.

## Student → Enrollment → Education Class → Campus
Student stores only student identity attributes and references Private Details. Enrollment models the association between Student and Education Class, including enrollment lifecycle attributes. Campus is associated to Education Class, and is derived through joins rather than duplicated on Student, eliminating redundancy and transitive dependencies and ensuring 3NF.

## Student → Enrollment →  Course (inclduing Standalone) / Program 
Students enroll in Education Classes, which represent either approved program intakes or standalone course offerings. This is enforced by mutually exclusive foreign keys to Program or Course, making the enrollment rules explicit while maintaining Third Normal Form.