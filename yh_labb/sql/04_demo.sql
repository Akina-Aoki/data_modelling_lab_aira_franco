/* =========================================================
    Demonstrate DB integrity, relationships,
   constraints, indexes, triggers, and a realistic scenario.
   Scenario: New campus Uppsala + DE Cohort 2026–2028
   ========================================================= */

-- A) Baseline sanity checks (shows existing DB is populated)
SELECT COUNT(*) AS total_campuses FROM campus;
SELECT COUNT(*) AS total_programs FROM program;
SELECT COUNT(*) AS total_students FROM student;
SELECT COUNT(*) AS total_staff_contracts FROM staff_contract;
SELECT COUNT(*) AS pm_assignments FROM program_manager_management;

-- B) Scenario setup: New campus in Uppsala
INSERT INTO campus (campus_id, campus_name, city)
VALUES ('UPP', 'Uppsala Campus', 'Uppsala')
ON CONFLICT (campus_id) DO NOTHING;

-- Verify campus exists
SELECT * FROM campus WHERE campus_id = 'UPP';

-- ---------------------------------------------------------
-- C) New class: DE Cohort 2026–2028 at Uppsala campus
-- (class.program_id allows NULL, but here it's DE)
-- ---------------------------------------------------------
INSERT INTO class (class_id, program_id, campus_id, class_name, class_code, academic_year)
VALUES ('DE2628', 'DE', 'UPP', 'DE Cohort 2026-2028 (Uppsala)', 'DE-26-28-UPP', '2026-2028')
ON CONFLICT (class_id) DO NOTHING;