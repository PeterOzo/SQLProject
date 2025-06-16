-- Exploratory Data Analysis on company layoffs in world from: 2020-03-11 to 2025-05-15

SELECT *
FROM layoffs_staging2;


SELECT  DISTINCT(company), total_laid_off
FROM layoffs_staging2
GROUP BY total_laid_off, company
ORDER BY total_laid_off DESC, company DESC;



SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;



SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

-- Check Date

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;


-- Check the industry  - what industry was hit the most doing this layoffs

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;


SELECT *
FROM layoffs_staging2;


-- Check the country that was hit so hard doing this layoff

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC;


-- Check the year that has the most layoff hit

SELECT Year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Year(`date`)
ORDER BY SUM(total_laid_off) DESC;


-- Check `date`  time of the year that has the most layoff hit (you may do time series) 


SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY SUM(total_laid_off) DESC;


-- Check the stage of the company


SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY SUM(total_laid_off) DESC;


-- Check average percentage layoffs

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY AVG(percentage_laid_off) DESC;


-- Check the procession of layoffs - a rolling sum 

SELECT *
FROM layoffs_staging2;


SELECT DISTINCT(company) as distinct_company , SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`, distinct_company
ORDER BY `MONTH` ASC, distinct_company ASC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH` ASC;


-- Do a rolling sum -- we will do a CTE

SELECT *
FROM layoffs_staging2;

WITH Rolling_Total_cte as
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH` ASC
)
SELECT `MONTH`,total_off
,SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total # sum of layoffs for month to monthe progression
FROM Rolling_Total_cte;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;


SELECT company, Year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, Year(`date`)
ORDER BY SUM(total_laid_off) DESC;

-- Check which compnay laidoff the most people per year

WITH Company_Year_cte (compay, years, total_laid_off) AS 
(
SELECT company, Year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, Year(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year_cte
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking<= 5
;



