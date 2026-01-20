/* =========================================================
   - Program Manager assignments are capped at 3 classes per PM (trigger).
   - A dedicated distance class (SC2324) is used to represent a standalone-course cohort
     because enrollment links to class (not course). The standalone course itself has NULL program_id.
   ========================================================= */

BEGIN;

/* ---------------------------------------------------------
   1) Campuses
   --------------------------------------------------------- */
INSERT INTO campus (campus_id, campus_name, city) VALUES
  ('STH', 'Stockholm Campus', 'Stockholm'),
  ('GOT', 'Gothenburg Campus', 'Gothenburg');

/* ---------------------------------------------------------
   2) Programs (400 credits each)
   --------------------------------------------------------- */
INSERT INTO program (program_id, program_name, program_credits, program_description) VALUES
  ('DE', 'Data Engineering', 400, 'Two-year vocational program focused on data engineering fundamentals.'),
  ('UX', 'UX Design',       400, 'Two-year vocational program focused on UX design methods and practice.');

/* ---------------------------------------------------------
   3) Consultant companies
   --------------------------------------------------------- */
INSERT INTO consultant_company (consultant_company_id, company_name, organization_number, f_tax_status, address) VALUES
  ('CC001', 'Nordic Data Consulting AB', '5561234567', TRUE,  'Sveavagen 10, 111 57 Stockholm'),
  ('CC002', 'West Coast Design Partners AB', '5569876543', TRUE, 'Avenyn 1, 411 36 Gothenburg');

/* ---------------------------------------------------------
   4) Private details (students, staff, consultants)
   --------------------------------------------------------- */
INSERT INTO private_details (private_details_id, personal_identity_number, email, address) VALUES
  -- Stockholm staff (5)
  ('PD001', '199001010001', 'pm.de@yrkesco.se', 'Kungsgatan 1, 111 43 Stockholm'),
  ('PD002', '198502020002', 'admin.sth@yrkesco.se', 'Vasagatan 10, 111 20 Stockholm'),
  ('PD003', '197903030003', 'accounting.sth@yrkesco.se', 'Hornsgatan 5, 118 46 Stockholm'),
  ('PD004', '199204040004', 'secretary.sth@yrkesco.se', 'Odengatan 12, 113 22 Stockholm'),
  ('PD005', '198806060005', 'instructor.sth@yrkesco.se', 'Birgerjarlsgatan 20, 114 34 Stockholm'),

  -- Gothenburg staff (5)
  ('PD006', '199101010006', 'pm.ux@yrkesco.se', 'Kungsportsavenyn 10, 411 36 Gothenburg'),
  ('PD007', '198602020007', 'admin.got@yrkesco.se', 'Drottninggatan 1, 411 14 Gothenburg'),
  ('PD008', '197904040008', 'accounting.got@yrkesco.se', 'Andra Langgatan 5, 413 03 Gothenburg'),
  ('PD009', '199205050009', 'secretary.got@yrkesco.se', 'Sodra Vagen 20, 412 54 Gothenburg'),
  ('PD010', '198807070010', 'instructor.got@yrkesco.se', 'Linnégatan 1, 413 04 Gothenburg'),

  -- Consultants (4)
  ('PD011', '198001010011', 'consult.de.sth1@vendor.se',  'Sturegatan 3, 114 36 Stockholm'),
  ('PD012', '198101010012', 'consult.de.sth2@vendor.se',  'Norrmalmstorg 1, 111 46 Stockholm'),
  ('PD013', '198201010013', 'consult.ux.got1@vendor.se',  'Avenyn 5, 411 36 Gothenburg'),
  ('PD014', '198301010014', 'consult.ux.got2@vendor.se',  'Järntorget 2, 413 04 Gothenburg'),

  -- Students (12 program students + 3 standalone students)
  ('PD101', '200501010101', 'student01@yrkesco.se', 'Studentvagen 1, 111 11 Stockholm'),
  ('PD102', '200502020102', 'student02@yrkesco.se', 'Studentvagen 2, 111 11 Stockholm'),
  ('PD103', '200503030103', 'student03@yrkesco.se', 'Studentvagen 3, 111 11 Stockholm'),
  ('PD104', '200504040104', 'student04@yrkesco.se', 'Studentvagen 4, 111 11 Stockholm'),
  ('PD105', '200505050105', 'student05@yrkesco.se', 'Studentvagen 5, 111 11 Stockholm'),
  ('PD106', '200506060106', 'student06@yrkesco.se', 'Studentvagen 6, 111 11 Stockholm'),
  ('PD107', '200507070107', 'student07@yrkesco.se', 'Studentgatan 1, 411 11 Gothenburg'),
  ('PD108', '200508080108', 'student08@yrkesco.se', 'Studentgatan 2, 411 11 Gothenburg'),
  ('PD109', '200509090109', 'student09@yrkesco.se', 'Studentgatan 3, 411 11 Gothenburg'),
  ('PD110', '200510100110', 'student10@yrkesco.se', 'Studentgatan 4, 411 11 Gothenburg'),
  ('PD111', '200511110111', 'student11@yrkesco.se', 'Studentgatan 5, 411 11 Gothenburg'),
  ('PD112', '200512120112', 'student12@yrkesco.se', 'Studentgatan 6, 411 11 Gothenburg'),

  -- Standalone-only students (3)
  ('PD201', '200601010201', 'standalone01@yrkesco.se', 'Distance Only, Sweden'),
  ('PD202', '200602020202', 'standalone02@yrkesco.se', 'Distance Only, Sweden'),
  ('PD203', '200603030203', 'standalone03@yrkesco.se', 'Distance Only, Sweden');

