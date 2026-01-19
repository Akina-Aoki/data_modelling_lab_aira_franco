BEGIN;

-- =========================================================
-- PROGRAM
-- =========================================================
INSERT INTO program (program_id, program_name, program_credits, program_description) VALUES
('PROG_DE', 'Data Engineering', 400, 'Two-year vocational program focused on data engineering, databases, and analytics.'),
('PROG_UX', 'UX Design', 400, 'Two-year vocational program focused on user experience design and usability.'),
('PROG_JAVA', 'Java Developer', 400, 'Two-year vocational program focused on Java and backend development.');

-- =========================================================
-- CAMPUS
-- =========================================================
INSERT INTO campus (campus_id, campus_name, city) VALUES
('CAMP_STH', 'Yrkesco Stockholm', 'Stockholm'),
('CAMP_GBG', 'Yrkesco Göteborg', 'Göteborg');

-- =========================================================
-- PRIVATE DETAILS (24 rows)
-- =========================================================
INSERT INTO private_details (private_details_id, personal_identity_number, email, address) VALUES
('PRIV_0001','199501209481','alex.morgan87@outlook.com','Storgatan 12, 111 22 Stockholm'),
('PRIV_0002','199506099873','lina.bergstrom@proton.me','Sveavägen 45, 113 34 Stockholm'),
('PRIV_0003','199409230001','devon.park@companymail.io','Hornsgatan 88, 117 28 Stockholm'),
('PRIV_0004','199903219461','samuel.choi92@gmail.com','Fleminggatan 21, 112 26 Stockholm'),
('PRIV_0005','199709124512','nina.karlsson@fastmail.com','Odengatan 60, 113 22 Stockholm'),
('PRIV_0006','200009109241','oliver.jensen@workhub.co','Andra Långgatan 14, 413 03 Göteborg'),
('PRIV_0007','200210109872','maya.rivera@techmail.net','Linnégatan 33, 413 04 Göteborg'),
('PRIV_0008','198901189380','henrik.lund@posteo.net','Vasagatan 7, 411 24 Göteborg'),
('PRIV_0009','200311129090','isabelle.fournier@inbox.com','Kungsportsavenyen 9, 411 36 Göteborg'),
('PRIV_0010','199604059831','ryan.connell@cloudmail.io','Östra Hamngatan 5, 411 10 Göteborg'),
('PRIV_0011','199610109111','sofia.petrov@securemail.me','Karlavägen 18, 114 31 Stockholm'),
('PRIV_0012','199212119112','daniel.wong@devmail.org','Valhallavägen 120, 114 41 Stockholm'),
('PRIV_0013','200004109113','emma.svensson@businessmail.se','Birger Jarlsgatan 50, 114 29 Stockholm'),
('PRIV_0014','200012109114','lucas.martin@startupbox.co','Norr Mälarstrand 64, 112 51 Stockholm'),
('PRIV_0015','200410109115','ayumi.tanaka@protonmail.com','Götgatan 76, 118 30 Stockholm'),
('PRIV_0016','199103109116','noah.bennett@dataworks.io','Södra Vägen 20, 412 54 Göteborg'),
('PRIV_0017','199807109117','claire.dubois@webmail.fr','Engelbrektsgatan 34, 411 37 Göteborg'),
('PRIV_0018','199204109118','viktor.novak@europe-mail.eu','Avenyn 15, 411 36 Göteborg'),
('PRIV_0019','200110109119','hannah.schmidt@digitalpost.de','Masthuggstorget 3, 413 27 Göteborg'),
('PRIV_0020','199912109120','marcus.lee@productivity.app','Haga Nygata 11, 413 01 Göteborg'),
('PRIV_0021','200503109121','elena.rossi@italiamail.it','Strandvägen 7, 114 56 Stockholm'),
('PRIV_0022','199508109122','tom.andersen@northmail.no','Nybrogatan 25, 114 39 Stockholm'),
('PRIV_0023','200110109123','priya.nair@globaltechmail.com','Järntorget 8, 413 04 Göteborg'),
('PRIV_0024','199805109124','kevin.brooks@testenv.local','Packhusplatsen 2, 411 13 Göteborg');

