CREATE OR REPLACE VIEW
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.attrition_by_role`
AS

SELECT
  `Job Role` AS job_role,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  COUNTIF(Attrition = 'Stayed') AS employees_stayed,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate,

  ROUND(AVG(`Monthly Income`), 2) AS average_monthly_income,

  ROUND(AVG(`Years at Company`), 1) AS average_years_at_company

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY `Job Role`

ORDER BY attrition_rate DESC;
