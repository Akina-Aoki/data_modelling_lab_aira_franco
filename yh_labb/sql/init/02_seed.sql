/* =========================================================
   02_seed.sql — INITIAL DATA ONLY
   Safe for Docker init (ON CONFLICT DO NOTHING)
   ========================================================= */

/* -------------------------
   1) Campuses
   ------------------------- */
INSERT INTO campus (campus_id, campus_name, city) VALUES
  ('STH', 'Stockholm Campus', 'Stockholm'),
  ('GOT', 'Gothenburg Campus', 'Gothenburg')
ON CONFLICT (campus_id) DO NOTHING;

/* -------------------------
   2) Programs
   ------------------------- */
INSERT INTO program (program_id, program_name, program_credits, program_description) VALUES
  ('DE', 'Data Engineering', 400, 'Two-year vocational program focused on data engineering fundamentals.'),
  ('UX', 'UX Design', 400, 'Two-year vocational program focused on UX design methods and practice.')
ON CONFLICT (program_id) DO NOTHING;

/* -------------------------
   3) Consultant companies
   ------------------------- */
INSERT INTO consultant_company
  (consultant_company_id, company_name, organization_number, f_tax_status, address)
VALUES
  ('CC001', 'Nordic Data Consulting AB', '5561234567', TRUE, 'Sveavagen 10, 111 57 Stockholm'),
  ('CC002', 'West Coast Design Partners AB', '5569876543', TRUE, 'Avenyn 1, 411 36 Gothenburg')
ON CONFLICT (consultant_company_id) DO NOTHING;

/* -------------------------
   4) Private details
   ------------------------- */
INSERT INTO private_details
  (private_details_id, personal_identity_number, email, address)
VALUES
  ('PD001','199001010001','pm.de@yrkesco.se','Kungsgatan 1, 111 43 Stockholm'),
  ('PD002','198502020002','admin.sth@yrkesco.se','Vasagatan 10, 111 20 Stockholm'),
  ('PD003','197903030003','accounting.sth@yrkesco.se','Hornsgatan 5, 118 46 Stockholm'),
  ('PD004','199204040004','secretary.sth@yrkesco.se','Odengatan 12, 113 22 Stockholm'),
  ('PD005','198806060005','instructor.sth@yrkesco.se','Birgerjarlsgatan 20, 114 34 Stockholm'),

  ('PD006','199101010006','pm.ux@yrkesco.se','Kungsportsavenyn 10, 411 36 Gothenburg'),
  ('PD007','198602020007','admin.got@yrkesco.se','Drottninggatan 1, 411 14 Gothenburg'),
  ('PD008','197904040008','accounting.got@yrkesco.se','Andra Langgatan 5, 413 03 Gothenburg'),
  ('PD009','199205050009','secretary.got@yrkesco.se','Sodra Vagen 20, 412 54 Gothenburg'),
  ('PD010','198807070010','instructor.got@yrkesco.se','Linnégatan 1, 413 04 Gothenburg'),

  ('PD011','198001010011','consult.de.sth1@vendor.se','Sturegatan 3, 114 36 Stockholm'),
  ('PD012','198101010012','consult.de.sth2@vendor.se','Norrmalmstorg 1, 111 46 Stockholm'),
  ('PD013','198201010013','consult.ux.got1@vendor.se','Avenyn 5, 411 36 Gothenburg'),
  ('PD014','198301010014','consult.ux.got2@vendor.se','Järntorget 2, 413 04 Gothenburg'),

  ('PD101','200501010101','student01@yrkesco.se','Studentvagen 1, Stockholm'),
  ('PD102','200502020102','student02@yrkesco.se','Studentvagen 2, Stockholm'),
  ('PD103','200503030103','student03@yrkesco.se','Studentvagen 3, Stockholm'),
  ('PD104','200504040104','student04@yrkesco.se','Studentvagen 4, Stockholm'),
  ('PD105','200505050105','student05@yrkesco.se','Studentvagen 5, Stockholm'),
  ('PD106','200506060106','student06@yrkesco.se','Studentvagen 6, Stockholm'),
  ('PD107','200507070107','student07@yrkesco.se','Studentgatan 1, Gothenburg'),
  ('PD108','200508080108','student08@yrkesco.se','Studentgatan 2, Gothenburg'),
  ('PD109','200509090109','student09@yrkesco.se','Studentgatan 3, Gothenburg'),
  ('PD110','200510100110','student10@yrkesco.se','Studentgatan 4, Gothenburg'),
  ('PD111','200511110111','student11@yrkesco.se','Studentgatan 5, Gothenburg'),
  ('PD112','200512120112','student12@yrkesco.se','Studentgatan 6, Gothenburg'),

  ('PD201','200601010201','standalone01@yrkesco.se','Distance Only'),
  ('PD202','200602020202','standalone02@yrkesco.se','Distance Only'),
  ('PD203','200603030203','standalone03@yrkesco.se','Distance Only')
