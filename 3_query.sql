/*
question what are the most in demand skills for data analysts?
- join job postings to inner join table similar to query 2 
- identify the top 5 in demand skills for a data analyst.
- focus on all job postings
- Why? retrives the top 5 skills with the highest demand in the job marker,
providing insights into to the most valuable skills for job seekers.
*/


SELECT 
    skills,
    count(skills_job_dim.job_id) AS demand_count
FROM 
job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5 ;

/*
SQL tops the list since it’s essential for querying databases and extracting data for analysis.
Excel remains popular because many companies still rely on it for quick analysis and reporting.
Python is increasingly required for automation, data cleaning, and statistical analysis.
Tableau and Power BI are sought-after for building interactive dashboards and visualizing insights
*/