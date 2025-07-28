# SQLProject 
## Global Corporate Layoffs Dataset Cleaning in SQL

## Global Corporate Layoffs Analysis (2020–2025)
This repository contains a complete end-to-end SQL Server project to ingest, clean, and analyze a comprehensive dataset of corporate layoff events worldwide, spanning March 11, 2020 through May 15, 2025.

## Project Overview

### 1.	Data Ingestion & Staging
o	Loaded raw layoff records into a staging table (layoffs_staging) mirroring the original source schema.

o	Captured the following fields:

company, location, industry, total_laid_off, percentage_laid_off,
date, stage, country, funds_raised

### 2.	Data Cleaning & Normalization

o	Duplicate Removal

	Used a ROW_NUMBER() window function over all key columns to detect and delete duplicate rows.
o	Schema Refinement

	Created a final staging table (layoffs_staging2) with appropriate data types:

	Converted date from text → SQL DATE.

	Cast numeric fields (total_laid_off, funds_raised) to INT.

	Standardized percentage field to allow numeric averages.

o	Standardization of Text Fields

	Trimmed whitespace from company, location, and country.

	Unified industry labels (e.g. all “Crypto*” → Crypto).

	Removed trailing punctuation in country names (e.g. United States. → United States).

o	Handling Missing Values

	Identified rows with both total_laid_off and percentage_laid_off NULL—deleted these as non-informative.

	Imputed industry labels for rows where industry was missing but could be inferred from another record for the same company + location.

### 3.	Exploratory Data Analysis (EDA)

o	Global Layoff Totals

	Ranked companies by cumulative layoffs and found the top contributors to workforce reductions.

o	Temporal Trends

	Verified the earliest and latest layoff dates to ensure the full 2020–2025 window was covered.

	Computed monthly totals and plotted a rolling sum to visualize the pandemic’s waves and subsequent recovery periods.

	Identified the years and calendar months with peak layoff volumes.

o	Industry & Regional Impact

	Aggregated layoffs by industry to highlight the sectors hardest hit (e.g. Technology, Finance, Crypto).

	Summarized by country to reveal geographic hotspots of workforce cuts.

o	Company Stage Analysis

	Compared total layoffs across private, venture-backed, and public companies to understand risk profiles.

o	Percentage-Based Insights

	Calculated average layoff percentages per company to detect organizations with particularly deep cuts relative to size.