ON CONFLICT (private_details_id) DO NOTHING;

/* -------------------------
   5) Staff
   ------------------------- */
INSERT INTO staff (staff_id, first_name, last_name, private_details_id) VALUES
  ('ST001','Diana','Engberg','PD001'),
  ('ST002','Sofia','Adminsson','PD002'),
  ('ST003','Erik','Bokfor','PD003'),
  ('ST004','Maja','Sekret','PD004'),
  ('ST005','Jonas','Larare','PD005'),
  ('ST006','Ulrika','Xander','PD006'),
  ('ST007','Oskar','Adminsson','PD007'),
  ('ST008','Lina','Bokfor','PD008'),
  ('ST009','Alva','Sekret','PD009'),
  ('ST010','Nils','Larare','PD010')
ON CONFLICT (staff_id) DO NOTHING;

/* -------------------------
   6) Consultants
   ------------------------- */
INSERT INTO consultant
  (consultant_id, first_name, last_name, private_details_id, consultant_company_id)
VALUES
  ('CN001','Karin','Data','PD011','CC001'),
  ('CN002','Mikael','Pipes','PD012','CC001'),
  ('CN003','Elsa','Design','PD013','CC002'),
  ('CN004','Arvid','UX','PD014','CC002')
ON CONFLICT (consultant_id) DO NOTHING;

/* -------------------------
   7) Students
   ------------------------- */
INSERT INTO student (student_id, first_name, last_name, private_details_id) VALUES
  ('SU001','Amina','Berg','PD101'),
  ('SU002','Noah','Lind','PD102'),
  ('SU003','Ella','Svens','PD103'),
  ('SU004','William','Nystrom','PD104'),
  ('SU005','Olivia','Dahl','PD105'),
  ('SU006','Lucas','Ek','PD106'),
  ('SU007','Hanna','Holm','PD107'),
  ('SU008','Hugo','Fors','PD108'),
  ('SU009','Freja','Wall','PD109'),
  ('SU010','Adam','Sund','PD110'),
  ('SU011','Stella','Borg','PD111'),
  ('SU012','Leo','Kvist','PD112'),
  ('SU101','Sana','Berg','PD201'),
  ('SU102','Viktor','Orban','PD202'),
  ('SU103','Mira','Naka','PD203')
ON CONFLICT (student_id) DO NOTHING;

/* -------------------------
   8) Courses
   ------------------------- */
INSERT INTO course
  (course_id, program_id, course_code, course_name, course_credits, course_description)
VALUES
  ('DE101','DE','DE-101','SQL & Relational Modeling',100,'Core SQL and normalization.'),
  ('DE102','DE','DE-102','Data Pipelines & Orchestration',100,'Batch and workflow fundamentals.'),
  ('DE103','DE','DE-103','Data Warehousing',100,'Dimensional modeling and BI foundations.'),
  ('DE104','DE','DE-104','Cloud & DevOps for Data',100,'Containers, CI/CD, and deployment basics.'),

  ('UX101','UX','UX-101','User Research Methods',100,'Qualitative and quantitative research.'),
  ('UX102','UX','UX-102','Interaction Design',100,'Flows, IA, UI patterns.'),
  ('UX103','UX','UX-103','Prototyping & Testing',100,'Wireframes and usability testing.'),
  ('UX104','UX','UX-104','Product Design Delivery',100,'Delivery and collaboration.'),

  ('SC100',NULL,'SC-100','Standalone: Data Literacy (Distance)',100,'Standalone distance course.')
ON CONFLICT (course_id) DO NOTHING;

/* -------------------------
   9) Classes
   ------------------------- */
INSERT INTO class
  (class_id, program_id, campus_id, class_name, class_code, academic_year)
VALUES
  ('DE2325','DE','STH','DE Cohort 2023-2025','DE-23-25','2023-2025'),
  ('DE2426','DE','GOT','DE Cohort 2024-2026','DE-24-26','2024-2026'),
  ('DE2527','DE','STH','DE Cohort 2025-2027','DE-25-27','2025-2027'),

  ('UX2325','UX','GOT','UX Cohort 2023-2025','UX-23-25','2023-2025'),
  ('UX2426','UX','STH','UX Cohort 2024-2026','UX-24-26','2024-2026'),
  ('UX2527','UX','GOT','UX Cohort 2025-2027','UX-25-27','2025-2027'),

  ('SC2324','DE','STH','Standalone Distance Cohort','SC-23-24','2023-2024')
ON CONFLICT (class_id) DO NOTHING;

/* -------------------------
   10) Staff contracts
   ------------------------- */
INSERT INTO staff_contract
  (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id)
