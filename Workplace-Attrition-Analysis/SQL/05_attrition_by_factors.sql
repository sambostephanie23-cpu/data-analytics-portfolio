CREATE OR REPLACE VIEW
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.attrition_by_factors`
AS

-- Overtime
SELECT
  'Overtime' AS factor,
  CAST(Overtime AS STRING) AS category,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY Overtime

UNION ALL

-- Job Satisfaction
SELECT
  'Job Satisfaction' AS factor,
  CAST(`Job Satisfaction` AS STRING) AS category,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY `Job Satisfaction`

UNION ALL

-- Work-Life Balance
SELECT
  'Work-Life Balance' AS factor,
  CAST(`Work-Life Balance` AS STRING) AS category,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY `Work-Life Balance`

UNION ALL

-- Remote Work
SELECT
  'Remote Work' AS factor,
  CAST(`Remote Work` AS STRING) AS category,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY `Remote Work`

UNION ALL

-- Leadership Opportunities
SELECT
  'Leadership Opportunities' AS factor,
  CAST(`Leadership Opportunities` AS STRING) AS category,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY `Leadership Opportunities`;