/* ---------------------------------------------------------
   5) Staff (5 per campus)
   --------------------------------------------------------- */
INSERT INTO staff (staff_id, first_name, last_name, private_details_id) VALUES
  -- Stockholm
  ('ST001', 'Diana', 'Engberg',  'PD001'),
  ('ST002', 'Sofia',   'Adminsson','PD002'),
  ('ST003', 'Erik',    'Bokfor',   'PD003'),
  ('ST004', 'Maja',    'Sekret',   'PD004'),
  ('ST005', 'Jonas',   'Larare',   'PD005'),
  -- Gothenburg
  ('ST006', 'Ulrika',  'Xander',   'PD006'),
  ('ST007', 'Oskar',   'Adminsson','PD007'),
  ('ST008', 'Lina',    'Bokfor',   'PD008'),
  ('ST009', 'Alva',    'Sekret',   'PD009'),
  ('ST010', 'Nils',    'Larare',   'PD010');

/* ---------------------------------------------------------
   6) Consultants (4)
   --------------------------------------------------------- */
INSERT INTO consultant (consultant_id, first_name, last_name, private_details_id, consultant_company_id) VALUES
  ('CN001', 'Karin', 'Data',   'PD011', 'CC001'),
  ('CN002', 'Mikael','Pipes',  'PD012', 'CC001'),
  ('CN003', 'Elsa',  'Design', 'PD013', 'CC002'),
  ('CN004', 'Arvid', 'UX',     'PD014', 'CC002');

/* ---------------------------------------------------------
   7) Students
   --------------------------------------------------------- */
INSERT INTO student (student_id, first_name, last_name, private_details_id) VALUES
  ('SU001', 'Amina',   'Berg',   'PD101'),
  ('SU002', 'Noah',    'Lind',   'PD102'),
  ('SU003', 'Ella',    'Svens',  'PD103'),
  ('SU004', 'William', 'Nystrom','PD104'),
  ('SU005', 'Olivia',  'Dahl',   'PD105'),
  ('SU006', 'Lucas',   'Ek',     'PD106'),
  ('SU007', 'Hanna',   'Holm',   'PD107'),
  ('SU008', 'Hugo',    'Fors',   'PD108'),
  ('SU009', 'Freja',   'Wall',   'PD109'),
  ('SU010', 'Adam',    'Sund',   'PD110'),
  ('SU011', 'Stella',  'Borg',   'PD111'),
  ('SU012', 'Leo',     'Kvist',  'PD112'),
  -- Standalone-only
  ('SU101', 'Sana',    'Remote', 'PD201'),
  ('SU102', 'Viktor',  'Remote', 'PD202'),
  ('SU103', 'Mira',    'Remote', 'PD203');

/* ---------------------------------------------------------
   8) Courses (400 per program; plus 1 standalone course=100)
   --------------------------------------------------------- */