-- =========================================================
-- STUDENT
-- =========================================================
INSERT INTO student (student_id, first_name, last_name, private_details_id) VALUES
('STUD_01','Alex','Morgan','PRIV_0001'),
('STUD_02','Lina','Bergstrom','PRIV_0002'),
('STUD_03','Devon','Park','PRIV_0003'),
('STUD_04','Samuel','Choi','PRIV_0004'),
('STUD_05','Nina','Karlsson','PRIV_0005'),
('STUD_06','Oliver','Jensen','PRIV_0006'),
('STUD_07','Maya','Rivera','PRIV_0007'),
('STUD_08','Henrik','Lund','PRIV_0008'),
('STUD_09','Isabelle','Fournier','PRIV_0009'),
('STUD_10','Ryan','Connell','PRIV_0010');

-- =========================================================
-- STAFF
-- =========================================================
INSERT INTO staff (staff_id, first_name, last_name, private_details_id) VALUES
('STAFF_01','Sofia','Petrov','PRIV_0011'),
('STAFF_02','Daniel','Wong','PRIV_0012'),
('STAFF_03','Emma','Svensson','PRIV_0013'),
('STAFF_04','Lucas','Martin','PRIV_0014'),
('STAFF_05','Ayumi','Tanaka','PRIV_0015'),
('STAFF_06','Noah','Bennett','PRIV_0016'),
('STAFF_07','Claire','Dubois','PRIV_0017'),
('STAFF_08','Viktor','Novak','PRIV_0018'),
('STAFF_09','Hannah','Schmidt','PRIV_0019'),
('STAFF_10','Marcus','Lee','PRIV_0020');

-- =========================================================
-- CONSULTANT COMPANY
-- =========================================================
INSERT INTO consultant_company (consultant_company_id, company_name, organization_number, f_tax_status, address) VALUES
('CC_STH_01','Nordic Tech Consulting AB','5561234567',true,'Kungsgatan 10, 111 43 Stockholm'),
('CC_GBG_01','West Coast IT Solutions AB','5567654321',true,'Södra Hamngatan 15, 411 14 Göteborg');

-- =========================================================
-- CONSULTANT
-- =========================================================
INSERT INTO consultant (consultant_id, first_name, last_name, private_details_id, consultant_company_id) VALUES
('CONS_01','Elena','Rossi','PRIV_0021','CC_STH_01'),
('CONS_02','Tom','Andersen','PRIV_0022','CC_STH_01'),
('CONS_03','Priya','Nair','PRIV_0023','CC_GBG_01'),
('CONS_04','Kevin','Brooks','PRIV_0024','CC_GBG_01');

-- =========================================================
-- COURSE
-- =========================================================
INSERT INTO course (course_id, program_id, course_code, course_name, course_credits, course_description) VALUES
('C_DE_01','PROG_DE','DE101','Introduction to Data Engineering',50,'Fundamentals of data engineering and SQL'),
('C_DE_02','PROG_DE','DE201','Databases and SQL',75,'Relational databases and normalization'),
('C_UX_01','PROG_UX','UX101','UX Fundamentals',50,'User-centered design principles'),
('C_UX_02','PROG_UX','UX201','Prototyping and Design Systems',75,'Advanced UX prototyping'),
('C_JAVA_01','PROG_JAVA','JAVA101','Java Programming Basics',50,'Java and OOP fundamentals'),
('C_JAVA_02','PROG_JAVA','JAVA201','Object-Oriented Java',75,'Advanced Java concepts'),
('C_ST_01',NULL,'ST001','Agile Project Methods',25,'Standalone agile methods course');

-- =========================================================
-- CLASS
-- =========================================================
INSERT INTO class (class_id, program_id, campus_id, class_name, class_code, academic_year) VALUES
('CLS_DE_STH_24','PROG_DE','CAMP_STH','Data Engineering – Stockholm','DE-STH-24','2024/2025'),
('CLS_UX_STH_24','PROG_UX','CAMP_STH','UX Design – Stockholm','UX-STH-24','2024/2025'),
('CLS_DE_GBG_24','PROG_DE','CAMP_GBG','Data Engineering – Göteborg','DE-GBG-24','2024/2025'),
('CLS_JAVA_GBG_24','PROG_JAVA','CAMP_GBG','Java Developer – Göteborg','JAVA-GBG-24','2024/2025');

