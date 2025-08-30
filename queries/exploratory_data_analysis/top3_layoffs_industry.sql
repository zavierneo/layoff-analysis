-- What industries have the most amount of layoffs? 
SELECT industry, SUM(total_laid_off) -- Identifying top 3 industries
FROM layoffs_staging2
WHERE industry != 'other'
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC
LIMIT 3;