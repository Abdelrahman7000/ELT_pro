WITH cte_country AS (
select
    nationality,
    en_short_name AS country    
from
    {{ source('staging','countries') }}
)


select
    CASE 
    -- reduces confusion with demonyms from the table
        WHEN nationality LIKE '%Chinese%' THEN 'China'
        WHEN nationality LIKE '%American%' THEN 'United States of America'
        WHEN nationality LIKE '%African%' THEN 'Africa'
        ELSE country
    END AS country,
    
    CASE 
        WHEN nationality='Indian' THEN nationality||', North Indian'
        ELSE nationality
    END AS nationality
from
    cte_country