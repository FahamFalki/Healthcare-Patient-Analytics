# Healthcare Appointment No-show Analysis

An end-to-end data analysis of 7,000 medical appointments, built to answer one question: **what drives patients to miss their appointments?** The project moves from data cleaning in Python, through validation and summary tables in Excel, to an interactive dashboard in Tableau.

## Dashboard

![Dashboard preview](images/dashboard.png)

**Live dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/first.last4162/viz/Project1_17928178650680/Dashboard1)

The dashboard has three KPI cards (total appointments, no-shows, no-show rate) and four charts: no-show rate by waiting time, no-show rate by age group, SMS reminders vs no reminders within each wait bucket, and the overall share of missed appointments.

## Business question

Missed appointments waste clinic capacity and delay care for other patients. This analysis looks at which patient and booking factors are linked to a missed appointment, so a clinic could decide where reminders and scheduling changes would help most.

## Dataset

- 7,000 appointment records, based on the public Kaggle *Medical Appointment No Shows* dataset
- Each row is one appointment, with patient age, gender, neighbourhood, scheduled and appointment dates, health flags (hypertension, diabetes, alcoholism, handicap), whether an SMS reminder was received, and whether the patient showed up
- Fields created during cleaning: `age_group`, `appt_weekday`, `wait_days`, `wait_bucket`, `no_show_flag` (1 = missed, 0 = attended)

## Tools

Python (Google Colab), SQL (MySQL), Excel, Tableau Public

## Process

1. **Python:** cleaned the raw data and engineered the age group, weekday, waiting time and no-show flag fields.
2. **Excel:** loaded the data into a Table and checked it (the waiting time column matched a recalculation from the dates, with 0 mismatches). Built summary tables with `COUNTIFS` and PivotTables, and confirmed that totals reconcile across every table (7,000 appointments, 1,392 no-shows).
3. **Tableau:** built the KPI cards and charts and combined them into a single dashboard with a dark theme.

## Key findings

**Overall:** 1,392 of 7,000 appointments were missed, a no-show rate of **19.9%**.

**1. Waiting time matters most.** The longer the wait between booking and appointment, the more likely a patient is to miss it.

| Wait time | No-show rate |
|---|---|
| Same day | 4.9% |
| 1-3 days | 22.0% |
| 4-7 days | 23.2% |
| 8-14 days | 31.1% |
| 15-30 days | 34.2% |
| 30+ days | 30.8% |

**2. Age:** teenagers (13-17) miss the most appointments at 26.1%, followed by young adults (18-35) at 23.5%. Seniors (66+) miss the fewest at 15.5%.

**3. SMS reminders look helpful once waiting time is accounted for.** Overall, patients who received an SMS missed more appointments (26.9% vs 16.7%). But SMS recipients skewed toward longer waits, which have higher no-show rates anyway. Within every wait bucket, patients who received an SMS missed fewer appointments, for example 30.6% vs 39.5% at 15-30 days.

**4. Weekday has little effect.** Monday to Thursday sit between 19% and 20%, and Friday is slightly higher at 21.6%. Saturday has only 6 appointments, too few to judge.

**5. Health conditions do not explain missed appointments by themselves.** Hypertension affects 60.6% of seniors and diabetes 25.2%, yet seniors have the lowest no-show rate.

## Limitations

- This is observational data, so the results show associations, not proof of cause. For example, the SMS comparison cannot show that reminders *cause* fewer no-shows.
- Some groups are small (for example, Saturday appointments, and teenagers with long waits), so their percentages can swing widely.

## Repository structure

```
.
├── README.md
├── images/
│   └── dashboard.png
├── excel/
│   └── appointments_analysis.xlsx
├── notebook/
│   └── healthcare_analysis.ipynb
└── sql/
    └── healthcare_queries.sql
```

## How to reproduce

1. Run the notebook in `notebook/` to clean the raw data and create the extra fields.
2. Open `excel/appointments_analysis.xlsx` to see the validation, summary tables and pivots.
3. Connect Tableau to the Excel file and open the dashboard link above.

## Author

**Faham Falki**
LinkedIn: [YOUR-LINKEDIN-URL]
