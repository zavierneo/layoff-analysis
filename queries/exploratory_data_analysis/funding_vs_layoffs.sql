-- Industry funding-layoff relationship
WITH company_stats AS (
    SELECT company, industry, funds_raised_millions, percentage_laid_off,
           RANK() OVER(PARTITION BY industry ORDER BY percentage_laid_off DESC) 
    FROM layoffs_staging2
    WHERE percentage_laid_off != 1 AND funds_raised_millions IS NOT NULL AND industry IS NOT NULL
)
SELECT company, industry, funds_raised_millions, percentage_laid_off AS max_percentage
FROM company_stats
ORDER BY industry, max_percentage DESC;