-- =========================================================
-- STAFF CONTRACT
-- =========================================================
INSERT INTO staff_contract (staff_contract_id, staff_id, role, contract_type, start_date, end_date, status, salary, campus_id) VALUES
('SC_01','STAFF_01','PROGRAM_MANAGER','PERMANENT','2024-09-01','2026-08-31','ACTIVE',52000,'CAMP_STH'),
('SC_02','STAFF_02','PROGRAM_MANAGER','PERMANENT','2024-09-01','2026-08-31','ACTIVE',52000,'CAMP_STH'),
('SC_03','STAFF_03','INSTRUCTOR','PERMANENT','2024-09-01','2026-08-31','ACTIVE',48000,'CAMP_STH'),
('SC_04','STAFF_04','ADMINISTRATOR','PERMANENT','2024-09-01','2026-08-31','ACTIVE',45000,'CAMP_STH'),
('SC_05','STAFF_05','ECONOMIST','PERMANENT','2024-09-01','2026-08-31','ACTIVE',47000,'CAMP_STH'),
('SC_06','STAFF_06','PROGRAM_MANAGER','PERMANENT','2024-09-01','2026-08-31','ACTIVE',52000,'CAMP_GBG'),
('SC_07','STAFF_07','PROGRAM_MANAGER','PERMANENT','2024-09-01','2026-08-31','ACTIVE',52000,'CAMP_GBG'),
('SC_08','STAFF_08','INSTRUCTOR','PERMANENT','2024-09-01','2026-08-31','ACTIVE',48000,'CAMP_GBG'),
('SC_09','STAFF_09','ADMINISTRATOR','PERMANENT','2024-09-01','2026-08-31','ACTIVE',45000,'CAMP_GBG'),
('SC_10','STAFF_10','ECONOMIST','PERMANENT','2024-09-01','2026-08-31','ACTIVE',47000,'CAMP_GBG');

-- =========================================================
-- CONSULTANT CONTRACT
-- =========================================================
INSERT INTO consultant_contract (consultant_contract_id, consultant_id, role, contract_type, start_date, end_date, status, hourly_rate, campus_id) VALUES
('CCN_01','CONS_01','INSTRUCTOR','CONSULTING','2024-09-01','2026-08-31','ACTIVE',850,'CAMP_STH'),
('CCN_02','CONS_02','INSTRUCTOR','CONSULTING','2024-09-01','2026-08-31','ACTIVE',900,'CAMP_STH'),
('CCN_03','CONS_03','INSTRUCTOR','CONSULTING','2024-09-01','2026-08-31','ACTIVE',800,'CAMP_GBG'),
('CCN_04','CONS_04','INSTRUCTOR','CONSULTING','2024-09-01','2026-08-31','ACTIVE',820,'CAMP_GBG');

-- =========================================================
-- CONSULTANT TEACH
-- =========================================================
INSERT INTO consultant_teach (consultant_id, course_id, start_date, end_date) VALUES
('CONS_01','C_DE_01','2024-09-01','2024-12-31'),
('CONS_01','C_DE_02','2025-01-01','2025-05-31'),
('CONS_02','C_UX_01','2024-09-01','2024-12-31'),
('CONS_02','C_UX_02','2025-01-01','2025-05-31'),
('CONS_03','C_JAVA_01','2024-09-01','2024-12-31'),
('CONS_03','C_JAVA_02','2025-01-01','2025-05-31'),
('CONS_04','C_ST_01','2025-02-01','2025-04-30');

-- =========================================================
-- PROGRAM MANAGER MANAGEMENT
-- =========================================================
INSERT INTO program_manager_management (pm_management_id, staff_contract_id, class_id) VALUES
('PMM_01','SC_01','CLS_DE_STH_24'),
('PMM_02','SC_02','CLS_UX_STH_24'),
('PMM_03','SC_06','CLS_DE_GBG_24'),
('PMM_04','SC_07','CLS_JAVA_GBG_24');

-- =========================================================
-- ENROLLMENT
-- =========================================================
INSERT INTO enrollment (student_id, class_id, status) VALUES
('STUD_01','CLS_DE_STH_24','ACTIVE'),
('STUD_02','CLS_DE_STH_24','ACTIVE'),
('STUD_03','CLS_UX_STH_24','ACTIVE'),
('STUD_04','CLS_DE_STH_24','ACTIVE'),
('STUD_05','CLS_UX_STH_24','ACTIVE'),
('STUD_06','CLS_DE_GBG_24','ACTIVE'),
('STUD_07','CLS_DE_GBG_24','ACTIVE'),
('STUD_08','CLS_JAVA_GBG_24','ACTIVE'),
('STUD_09','CLS_DE_GBG_24','ACTIVE'),
('STUD_10','CLS_JAVA_GBG_24','ACTIVE');

COMMIT;
