
WITH primary_lang AS (
  SELECT
    repo_name,
    l.name AS primary_language, 
    ROW_NUMBER() OVER (
      PARTITION BY repo_name 
      ORDER BY l.bytes DESC
    ) AS rn
  FROM `bigquery-public-data.github_repos.languages`,
    UNNEST(language) AS l
  QUALIFY rn IN (1, 2, 3) 
)

SELECT
  EXTRACT(YEAR FROM c.committer.date) AS year,
  l.primary_language AS language,
  COUNT(c.repo_name) AS total_commits
FROM `bigquery-public-data.github_repos.sample_commits` AS c
INNER JOIN primary_lang AS l
  ON c.repo_name = l.repo_name
GROUP BY ALL
