SHOW VARIABLES LIKE 'local_infile';
CREATE DATABASE IF NOT EXISTS healthcare_appointments DEFAULT CHARACTER SET utf8mb4;
USE healthcare_appointments;
USE healthcare_appointments;
RENAME TABLE `appointments_clean (1)` TO appointments;


-- Count , Allias and Sum
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT patient_id) AS unique_patients,
       SUM(no_show_flag) AS no_shows
FROM appointments;


-- Describing the table
DESCRIBE appointments;


-- Headline Numbers(finding avg values)
SELECT COUNT(*) AS appointments,
       COUNT(DISTINCT patient_id) AS unique_patients,
       ROUND(100 * AVG(no_show_flag), 1) AS no_show_pct,
       ROUND(AVG(wait_days), 1) AS avg_wait_days,
       ROUND(100 * AVG(sms_received), 1) AS sms_pct
FROM appointments;
     
-- for each wait bucket, find appointments, show and no show percentage
select wait_bucket, 
       count(*) as appointments,
       sum(no_show_flag) AS no_show, 
       round(100 * avg(no_show_flag),1) no_show_pct
       from appointments 
       group by wait_bucket
       order by min(wait_days) ; 
       
       -- order by age group
       select age_group,
              count(*) as appointments,
              sum(no_show_flag) as no_show,
              round(100 * avg(no_show_flag),1) as no_show_pct
              from appointments
              group by age_group
              order by age_group;
              
   -- appointments and no show percentage for each appt_weekdays,ordered monday to saturday           
SELECT appt_weekday,
       COUNT(*) AS appointments,
       ROUND(100 * AVG(no_show_flag), 1) AS no_show_pct
FROM appointments
GROUP BY appt_weekday
ORDER BY FIELD(appt_weekday, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');

-- top 10 neighbourhood with respect to no show % and having 50 or more appointment
select neighbourhood,
       count(*) as appointments,
       sum(no_show_flag) as no_show,
       round(100 * avg(no_show_flag),1) as no_show_pct
from appointments
group by neighbourhood
having count(*) >= 50
order by no_show_pct DESC
limit 10;

-- Chronic condition

SELECT 'hypertension' AS condition_name,
       hypertension AS has_condition,
       COUNT(*) AS appointments,
       ROUND(100 * AVG(no_show_flag), 1) AS no_show_pct
FROM appointments
GROUP BY hypertension
UNION ALL
SELECT 'diabetes', diabetes, COUNT(*), ROUND(100 * AVG(no_show_flag), 1)
FROM appointments
GROUP BY diabetes;


-- appointments, no-shows and no-show % for sms_received 0 and 1.
SELECT sms_received,
       COUNT(*) AS appointments,
       SUM(no_show_flag) AS no_shows,
       ROUND(100 * AVG(no_show_flag), 1) AS no_show_pct
FROM appointments
GROUP BY sms_received;

-- SMS, like for like
SELECT wait_bucket,
       ROUND(100 * AVG(CASE WHEN sms_received = 0 THEN no_show_flag END), 1) AS no_sms_pct,
       ROUND(100 * AVG(CASE WHEN sms_received = 1 THEN no_show_flag END), 1) AS sms_pct
FROM appointments
WHERE wait_days > 2
GROUP BY wait_bucket
ORDER BY MIN(wait_days);

-- Aggregate functions
SELECT COUNT(*)                    AS total_rows,
       COUNT(DISTINCT patient_id)  AS unique_patients,
       SUM(no_show_flag)           AS no_shows,
       ROUND(AVG(age), 1)          AS avg_age,
       MIN(age)                    AS min_age,
       MAX(age)                    AS max_age,
       MIN(wait_days)              AS min_wait,
       MAX(wait_days)              AS max_wait,
       ROUND(AVG(wait_days), 1)    AS avg_wait,
       ROUND(STDDEV(wait_days), 1) AS wait_std_dev,
       MIN(appointment_date)       AS first_appt,
       MAX(appointment_date)       AS last_appt
FROM appointments;

