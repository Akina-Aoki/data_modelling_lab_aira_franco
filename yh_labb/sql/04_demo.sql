-- Sanity checks
SELECT COUNT(*) FROM student;
SELECT COUNT(*) FROM enrollment WHERE status='ACTIVE';

-- Business rule proof
SELECT staff_contract_id, COUNT(*) 
FROM program_manager_management
GROUP BY staff_contract_id;