VALUES
  ('SCT01','ST001','PROGRAM_MANAGER','PERMANENT','2023-09-01','2027-08-31','ACTIVE',65000,'STH'),
  ('SCT02','ST002','ADMINISTRATOR','PERMANENT','2023-09-01','2027-08-31','ACTIVE',42000,'STH'),
  ('SCT03','ST003','ACCOUNTANT','PERMANENT','2023-09-01','2027-08-31','ACTIVE',52000,'STH'),
  ('SCT04','ST004','SECRETARY','PERMANENT','2023-09-01','2027-08-31','ACTIVE',38000,'STH'),
  ('SCT05','ST005','INSTRUCTOR','PERMANENT','2023-09-01','2027-08-31','ACTIVE',50000,'STH'),

  ('SCT06','ST006','PROGRAM_MANAGER','PERMANENT','2023-09-01','2027-08-31','ACTIVE',65000,'GOT'),
  ('SCT07','ST007','ADMINISTRATOR','PERMANENT','2023-09-01','2027-08-31','ACTIVE',42000,'GOT'),
  ('SCT08','ST008','ACCOUNTANT','PERMANENT','2023-09-01','2027-08-31','ACTIVE',52000,'GOT'),
  ('SCT09','ST009','SECRETARY','PERMANENT','2023-09-01','2027-08-31','ACTIVE',38000,'GOT'),
  ('SCT10','ST010','INSTRUCTOR','PERMANENT','2023-09-01','2027-08-31','ACTIVE',50000,'GOT')
ON CONFLICT (staff_contract_id) DO NOTHING;

/* -------------------------
   11) Consultant contracts
   ------------------------- */
INSERT INTO consultant_contract
  (consultant_contract_id, consultant_id, role, contract_type, start_date, end_date, status, hourly_rate, campus_id)
VALUES
  ('CCT01','CN001','INSTRUCTOR','CONTRACTOR','2023-09-01','2027-08-31','ACTIVE',950,'STH'),
  ('CCT02','CN002','INSTRUCTOR','CONTRACTOR','2023-09-01','2027-08-31','ACTIVE',900,'STH'),
  ('CCT03','CN003','INSTRUCTOR','CONTRACTOR','2023-09-01','2027-08-31','ACTIVE',950,'GOT'),
  ('CCT04','CN004','INSTRUCTOR','CONTRACTOR','2023-09-01','2027-08-31','ACTIVE',900,'GOT')
ON CONFLICT (consultant_contract_id) DO NOTHING;

/* -------------------------
   12) Consultant teaching
   ------------------------- */
INSERT INTO consultant_teach
  (consultant_id, course_id, start_date, end_date)
VALUES
  ('CN001','DE101','2023-09-01','2025-08-31'),
  ('CN002','DE102','2023-09-01','2025-08-31'),
  ('CN001','DE103','2024-09-01','2026-08-31'),
  ('CN002','DE104','2025-09-01','2027-08-31'),

  ('CN003','UX101','2023-09-01','2025-08-31'),
  ('CN004','UX102','2023-09-01','2025-08-31'),
  ('CN003','UX103','2024-09-01','2026-08-31'),
  ('CN004','UX104','2025-09-01','2027-08-31'),

  ('CN001','SC100','2024-01-15','2024-06-15')
ON CONFLICT DO NOTHING;

/* -------------------------
   13) Enrollments
   ------------------------- */
INSERT INTO enrollment
  (student_id, class_id, enrollment_date, status)
VALUES
  ('SU001','DE2325','2023-09-05','COMPLETED'),
  ('SU002','DE2325','2023-09-05','COMPLETED'),
  ('SU003','DE2426','2024-09-05','ACTIVE'),
  ('SU004','DE2426','2024-09-05','ACTIVE'),
  ('SU005','DE2527','2025-09-05','ACTIVE'),
  ('SU006','DE2527','2025-09-05','WITHDRAWN'),

  ('SU007','UX2325','2023-09-05','COMPLETED'),
  ('SU008','UX2325','2023-09-05','COMPLETED'),
  ('SU009','UX2426','2024-09-05','ACTIVE'),
  ('SU010','UX2426','2024-09-05','WITHDRAWN'),
  ('SU011','UX2527','2025-09-05','ACTIVE'),
  ('SU012','UX2527','2025-09-05','ACTIVE'),

  ('SU101','SC2324','2024-01-10','ACTIVE'),
  ('SU102','SC2324','2024-01-10','ACTIVE'),
  ('SU103','SC2324','2024-01-10','ACTIVE')
ON CONFLICT DO NOTHING;

/* -------------------------
   14) Program Manager assignments
   ------------------------- */
INSERT INTO program_manager_management
  (pm_management_id, staff_contract_id, class_id)
VALUES
  ('PMM01','SCT01','DE2325'),
  ('PMM02','SCT01','DE2426'),
  ('PMM03','SCT01','DE2527'),
  ('PMM04','SCT06','UX2325'),
  ('PMM05','SCT06','UX2426'),
  ('PMM06','SCT06','UX2527')
ON CONFLICT (pm_management_id) DO NOTHING;
