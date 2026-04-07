
SELECT
  EXTRACT(YEAR FROM committer.date) AS year,
  EXTRACT(MONTH FROM committer.date) AS month,
  FORMAT_TIMESTAMP('%B', committer.date) AS month_name,
  EXTRACT(DAYOFWEEK FROM committer.date) AS day_of_week,
  FORMAT_TIMESTAMP('%A', committer.date) AS day_name,
  EXTRACT(HOUR FROM committer.date) AS hour,
  COUNT(*) AS commit_count
FROM `bigquery-public-data`.`github_repos`.`sample_commits`
GROUP BY ALL
