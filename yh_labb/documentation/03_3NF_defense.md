# Third Normal Form (3NF) Justification – YrkesCo Database

This document argues that the YrkesCo database schema satisfies **Third Normal Form (3NF)** 

**Definition applied**:
A table is in **3NF** if:

1. It is in **1NF** (atomic attributes, no repeating groups)
2. It is in **2NF** (no partial dependency on part of a composite key)
3. It has **no transitive dependencies** (non-key attributes depend only on the primary key)

---

## Program

| Aspect                   | Justification                                 |
| ------------------------ | --------------------------------------------- |
| Primary Key              | `program_id` uniquely identifies each program |
| Atomic attributes        | Name, credits, description are atomic         |
| No partial dependency    | Single-column PK                              |
| No transitive dependency | All attributes describe the program itself    |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Campus

| Aspect            | Justification                                 |
| ----------------- | --------------------------------------------- |
| Primary Key       | `campus_id`                                   |
| Atomic attributes | Campus name and city are atomic               |
| Dependencies      | All attributes depend directly on `campus_id` |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Private_Details

| Aspect                   | Justification                                     |
| ------------------------ | ------------------------------------------------- |
| Primary Key              | `private_details_id`                              |
| Sensitive data isolation | Personal number, email, address stored separately |
| No transitive dependency | Attributes describe only the private identity     |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Consultant_Company

| Aspect            | Justification                              |
| ----------------- | ------------------------------------------ |
| Primary Key       | `consultant_company_id`                    |
| Atomic attributes | Organization number, F-tax status, address |
| Dependencies      | All attributes describe the company        |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Staff

| Aspect                   | Justification                                  |
| ------------------------ | ---------------------------------------------- |
| Primary Key              | `staff_id`                                     |
| FK usage                 | `private_details_id` references sensitive data |
| No transitive dependency | Personal data not duplicated                   |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Consultant

| Aspect        | Justification                                       |
| ------------- | --------------------------------------------------- |
| Primary Key   | `consultant_id`                                     |
| FK usage      | Links to `private_details` and `consultant_company` |
| Normalization | Company data not duplicated                         |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Student

| Aspect                   | Justification                                 |
| ------------------------ | --------------------------------------------- |
| Primary Key              | `student_id`                                  |
| Sensitive data isolation | Personal data stored via FK                   |
| Dependencies             | All attributes depend on the student identity |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Course

| Aspect                   | Justification                            |
| ------------------------ | ---------------------------------------- |
| Primary Key              | `course_id`                              |
| Optional FK              | `program_id` allows standalone courses   |
| No transitive dependency | Course attributes independent of program |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Class

| Aspect               | Justification                           |
| -------------------- | --------------------------------------- |
| Primary Key          | `class_id`                              |
| FK usage             | References `program` and `campus`       |
| Temporal correctness | Academic year belongs to class delivery |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Staff_Contract

| Aspect                   | Justification                                |
| ------------------------ | -------------------------------------------- |
| Primary Key              | `staff_contract_id`                          |
| Temporal separation      | Role, status, salary tied to contract period |
| No transitive dependency | Contract data not stored in staff            |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Consultant_Contract

| Aspect                | Justification                           |
| --------------------- | --------------------------------------- |
| Primary Key           | `consultant_contract_id`                |
| Time-bound attributes | Hourly rate and role depend on contract |
| Normalization         | Consultant identity stored separately   |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Enrollment

| Aspect                   | Justification                                   |
| ------------------------ | ----------------------------------------------- |
| Primary Key              | `enrollment_id` (surrogate key)                 |
| Associative entity       | Resolves Student–Class many-to-many             |
| No transitive dependency | Enrollment attributes depend only on enrollment |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Consultant_Teach

| Aspect              | Justification                           |
| ------------------- | --------------------------------------- |
| Primary Key         | `consultant_teach_id`                   |
| Associative entity  | Resolves Consultant–Course many-to-many |
| Temporal attributes | Dates belong to teaching assignment     |

**3NF Verdict:** ✔ Satisfies 3NF

---

## Program_Manager_Management

| Aspect             | Justification                                     |
| ------------------ | ------------------------------------------------- |
| Primary Key        | `pm_management_id`                                |
| Associative entity | Links staff contracts to classes                  |
| Business rules     | Cardinality enforced via constraints and triggers |

**3NF Verdict:** ✔ Satisfies 3NF

---
