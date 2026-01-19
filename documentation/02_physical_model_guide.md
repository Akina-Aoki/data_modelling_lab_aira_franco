# Guide on how to convert logical model to physical model
- Start from dependency-free tables and work outward toward the most constrained, relationship-heavy tables. Think in terms of foreign-key gravity: tables with no FKs go first; tables that depend on many others go last.
- Tables are created from independent reference data to identity entities, then structural education entities, then contracts, and finally associative tables that enforce business rules.


## 1. Core Reference Tables (No Dependencies)
- These tables stand alone. Nothing blocks their creation.
- No foreign keys. These are foundational dimensions reused everywhere else.
- Create first:
`Program`
`Campus`
`Private_Details`
`Consultant_Company`

## 2. Core Identity Tables (Depend on Private_Details / Company)
- These entities represent people but rely on previously created tables.
- Identity must exist before contracts, enrollments, or assignments can reference it.
- Create next:
5. Staff → FK to private_details
6. Consultant → FK to private_details, consultant_company
7. Student → FK to private_details

## 3. Structural Education Tables
- These define the academic structure.
- Classes and courses must exist before students enroll or staff manage them.
- Create next:
8. Course → FK to program (nullable for standalone)
9. Class → FK to program, campus

## 4. Contract Tables (Time-Bound Role Enforcement)
- Contracts depend on people and campuses.
- Business rules explicitly say roles are defined by active contracts.
- Create next:
10. Staff_Contract → FK to staff, campus
11. Consultant_Contract → FK to consultant, campus

## 5. Associative / Transactional Tables (Highest Dependency)
- These tables enforce business behavior and cardinality.
- Create last:
12. Enrollment → FK to student, class
13. Consultant_Teach → FK to consultant, course
14. Program_Manager_Management → FK to staff_contract, class

- These tables sit at the intersection of multiple entities and cannot exist without them.

## Errors:
- If ever I get a FK error during implementation, it means:
- I violated this order, or
- I missed a dependency in your model (which is valuable feedback).