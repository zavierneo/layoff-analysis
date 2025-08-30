-- Industry Resilience Index (companies_not_closed / total companies for each industry)
WITH companies_not_closed AS (
	SELECT industry, COUNT(company) AS count_not_closed
	FROM layoffs_staging2
	WHERE percentage_laid_off != 1
	GROUP BY industry
), 
industry_total AS(
	SELECT industry, COUNT(company) AS count_total
	FROM layoffs_staging2
	GROUP BY industry
)
SELECT table1.industry, ROUND(table2.count_not_closed / table1.count_total,2) AS resilience_index
FROM industry_total AS table1
JOIN companies_not_closed AS table2
	ON table1.industry = table2.industry
ORDER BY resilience_index DESC;