INSERT INTO course (course_id, program_id, course_code, course_name, course_credits, course_description) VALUES
  -- Data Engineering: 4 x 100 = 400
  ('DE101', 'DE', 'DE-101', 'SQL & Relational Modeling',      100, 'Core SQL and normalization.'),
  ('DE102', 'DE', 'DE-102', 'Data Pipelines & Orchestration', 100, 'Batch and workflow fundamentals.'),
  ('DE103', 'DE', 'DE-103', 'Data Warehousing',               100, 'Dimensional modeling and BI foundations.'),
  ('DE104', 'DE', 'DE-104', 'Cloud & DevOps for Data',        100, 'Containers, CI/CD, and deployment basics.'),

  -- UX Design: 4 x 100 = 400
  ('UX101', 'UX', 'UX-101', 'User Research Methods',          100, 'Qualitative and quantitative research.'),
  ('UX102', 'UX', 'UX-102', 'Interaction Design',             100, 'Flows, information architecture, UI patterns.'),
  ('UX103', 'UX', 'UX-103', 'Prototyping & Testing',          100, 'Wireframes, prototypes, usability testing.'),
  ('UX104', 'UX', 'UX-104', 'Product Design Delivery',        100, 'Delivery practices, handoff, and collaboration.'),

  -- Standalone course (program_id NULL)
  ('SC100', NULL, 'SC-100', 'Standalone: Data Literacy (Distance)', 100, 'Standalone distance course not tied to a program.');

/* ---------------------------------------------------------
   9) Classes (3 cohorts per program; plus 1 distance cohort for standalone)
   Programs are two years each: 23-25, 24-26, 25-27
   --------------------------------------------------------- */
INSERT INTO class (class_id, program_id, campus_id, class_name, class_code, academic_year) VALUES
  -- Data Engineering cohorts
  ('DE2325', 'DE', 'STH', 'DE Cohort 2023-2025', 'DE-23-25', '2023-2025'),
  ('DE2426', 'DE', 'GOT', 'DE Cohort 2024-2026', 'DE-24-26', '2024-2026'),
  ('DE2527', 'DE', 'STH', 'DE Cohort 2025-2027', 'DE-25-27', '2025-2027'),

  -- UX Design cohorts
  ('UX2325', 'UX', 'GOT', 'UX Cohort 2023-2025', 'UX-23-25', '2023-2025'),
  ('UX2426', 'UX', 'STH', 'UX Cohort 2024-2026', 'UX-24-26', '2024-2026'),
  ('UX2527', 'UX', 'GOT', 'UX Cohort 2025-2027', 'UX-25-27', '2025-2027'),

  -- Distance cohort placeholder for standalone enrollment (enrollment links to class)
  ('SC2324', 'DE', 'STH', 'Standalone Distance Cohort', 'SC-23-24', '2023-2024');

/* ---------------------------------------------------------
   10) Staff contracts (ACTIVE; unique-per-staff where status='ACTIVE')
   Contract dates: 2023-09-01 to 2027-08-31
   --------------------------------------------------------- */
