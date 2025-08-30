-- Layoffs per industry each quarter 
	-- 2020 Q1 is not used as the data starts from March
SELECT 
    industry,
    SUM(CASE WHEN `year` = 2020 AND quarter_num = 2 THEN total_laid_off ELSE 0 END) AS Q2_2020, 
    SUM(CASE WHEN `year` = 2020 AND quarter_num = 3 THEN total_laid_off ELSE 0 END) AS Q3_2020, 
    SUM(CASE WHEN `year` = 2020 AND quarter_num = 4 THEN total_laid_off ELSE 0 END) AS Q4_2020,
	SUM(CASE WHEN `year` = 2021 AND quarter_num = 1 THEN total_laid_off ELSE 0 END) AS Q1_2021,
    SUM(CASE WHEN `year` = 2021 AND quarter_num = 2 THEN total_laid_off ELSE 0 END) AS Q2_2021,
    SUM(CASE WHEN `year` = 2021 AND quarter_num = 3 THEN total_laid_off ELSE 0 END) AS Q3_2021,
    SUM(CASE WHEN `year` = 2021 AND quarter_num = 4 THEN total_laid_off ELSE 0 END) AS Q4_2021,
    SUM(CASE WHEN `year` = 2022 AND quarter_num = 1 THEN total_laid_off ELSE 0 END) AS Q1_2022,
    SUM(CASE WHEN `year` = 2022 AND quarter_num = 2 THEN total_laid_off ELSE 0 END) AS Q2_2022,
    SUM(CASE WHEN `year` = 2022 AND quarter_num = 3 THEN total_laid_off ELSE 0 END) AS Q3_2022,
    SUM(CASE WHEN `year` = 2022 AND quarter_num = 4 THEN total_laid_off ELSE 0 END) AS Q4_2022,
    SUM(CASE WHEN `year` = 2023 AND quarter_num = 1 THEN total_laid_off ELSE 0 END) AS Q1_2023
FROM layoffs_staging2
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY Q2_2020 + Q3_2020 + Q4_2020
  + Q1_2021 + Q2_2021 + Q3_2021 + Q4_2021
  + Q1_2022 + Q2_2022 + Q3_2022 + Q4_2022
  + Q1_2023 DESC;
