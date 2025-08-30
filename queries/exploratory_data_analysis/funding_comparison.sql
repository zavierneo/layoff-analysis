-- Difference in funding for the companies not closed and companies closed 
WITH companies_closed AS ( 
	SELECT industry, ROUND(AVG(funds_raised_millions),1) AS funding_closed
	FROM layoffs_staging2
	WHERE percentage_laid_off = 1 
	GROUP BY industry
),
companies_not_closed AS (
	SELECT industry, ROUND(AVG(funds_raised_millions),1) AS funding_not_closed
	FROM layoffs_staging2
	WHERE percentage_laid_off != 1
	GROUP BY industry
)
SELECT companies_closed.industry, funding_closed, funding_not_closed
FROM companies_closed 
JOIN companies_not_closed 
	ON companies_closed.industry= companies_not_closed.industry;