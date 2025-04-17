# 🚔 Traffic Stops Analysis — Connecticut State Patrol (2013–2015)

This project explores the Connecticut State Patrol dataset to uncover patterns and potential disparities in traffic stop outcomes across different demographic groups. The goal is to use data-driven storytelling, statistical rigor, and compelling visualizations to highlight systemic issues in law enforcement practices and offer a foundation for equitable policy interventions.

🔍 Designed for data analysts, researchers, and policy advocates interested in racial equity, law enforcement accountability, and social impact analytics.

---

## 📌 Project Overview

- **Objective**: Analyze traffic stop data to assess how factors like race, gender, and age influence enforcement outcomes (e.g., citation, arrest, search).
- **Scope**: The project spans raw data exploration, data cleaning, statistical hypothesis testing, regression modeling, and interactive visual storytelling using R and Tableau.
- **Impact**: Identifies systemic disparities, reveals enforcement patterns, and provides evidence-backed recommendations for improving fairness in traffic policing.

---

## 📁 Dataset Summary

- **Source**: [Connecticut Open Data Portal](https://openpolicing.stanford.edu/data/)
- **File**: `ct_statewide_2020_04_01.csv`
- **Period Covered**: 2013–2015
- **Observations**: ~1.1 million traffic stop records
- **Key Fields**: Date, Subject Race, Subject Sex, County, Outcome, Search Conducted, Contraband Found, Reason for Stop

---

## 🧹 Data Cleaning & Preparation (R)

- Selected relevant columns (e.g., `subject_race`, `subject_sex`, `search_conducted`, `outcome`)
- Converted columns to appropriate formats (`Date`, `Factor`, `Logical`)
- Removed redundant or irrelevant attributes
- Addressed NA values and inconsistencies where needed
- Conducted exploratory data analysis (EDA) on age, race, and stop outcomes

---

## 📊 Visualizations (R)

Visuals were generated using **base R** and **ggplot2** to examine key patterns:

1. **Scatter Plot: Age vs. Outcome**  
   → Revealed a high concentration of stops among individuals aged 25–50.  
   → Citation and warning outcomes dominate over arrests and summons.

2. **Jitter Plot: Search Conducted by Race**  
   → Showed that Black and Hispanic individuals were disproportionately searched.  
   → Sparked hypotheses about racial profiling.

3. **Correlation Heatmap**  
   → Demonstrated strong positive correlation between stops and arrests (0.9).  
   → Negative relationship between citations and arrests.

---

## 📐 Statistical Testing

### 🔹 One-Sample t-test  
- Tested if the average age of individuals stopped = 35  
- **Result**: p-value ≪ 0.05  
- **Conclusion**: Mean age (≈ 38) is statistically higher than 35

### 🔹 Chi-Squared Test  
- Assessed independence between **race** and **search conducted**  
- **Result**: p-value ≪ 0.05  
- **Conclusion**: Race significantly impacts the likelihood of being searched

---

## 📉 Regression Analysis

**Model**: `arrests ~ stops + citations + warnings`

- **Adjusted R²**: 0.598 — Strong model fit
- **Key Coefficients**:
  - 🟢 Stops ↑ → Arrests ↑ (p < 0.001)
  - 🔴 Citations ↑ → Arrests ↓ (p < 0.001)
  - 🟠 Warnings ↑ → Arrests ↓ (p < 0.001)

**Interpretation**: Citation and warning-heavy counties may pursue alternative enforcement strategies compared to those with higher arrest rates.

---

## 📍 Tableau Visualizations

📊 A set of **interactive visualizations** were created in Tableau to uncover and present high-impact insights from the same raw dataset.

### 📌 Key Interactive Visuals:

1. **Racial Distribution of Stops**  
   ➤ _"Over 70% of Stops Involved White Individuals"_  
   - Clear racial exposure distribution
   - Reveals disproportionality in traffic encounters

2. **Search vs. Contraband Found (%)**  
   ➤ _"Racial Disparities in Police Searches and Contraband Recovery"_  
   - Minority groups searched more frequently but yielded fewer contraband findings  
   - Highlights enforcement inefficiency and possible profiling

3. **Hourly Search Trends by Race**  
   ➤ _"Who Gets Searched and When?"_  
   - Black and Hispanic individuals have peak search times during early hours  
   - Suggests behavioral patterns or patrol biases

4. **Treemap: Outcomes by Race and Gender**  
   ➤ _"What Outcomes Follow Stops?"_  
   - White males dominate citation counts  
   - Reveals disparities in enforcement actions across race-gender pairs

5. **Choropleth Map: County-Level Distribution**  
   ➤ _"County-Level Racial Distribution of Traffic Stops in Connecticut (2013–2015)"_  
   - Visualizes the concentration of stops by geography  
   - Darker counties = higher traffic stop volumes for selected demographic groups
  
🔗 **Traffic enforcement insights through race, gender, and geography**  
📁 [View Tableau Visualizations](./visuals/tableau_visualizations.twb)

> All visualizations are based on raw data. Visuals were built in Tableau Public and can be filtered by county, year, gender, and race for dynamic exploration of trends.

---

---

## 📁 Project Structure

```
traffic-stops-analysis/
│
├── README.md
│   # This file
│
├── data/
│   └── ct_statewide_2020_04_01.csv
│       # Raw traffic stop dataset from the Connecticut State Patrol
│
├── scripts/
│   └── traffic_stops_analysis.R
│       # R script for data cleaning, hypothesis testing, regression, and visualizations
│
├── visuals/
│   ├── scatter_age_vs_outcome.png
│   ├── jitter_search_by_race.png
│   ├── correlation_heatmap.png
│   ├── regression_summary.png
│   └── tableau_visualizations.twb
│       # Tableau file with 5 interactive visualizations
│
├── report/
│   └── Traffic_Stops_Analysis_Report.pdf
│       # Final project report detailing methods, results, and policy implications
```
