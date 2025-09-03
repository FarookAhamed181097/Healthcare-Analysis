############## PATIENTS DASHBOARD ####################
create database healthcareDb;
use healthcareDb;
select * from `healthcare master data`;

# display total patient count
select count(`Patient ID`) as total_patients from `healthcare master data`;

# display average patient age
select round(avg(`Patient.Age`),0) as Avg_patient_age from `healthcare master data`;

# display Avg treatment cost per visit
select round(avg(`Treatment Cost`),0) As Avg_Treatment_cost_per_visit from `healthcare master data`;

# display total patients by states
select `Patient.State` as State, count(`Patient ID`) As Total_Patients  from `healthcare master data`
group by `Patient.State`;

# display patient count by age group
select count(`Patient ID`) as total_patients, `Age Group` from `healthcare master data`
group by `Age Group`;

# display patients by gender distribution
select `Patient.Gender` as gender, count(`Patient ID`) as total_patients, 
round(count(`Patient ID`) *100.0 / (select count(`Patient ID`) from `healthcare master data`),2) as Percentage_of_total from `healthcare master data`
group by `Patient.Gender`;

# display patients by disease
select Diagnosis as Disease, count(`Patient ID`) as Total_Patients from `healthcare master data`
group by Diagnosis;

# display patients by blood group
select `Patient.Blood Type` as Blood_Group, count(`Patient ID`) as Total_Patients from `healthcare master data`
group by `Patient.Blood Type`;

#####################################################################################################
############## DOCTORS DASHBOARD ####################

# display total doctors
select count(distinct `Doctor ID`) as Total_Doctors from `healthcare master data`;

# display avg doctor experience
select  round(avg(`Doctor.Years Of Experience`),0) as AVG_Doctor_Experience from `healthcare master data`;

# display avg patient per doctor
select round(count(`Patient ID`) / count( distinct `Doctor ID`),0) as AVG_Patient_Per_Doctor from `healthcare master data`;

# display total tests and test results
SELECT `Lab result.Test Name` AS Test_Name, COUNT(*) AS Total_Tests,
    SUM(CASE WHEN `Lab result.Test Result` = 'Normal' THEN 1 ELSE 0 END) AS Normal_Count,
    SUM(CASE WHEN `Lab result.Test Result` = 'Abnormal' THEN 1 ELSE 0 END) AS Abnormal_Count,
    SUM(CASE WHEN `Lab result.Test Result` = 'Pending' THEN 1 ELSE 0 END) AS Pending_Count
FROM `healthcare master data`
GROUP BY `Lab result.Test Name`;

# display doctors count by their speciality
select count(distinct `Doctor ID`) as Total_Doctors, `Doctor.Specialty` as Doctor_Speciality from `healthcare master data`
group by `Doctor.Specialty`;

# display total billing by departments
select `Doctor.Specialty` as Department, round(sum(`Treatment cost`)/1000000,2) as Total_billing_Millions,
ROUND((SUM(`Treatment cost`) * 100.0) / (SELECT SUM(`Treatment cost`) FROM `healthcare master data`), 2) AS Percentage_of_Total
 from `healthcare master data`
group by  `Doctor.Specialty`;

# display treatment status by doctors
SELECT `Doctor.Specialty`,
    SUM(CASE WHEN `Follow Up Required` = 'Yes' THEN 1 ELSE 0 END) AS Followups_Required,
    SUM(CASE WHEN `Follow Up Required` = 'No' THEN 1 ELSE 0 END) AS No_Followup,
    COUNT(*) AS Total_Treatments 
FROM `healthcare master data`
GROUP BY `Doctor.Specialty`;

# display count of patients visit by doctor speciality
select `Doctor.Specialty`, count(`Patient ID`) as Total_Patients from `healthcare master data`
group by `Doctor.Specialty`;










