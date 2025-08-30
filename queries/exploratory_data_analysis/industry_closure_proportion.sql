-- What industries have the greatest proportion of closures? (laid off 100% of employees)
SELECT industry, companies_closed, total_companies, ROUND(companies_closed/total_companies * 100, 2) as percentage_closed
FROM( 
	SELECT industry, COUNT(DISTINCT company) AS total_companies,
	COUNT(DISTINCT CASE WHEN percentage_laid_off = 1 THEN company END) AS companies_closed
	FROM layoffs_staging2
	WHERE industry IS NOT NULL
	GROUP BY INDUSTRY
) AS industry_stats
WHERE total_companies > 10 -- Only industries where there are 10 or more companies are counted to have less misleading data 
ORDER BY percentage_closed DESC;