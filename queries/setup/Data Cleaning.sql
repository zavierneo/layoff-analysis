-- Data Cleaning 

-- 1. Remove Duplicates 
-- 2. Standardise the data
-- 3. Null Values or blank values
-- 4. Remove rows and columns

/*
CREATE TABLE layoffs_staging
LIKE layoffs;
*/

/*
INSERT layoffs_staging
SELECT * 
FROM layoffs;
*/


-- Searching for duplicates
WITH duplicate_cte AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte 
WHERE row_num > 1;


-- Creating staging_2 to delete duplicates 
CREATE TABLE `layoffs_staging2` (
  `company` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` decimal(4,2) DEFAULT NULL,
  `date` text,
  `stage` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
;*/

DELETE
FROM layoffs_staging2
WHERE row_num > 1
;

-- All duplicate data deleted 

-- Standardising data
SELECT company, TRIM(company)
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry 
FROM layoffs_staging2
ORDER BY industry;
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY country;
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

SELECT `date`
FROM layoffs_staging2;
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Populating Null and Blanks values 
-- Can only populate data for industries as there's insufficient data from dataset to populate other null datas 
UPDATE layoffs_staging2 			-- Standardising all blanks to NULL 
SET industry = NULL 
WHERE industry = '';

SELECT *							-- Look for whether there are unpopulated industries
FROM layoffs_staging2
WHERE industry IS NULL;

SELECT t1.industry, t2.industry 
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2 
	ON t1.company = t2.company 
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2 
	ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * 							-- 'Bally's Interactive' was not populated
FROM layoffs_staging2
WHERE company LIKE 'Bally%';		-- Cannot be populated as there are no other details 


-- Deleting rows with key missing information

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- Adding quarter and years into layoffs_staging2
-- Adding column
ALTER TABLE layoffs_staging2
ADD COLUMN quarter_num INT,
ADD COLUMN `year` INT;

-- Populating column
UPDATE layoffs_staging2
SET quarter_num = QUARTER(`date`),
	`year` = YEAR(`date`);
