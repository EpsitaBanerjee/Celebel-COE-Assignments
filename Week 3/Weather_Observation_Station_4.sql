SELECT 
    (SELECT COUNT(*) FROM STATION) AS total_records,
    (SELECT COUNT(DISTINCT city) FROM STATION) AS unique_cities,
    (SELECT COUNT(*) - COUNT(DISTINCT city) FROM STATION) AS difference;