/* (Query on the video) Students (name) + Contact Info (personal_identity_number, email)
Who are the students, how can we contact them?
*/
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    pd.personal_identity_number,
    pd.email

FROM student s
JOIN private_details pd ON s.private_details_id = pd.private_details_id
LEFT JOIN enrollment e ON s.student_id = e.student_id
ORDER BY s.first_name, s.last_name;

/* (Query on the video)
Query: Consultants + consultant company details (organization number, F-tax status, address, and hourly rate) + Contract Type
What are the company details of the consultans and their contract types?
*/
/* Query : Consultants + company + contract details */
SELECT
    c.first_name,
    c.last_name,
    cc.company_name,
    cc.organization_number,
    cc.f_tax_status,
    cc.address,
    con.role,
    con.contract_type,
    con.hourly_rate,
    con.campus_id
FROM consultant c
JOIN consultant_company cc
  ON c.consultant_company_id = cc.consultant_company_id
JOIN consultant_contract con
  ON c.consultant_id = con.consultant_id
WHERE con.status = 'ACTIVE'
ORDER BY
    c.first_name,
    c.last_name,
    cc.company_name;


/* =========================================================
    Demonstrate DB integrity, relationships,
   constraints, indexes, triggers, and a realistic scenario.
   Scenario: New campus Uppsala + DE Cohort 2026–2028
   ========================================================= */
