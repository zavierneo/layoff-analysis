CREATE TABLE layoffs (
company VARCHAR(255),
location VARCHAR(255),
industry VARCHAR(255),
total_laid_off int,
percentage_laid_off decimal(4,2),
date text,
stage VARCHAR(255),
country VARCHAR(255),
funds_raised_millions int
);


SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/zav/Downloads/layoffs.csv' 
INTO TABLE layoffs FIELDS
TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM layoffs;