INSERT INTO staff_contract (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id) VALUES
  -- Stockholm staff
  ('SCT01', 'ST001', 'PROGRAM_MANAGER', 'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 65000.00, 'STH'),
  ('SCT02', 'ST002', 'ADMINISTRATOR',   'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 42000.00, 'STH'),
  ('SCT03', 'ST003', 'ACCOUNTANT',      'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 52000.00, 'STH'),
  ('SCT04', 'ST004', 'SECRETARY',       'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 38000.00, 'STH'),
  ('SCT05', 'ST005', 'INSTRUCTOR',      'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 50000.00, 'STH'),

  -- Gothenburg staff
  ('SCT06', 'ST006', 'PROGRAM_MANAGER', 'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 65000.00, 'GOT'),
  ('SCT07', 'ST007', 'ADMINISTRATOR',   'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 42000.00, 'GOT'),
  ('SCT08', 'ST008', 'ACCOUNTANT',      'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 52000.00, 'GOT'),
  ('SCT09', 'ST009', 'SECRETARY',       'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 38000.00, 'GOT'),
  ('SCT10', 'ST010', 'INSTRUCTOR',      'PERMANENT', '2023-09-01', '2027-08-31', 'ACTIVE', 50000.00, 'GOT');

/* ---------------------------------------------------------
   11) Consultant contracts (ACTIVE; unique-per-consultant where status='ACTIVE')
   Contract dates: 2023-09-01 to 2027-08-31
   --------------------------------------------------------- */
INSERT INTO consultant_contract (consultant_contract_id, consultant_id, role, contract_type, start_date, end_date, status, hourly_rate, campus_id) VALUES
  ('CCT01', 'CN001', 'INSTRUCTOR', 'CONTRACTOR', '2023-09-01', '2027-08-31', 'ACTIVE', 950.00, 'STH'),
  ('CCT02', 'CN002', 'INSTRUCTOR', 'CONTRACTOR', '2023-09-01', '2027-08-31', 'ACTIVE', 900.00, 'STH'),
  ('CCT03', 'CN003', 'INSTRUCTOR', 'CONTRACTOR', '2023-09-01', '2027-08-31', 'ACTIVE', 950.00, 'GOT'),
  ('CCT04', 'CN004', 'INSTRUCTOR', 'CONTRACTOR', '2023-09-01', '2027-08-31', 'ACTIVE', 900.00, 'GOT');

/* ---------------------------------------------------------
   12) Consultant teaching assignments
   - Ensure at least one consultant teaches the standalone course (SC100)
   --------------------------------------------------------- */
INSERT INTO consultant_teach (consultant_id, course_id, start_date, end_date) VALUES
  -- Data Engineering teaching
  ('CN001', 'DE101', '2023-09-01', '2025-08-31'),
  ('CN002', 'DE102', '2023-09-01', '2025-08-31'),
  ('CN001', 'DE103', '2024-09-01', '2026-08-31'),
  ('CN002', 'DE104', '2025-09-01', '2027-08-31'),

  -- UX teaching
  ('CN003', 'UX101', '2023-09-01', '2025-08-31'),
  ('CN004', 'UX102', '2023-09-01', '2025-08-31'),
  ('CN003', 'UX103', '2024-09-01', '2026-08-31'),
  ('CN004', 'UX104', '2025-09-01', '2027-08-31'),

  -- Standalone course (distance)
  ('CN001', 'SC100', '2024-01-15', '2024-06-15');

/* ---------------------------------------------------------
   13) Enrollments
   - One ACTIVE enrollment per student (unique partial index)
   - 12 program students distributed across cohorts
   - 3 standalone-only students enrolled in the distance cohort class (SC2324)
   --------------------------------------------------------- */
INSERT INTO enrollment (student_id, class_id, enrollment_date, status) VALUES
  -- DE cohorts
  ('SU001', 'DE2325', '2023-09-05', 'ACTIVE'),
  ('SU002', 'DE2325', '2023-09-05', 'ACTIVE'),
  ('SU003', 'DE2426', '2024-09-05', 'ACTIVE'),
  ('SU004', 'DE2426', '2024-09-05', 'ACTIVE'),
  ('SU005', 'DE2527', '2025-09-05', 'ACTIVE'),
  ('SU006', 'DE2527', '2025-09-05', 'ACTIVE'),

  -- UX cohorts
  ('SU007', 'UX2325', '2023-09-05', 'ACTIVE'),
  ('SU008', 'UX2325', '2023-09-05', 'ACTIVE'),
  ('SU009', 'UX2426', '2024-09-05', 'ACTIVE'),
  ('SU010', 'UX2426', '2024-09-05', 'ACTIVE'),
  ('SU011', 'UX2527', '2025-09-05', 'ACTIVE'),
  ('SU012', 'UX2527', '2025-09-05', 'ACTIVE'),

  -- Standalone-only (distance cohort placeholder)
  ('SU101', 'SC2324', '2024-01-10', 'ACTIVE'),
  ('SU102', 'SC2324', '2024-01-10', 'ACTIVE'),
  ('SU103', 'SC2324', '2024-01-10', 'ACTIVE');

/* ---------------------------------------------------------
   14) Program Manager assignments
   - Trigger enforces: role='PROGRAM_MANAGER' and max 3 classes per PM
   - Index enforces: exactly one PM per class (unique class_id)
   --------------------------------------------------------- */
INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id) VALUES
  -- Data Engineering PM (Stockholm contract) manages 3 DE cohorts
  ('PMM01', 'SCT01', 'DE2325'),
  ('PMM02', 'SCT01', 'DE2426'),
  ('PMM03', 'SCT01', 'DE2527'),

  -- UX PM (Gothenburg contract) manages 3 UX cohorts
  ('PMM04', 'SCT06', 'UX2325'),
  ('PMM05', 'SCT06', 'UX2426'),
  ('PMM06', 'SCT06', 'UX2527');

COMMIT;
