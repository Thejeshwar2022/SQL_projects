# INTRODUCTION
📊 Dive into the data job market! Focusing on data analyst roles, this project explores & top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
# BACKGROUND
💎Driven by a quest to navigate the data analyst job market nore effectively, this project was born from a desire to pinpoint top-paid and in-denand skills, streamlining others work to find optinal jobs.
### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I Used
🏹For my deep dive into the data analyst job market, I harnessed the power of several key tools:
- **SQL** : The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL** : The chosen database management systes, ideal for handling the job posting data.
- **Visual Studio Code** : My go-to for database management and executing SQL queries.
- **Git & Gitihub** : Essential for version control and sharing my SOL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis 
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1.Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs.This query highlights the high paying opportunitites in the field.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE
    job_title = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
- High salary range: The top remote Data Analyst roles offer very competitive average yearly salaries, showing strong demand for data skills.
- Remote flexibility: All listed positions being “Anywhere” suggests companies are increasingly open to remote analysts, highlighting global hiring trends.
- Top employers: The results likely feature well-known tech or data-driven companies that are willing to pay more for analytical talent.
- Recent postings: Many high-paying jobs are recently posted, indicating a steady and growing demand for remote data analysts in the job market.
### 2.Skills for top paying jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
        WHERE
        job_title = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
- Top 2 must-have skills: Python + SQL
- Visualization tools (Tableau, Looker, Power BI) appear in ~20% of listings, showing their importance in presenting insights.
- Excel remains relevant, especially for entry-level and business-focused roles.
- Cloud & advanced analytics skills (AWS, SAS) add extra value but are not mandatory in most postings.
### 3.In-demand skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
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
```
- SQL tops the list since it’s essential for querying databases and extracting data for analysis.
- Excel remains popular because many companies still rely on it for quick analysis and reporting.
- Python is increasingly required for automation, data cleaning, and statistical analysis.
- Tableau and Power BI are sought-after for building interactive dashboards and visualizing insights.
### 4.Skill based on the salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT
    skills,
    round(avg(salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg is not null
    --AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY    
   avg_salary DESC
LIMIT 25;
```
- Skills like Python and R consistently appear at the top.
- SQL remains the universal requirement.
- Visualization tools Tableau, Power BI, and Looker bring business value.
### 5.Skills based on the salary
Combinin insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and offering a strategic focus for skill development.
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) AS demand_count,
    Round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg is NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING 
    count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
- Python and R remain at the top — analysts who can code in these languages earn significantly higher than average because they can automate analysis, perform advanced statistics, and build data-driven applications.
- SQL stays essential as a base skill; while not the highest paying alone, every top-paying role still lists it, since data retrieval and transformation form the foundation of analysis.
- Cloud-based tools such as AWS, Azure, Google BigQuery, Databricks, and Snowflake appear frequently. These indicate a shift to cloud-native data workflows — remote analysts who know how to manage and analyze large datasets in these environments earn a salary premium.
# What I learned
Data Extraction & Joins
Learned how to combine data from multiple tables using INNER JOIN and LEFT JOIN to create complete, meaningful datasets.
Gained experience in working with fact and dimension tables (e.g., job_postings_fact, skills_dim, company_dim).
🔍 Data Filtering & Query Optimization
- Used WHERE, GROUP BY, HAVING, and ORDER BY clauses to filter and rank data efficiently.
- Applied logical conditions to extract specific job insights (like highest-paying Data Analyst jobs or most in-demand skills).

📊 Analytical Thinking Using SQL
- Designed analytical queries to measure skill demand, average salaries, and remote job trends.
- Demonstrated the ability to convert raw data into actionable insights, like identifying top-paying skills or in-demand tools for Data Analysts.

💡 Use of Aggregation & Functions
- Learned how to use SQL functions like COUNT(), AVG(), and ROUND() to summarize and analyze data effectively.
- Understood the importance of data aggregation in finding patterns and insights.

🧠 Insight Generation for Decision-Making
- Developed the ability to interpret query results and provide practical insights about job market trends.
- Learned how to explain the results in business terms, bridging the gap between technical output and business understanding.

⚙️ Data Cleaning and Validation
- Applied conditions like salary_year_avg IS NOT NULL and HAVING count(job_id) > 10 to ensure data accuracy and reliability.
- Learned to exclude incomplete or irrelevant data for better insights.

🌍 Exploring Real-World Scenarios
- Simulated real-world data analysis tasks, such as identifying top remote jobs, salary trends, and high-demand skills.
- Improved understanding of job market analytics using SQL-based data exploration.

📈 End-to-End Analytical Workflow
- Built an end-to-end pipeline: from data extraction → cleaning → analysis → insight generation.
- Practiced presenting findings in a structured and data-driven manner, similar to real analytics projects.

# Conclusion
Through this project, I gained a deeper understanding of how SQL can be used to extract, analyze, and interpret large datasets to uncover meaningful business insights. By analyzing job postings for Data Analyst roles, I identified the most valuable and highest-paying skills, as well as the growing importance of remote-friendly analytical roles in today’s market.
This project not only strengthened my SQL querying and data analysis skills but also improved my ability to connect technical results with real-world trends — a key skill for any aspiring Data Analyst. It demonstrated how data-driven insights can help professionals and organizations make informed, evidence-based decisions about skill development and hiring strategies.
