CREATE OR REPLACE VIEW
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.attrition_by_tenure`
AS

SELECT

  CASE
    WHEN `Years at Company` < 2 THEN '0–1 Years'

    WHEN `Years at Company` < 5 THEN '2–4 Years'

    WHEN `Years at Company` < 10 THEN '5–9 Years'

    ELSE '10+ Years'
  END AS tenure_group,

  COUNT(*) AS total_employees,

  COUNTIF(Attrition = 'Left') AS employees_left,

  COUNTIF(Attrition = 'Stayed') AS employees_stayed,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(Attrition = 'Left'),
      COUNT(*)
    ) * 100,
    2
  ) AS attrition_rate

FROM
`upbeat-button-484609-e9.Workforce_Retention_Attrition_Analysis.Workforce_Analysis_Cleaned`

GROUP BY tenure_group

ORDER BY
  CASE tenure_group
    WHEN '0–1 Years' THEN 1
    WHEN '2–4 Years' THEN 2
    WHEN '5–9 Years' THEN 3
    WHEN '10+ Years' THEN 4
  END;
