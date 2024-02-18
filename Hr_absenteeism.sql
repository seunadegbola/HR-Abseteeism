USE WORK

SELECT * FROM absenteeism a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r 
on a.Reason_for_absence = r.Number

-- Find the healthiest employees for the bonus
SELECT * FROM absenteeism
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 AND Absenteeism_time_in_hours <
(SELECT AVG(Absenteeism_time_in_hours) FROM absenteeism)

--- compensation rate increase for non-smokers
SELECT COUNT(*) as nonsmokers FROM absenteeism
WHERE Social_smoker = 0

-- optimize query 

SELECT 
a.ID,
a.Reason_for_absence,
a.Day_of_the_week,
Month_of_absence,
CASE WHEN Month_of_absence IN (12,1,2) Then 'Winter'
     WHEN Month_of_absence  IN (3,4,5) Then 'Spring'
     WHEN Month_of_absence IN (6,7,8) Then 'Summer'
     WHEN Month_of_absence  IN (9,10,11) Then 'Autumn'
     Else 'unknown' END as Season_names,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 Then 'Underweight'
     WHEN Body_mass_index BETWEEN 18.5 and 24.9 Then 'Health'
     WHEN Body_mass_index BETWEEN 25 and 30 Then 'Overweight'
     WHEN Body_mass_index > 30 Then 'Obese'
     ELSE 'Unknown' end as BMI_Class,
Age,
CASE WHEN Age BETWEEN 20 and 29 Then '20-29'
     WHEN Age BETWEEN 30 and 39 Then '30-39'
     WHEN Age BETWEEN 40 and 49 Then '40-49'
     WHEN Age BETWEEN 50 and 59 Then '50-59'
     WHEN Age >= 60 Then '60s'
     ELSE 'Unknown' end as Age_Class,
a.Seasons,
a.Transportation_expense,
a.Distance_from_Residence_to_Work,
a.Son,
a.Education,
a.Social_drinker,
a.Social_smoker,
a.Absenteeism_time_in_hours,
a.Service_time,
a.Work_load_Average_day,
a.Hit_target,
a.Disciplinary_failure,
a.Weight,
a.Height,
a.Pet,
c.comp_hr,
r.Reason
FROM absenteeism a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r 
on a.Reason_for_absence = r.Number;
