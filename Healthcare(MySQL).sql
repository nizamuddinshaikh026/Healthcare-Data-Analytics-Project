
#1 Monthly revenue (sum of treatment costs per month)
SELECT 
    DATE_FORMAT(v.visit_date, '%Y-%m') AS yearmonth,
    round(SUM(t.cost),2) AS total_revenue
FROM Treatments t
JOIN Visits v ON t.visit_id = v.visit_id
GROUP BY DATE_FORMAT(v.visit_date, '%Y-%m')
ORDER BY DATE_FORMAT(v.visit_date, '%Y-%m');

#2 Number of visits by state
SELECT p.state, COUNT(v.visit_id) AS total_visits
FROM Visits v
JOIN Patients p USING (patient_id)
GROUP BY p.state
ORDER BY total_visits DESC;

#3 Lab tests volume(Performed) by test_name
SELECT test_name, COUNT(*) AS tests_performed
FROM Lab_Results
GROUP BY test_name
ORDER BY tests_performed DESC;

#4 Top 10 highest spending patients by treatments cost
SELECT 
    p.Patient_ID, First_name,
    SUM(t.Cost) AS total_spent
FROM Treatments t
JOIN Visits v ON t.Visit_ID = v.Visit_ID
JOIN Patients p ON v.Patient_ID = p.Patient_ID
GROUP BY p.Patient_ID, First_Name
ORDER BY total_spent DESC
LIMIT 10;

#5 Treatments for Patients with First name,treatment id and cost Visit Before 2024
SELECT 
    p.patient_id,
    p.first_name,
    t.treatment_id,
    t.cost
FROM Treatments t
JOIN Visits v ON t.visit_id = v.visit_id
JOIN Patients p ON v.patient_id = p.patient_id
WHERE v.patient_id IN (
  SELECT v2.patient_id
  FROM Visits v2
  GROUP BY v2.patient_id
  HAVING MIN(v2.visit_date) < '2024-01-01'
);

						-- Stored Procedure --
#6
CALL add_patient(
    1001,
    'Male',
    '1990-05-10',
    34,
    'O+',
    'United Healthcare',
    'California',
    'Los Angeles',
    'USA',
    'POL12345',
    'No major history',
    'White',
    'Non-Hispanic',
    'Single',
    'John',
    'Doe',
    'Hypertension',
    'Peanuts'
);

select * from patients 
where Patient_ID =1001;

CALL add_patient(
    1002,
    'Female',
    '1985-08-15',
    39,
    'A+',
    'Blue Cross',
    'Texas',
    'Houston',
    'USA',
    'POL67890',
    'Diabetic - Type 2',
    'Asian',
    'Hispanic',
    'Married',
    'Emily',
    'Smith',
    'Diabetes',
    'Shellfish'
);




