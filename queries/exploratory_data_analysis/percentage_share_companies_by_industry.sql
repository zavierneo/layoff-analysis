-- For each industry, who are the top 3 contributors to layoffs?
WITH industry_totals AS(					-- 1. Calculate total layoffs per industry
	SELECT industry, SUM(total_laid_off) AS industry_totals
	FROM layoffs_staging2
	WHERE industry != 'other' 
	GROUP BY industry
),
company_totals AS (							-- 2. Calculate total layoffs per company within each industry
SELECT company, industry, SUM(total_laid_off) AS company_totals
	FROM layoffs_staging2
	WHERE industry != 'other' 
	GROUP BY company, industry
	HAVING SUM(total_laid_off) IS NOT NULL
),
ranked_totals AS(							-- 3. Calculate % share and rank companies within each industry
	SELECT c.industry, c.company, c.company_totals, ROUND(c.company_totals / i.industry_totals * 100, 3) AS percentage_share,
	RANK() OVER(PARTITION BY c.industry ORDER BY c.company_totals DESC) AS `rank`
	FROM company_totals AS c
	JOIN industry_totals AS i 
		ON c.industry = i.industry
)
SELECT industry, company, company_totals, percentage_share
FROM ranked_totals 
WHERE `rank` <= 3 
ORDER BY industry, percentage_share DESC;