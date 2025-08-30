# Layoffs Analysis 

This project explores global layoff trends using SQL to uncover **industry patterns, funding dynamics, and company resilience**.  
Through data exploration and analysis, I investigated which industries were hit hardest, the role of funding in company survival, and which firms contributed most to overall layoffs.  

---

## Dataset Description

The dataset contains **2,361 entries**, each representing a layoff event for a company. It covers the period from **March 2020 to March 2023** and includes the following columns:

- **company** – Name of the company affected by layoffs  
- **location** – Company's country of origin 
- **industry** – Industry sector of the company  
- **total_laid_off** – Number of employees laid off  
- **percentage_laid_off** – Proportion of employees laid off (0–1 scale)  
- **date** – Date of the layoff event  
- **stage** – Funding or company stage (e.g., seed, series A)  
- **country** – Country where the company is located  
- **funds_raised_millions** – Total funding raised in USD  

It was preprocessed to remove duplicates, standardize text fields, convert dates, and populate missing industries where possible. Additional derived columns include **quarter** and **year** for temporal analysis, and the **resilience index**, calculated as the proportion of companies not fully closed in each industry.  

The dataset is provided by **Alex the Analyst**

---

## Project Goals  

The main goal of this project is to demonstrate **SQL data exploration and analysis skills** by finding insights from the dataset.  

This project focuses on:  
- **Layoff trends**: How layoffs change across industries and quarters.

- **Closures (100% layoffs)**: Which industries have the greatest proportion of closures, and whether funding differs between companies that closed and those that remained open.  

- **Industry impact**: Which industries have the most layoffs, the top 3 contributors within each industry and their percentage share, and how funding relates to percentage of employees laid off within the company.  

- **Resilience**: Which industries appear most resilient to closures.  

---

## Key Insights (Summary)

- **Education** experienced the **highest closure rate**, with 14.52% of companies shutting down.  
  *This may reflect the rise of **MOOCs (Massive Open Online Courses)**, which are increasingly replacing traditional training platforms.*  

- In nearly all industries (except **Construction**), companies that closed had **significantly lower funding** compared to those that remained open.  
  - For Construction, however, the trend was reversed: closed companies had an average funding of **USD 1.6B**, while surviving companies averaged **USD 357.9M**.  

- **Consumer, Retail, and Transportation** industries recorded the **largest absolute number of closures**, suggesting these sectors were most heavily disrupted.  

- **Aerospace, Construction, Energy, and FinTech** were highly concentrated industries, where layoffs from **a single company** represented more than **50% of total layoffs**.  

- Across industries, there is **no clear correlation between funding levels and the percentage of employees laid off**, suggesting that high funding does not necessarily protect against layoffs.  

- **Hardware** was identified as the **least resilient industry** to closures, followed closely by **Education**.  

---

## Tools & Skills Used

- **SQL (MySQL 8.0.43)** – data cleaning, aggregation, window functions, subqueries
  
- **Git & GitHub** – version control and portfolio presentation
  
- **Data Analytics Skills** – identifying key business questions, structuring queries for insight

--- 

## Room for Improvement

- **Visualizations:** A significant portion of the data could be better understood through charts and graphs, which would make trends and patterns easier to identify.  

- **Advanced Analysis:** Additional statistical analyses could strengthen insights, such as exploring the relationship between funding and closures, or funding and the percentage of employees laid off.  

- **Domain Knowledge:** Deeper understanding of the companies and industries in the dataset could provide context for interpreting trends and anomalies more accurately.
