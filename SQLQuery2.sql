--create a join table
select * from Absenteeism_at_work a
left join compensation b
ON a.ID = b.ID
left join Reasons r on 
a.Reason_for_absence = r.Number;

-- find the healthiest employes for the bonus( don't smoke, no drink)
select * from Absenteeism_at_work
where Social_drinker= 0 and Social_smoker=0 
and Body_mass_index < 25 and 
absenteeism_time_in_hours <(select AVG(absenteeism_time_in_hours) from Absenteeism_at_work)

--- compensation rate increase for non smokers/ budger 983221
---5*8*52=2080*686=1426880
---983221/1426880=0.68 increase per hour
--- 5*8*52*0.68= 1414,4 per year for the non smoker 
select count(*)as nonsmokers from Absenteeism_at_work
where Social_smoker = 0

--optimize this query
select 
a.ID, 
r.Reason
Month_of_absence,
Body_mass_index,
Reason_for_absence,
case when Body_mass_index < 18.5 then 'Underweight'
     when Body_mass_index between 18.5 and 25 then 'Healthy'
	 when Body_mass_index between 25 and 30 then 'Underweight'
	 when Body_mass_index >30 then 'Overwieght'
	 else 'Unkown' end as BMI_Category,
case when Month_of_absence in (12,1,2)  then 'Winter'
     when Month_of_absence in (3,4,5)  then 'Spring'
     when Month_of_absence in (6,7,8)  then 'Summer'
	 when Month_of_absence in (9,10,11)  then 'Fall'
	 ELSE 'Unknown' end as Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker, Pet,
Disciplinary_failure,
Reason_for_absence,
Age, Work_load_Average_day, Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
ON a.ID = b.ID
left join Reasons r on 
a.Reason_for_absence = r.Number;
