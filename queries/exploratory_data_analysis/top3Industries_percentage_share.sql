-- For the top3 industries, what % is from each company?
WITH top_industries AS (
	SELECT industry, SUM(total_laid_off) AS industry_total
	FROM layoffs_staging2
	WHERE industry != 'other'
		AND industry IS NOT NULL
	GROUP BY industry
	ORDER BY SUM(total_laid_off) DESC
	LIMIT 3
)
SELECT table1.industry, table1.company, table1.total_laid_off, 
ROUND(table1.total_laid_off / table2.industry_total * 100, 3) AS percentage_share
FROM layoffs_staging2 AS table1
JOIN top_industries AS table2
	ON table1.industry = table2.industry
HAVING percentage_share > 1
ORDER BY table1.industry, percentage_share DESC;
