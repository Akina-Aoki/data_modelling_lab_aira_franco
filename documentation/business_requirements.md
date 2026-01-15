# Business Clarifications
### 1. Staffs, Consultants and Roles
- Instructors: Can be permanent staff or external consultants.
- Program Managers: Staff members who must manage at least three Education Classes. 
- Each Education Class has exactly one manager. Can hold Education Class ie. (DE 24, DE 25, AI 24, AI 25, ...)
- A staff member has exactly **one role at a time,** defined by their **active contract.**<br>

#### 2. Program vs. Course (BONUS)
- A Program consists of multiple courses over time.
- A student can either:
    - enroll in one program, or
    -enroll in up to two (max) standalone courses per term.
- A student cannot be enrolled in a program and standalone courses at the same time.
- Enrollment represents exactly one student in exactly one education class.
- A Course can belong to zero or one Program (standalone allowed)
- Course must be either program or standalone (never both)
- `program_id` IS `NOT NULL` → course is part of a program
- `program_id` IS `NULL` → course is standalone

### 3. System & Data Design
- Security: Sensitive personal data is isolated in a separate table for strict access control. Sensitive Informations is in a separate secured table. It tracks company staffs and consultant details (Org#, F-tax, address, hourly rates, etc) and cannot be accessed publicly.
- Planned employment of permanent instructors / consultants are handled through the Contract entity by allowing future-dated permanent contracts.
<br>
- Contracts: Used to manage staff roles and pre-plan future permanent hires.
- A role for staffs and consultants cannot change unless the **contract is ended and a new one is created.**
- Campus: Consultants and staffs are assigned **strictly to one campus per contract.**
- The Campus table currently includes Gothenburg and Stockholm and allows future campuses to be added.
<br>
- Locations: Currently Gothenburg and Stockholm, but built to add more cities easily.
- Flexibility: The model is built to allow new rules later without redesigning the foundation.