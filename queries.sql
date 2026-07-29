-- ============================================================================
-- Google Play Store Market Analysis — SQL Queries
-- Run against the `apps` table (loaded from data/cleaned_googleplaystore.csv)
-- Schema (relevant columns): App, Category, Rating, Reviews, Installs,
--                             Type, Price, Size_MB, Content Rating, Last Updated
-- ============================================================================

-- 1. Number of apps per category
SELECT Category, COUNT(*) AS num_apps
FROM apps
GROUP BY Category
ORDER BY num_apps DESC
LIMIT 10;

-- 2. Highest-rated categories (minimum 30 apps, to avoid small-sample noise)
SELECT Category,
       ROUND(AVG(Rating), 2) AS avg_rating,
       COUNT(*) AS num_apps
FROM apps
WHERE Rating IS NOT NULL
GROUP BY Category
HAVING COUNT(*) >= 30
ORDER BY avg_rating DESC
LIMIT 10;

-- 3. Top 10 most-installed apps
SELECT App, Category, Installs, Rating
FROM apps
ORDER BY Installs DESC
LIMIT 10;

-- 4. Free vs. Paid: average rating, reviews, and installs
SELECT Type,
       ROUND(AVG(Rating), 2)   AS avg_rating,
       ROUND(AVG(Reviews), 0)  AS avg_reviews,
       ROUND(AVG(Installs), 0) AS avg_installs
FROM apps
GROUP BY Type;

-- 5. Categories with the largest total install footprint
SELECT Category, SUM(Installs) AS total_installs
FROM apps
GROUP BY Category
ORDER BY total_installs DESC
LIMIT 10;

-- 6. (Bonus) Most expensive paid apps
SELECT App, Category, Price, Installs, Rating
FROM apps
WHERE Type = 'Paid'
ORDER BY Price DESC
LIMIT 10;

-- 7. (Bonus) Content rating breakdown by average app rating
SELECT "Content Rating", COUNT(*) AS num_apps, ROUND(AVG(Rating), 2) AS avg_rating
FROM apps
GROUP BY "Content Rating"
ORDER BY num_apps DESC;
