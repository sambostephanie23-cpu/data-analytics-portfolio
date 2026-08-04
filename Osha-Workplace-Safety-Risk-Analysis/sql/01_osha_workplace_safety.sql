WITH company_level AS (
  SELECT
    company_name,
    establishment_name,
    state,
    naics_code,
    industry_description,
    size,
    AVG(annual_average_employees) AS avg_employees,

    SUM(total_injuries) AS total_injuries,
    SUM(total_deaths) AS total_deaths,
    SUM(total_dafw_cases) AS total_dafw_cases,
    SUM(total_djtr_cases) AS total_djtr_cases,
    SUM(total_other_cases) AS total_other_cases,

    SUM(total_dafw_days) AS total_dafw_days,
    SUM(total_djtr_days) AS total_djtr_days,

    SUM(total_injuries + total_deaths + total_dafw_cases + total_djtr_cases) AS total_cases

  FROM `osha.osha_data 2024-2025`
  GROUP BY
    company_name,
    establishment_name,
    state,
    naics_code,
    industry_description,
    size
),

risk_engine AS (
  SELECT
    *,

 
    (
      total_injuries
      + (total_deaths * 5)
      + (total_dafw_cases * 2)
      + (total_djtr_cases * 1.5)
      + ((total_dafw_days + total_djtr_days) * 0.01)
    ) AS risk_score

  FROM company_level
),

industry_benchmark AS (
  SELECT
    *,
    
    AVG(risk_score) OVER(PARTITION BY naics_code) AS industry_avg_risk,
    STDDEV(risk_score) OVER(PARTITION BY naics_code) AS industry_std_risk,

    AVG(total_injuries) OVER(PARTITION BY naics_code) AS industry_avg_injuries,
    AVG(total_deaths) OVER(PARTITION BY naics_code) AS industry_avg_deaths

  FROM risk_engine
),

final_output AS (
  SELECT
    *,

    ROUND(
      (risk_score / NULLIF(avg_employees, 0)) * 1000,
      2
    ) AS normalized_risk,

  
    ROUND(
      (total_injuries / NULLIF(avg_employees, 0)) * 1000,
      2
    ) AS injury_rate,

   
    ROUND(
      (total_deaths / NULLIF(avg_employees, 0)) * 1000,
      2
    ) AS fatality_rate,

    (total_dafw_cases + total_djtr_cases + (total_deaths * 5)) AS severity_load,
    (total_dafw_days + total_djtr_days) AS lost_time_index,

    SAFE_DIVIDE(
      risk_score - industry_avg_risk,
      NULLIF(industry_std_risk, 0)
    ) AS risk_z_score,

    CASE
      WHEN SAFE_DIVIDE(
        risk_score - industry_avg_risk,
        NULLIF(industry_std_risk, 0)
      ) >= 3 THEN 'CRITICAL OUTLIER'

      WHEN SAFE_DIVIDE(
        risk_score - industry_avg_risk,
        NULLIF(industry_std_risk, 0)
      ) >= 2 THEN 'HIGH RISK OUTLIER'

      WHEN SAFE_DIVIDE(
        risk_score - industry_avg_risk,
        NULLIF(industry_std_risk, 0)
      ) >= 1 THEN 'ABOVE AVERAGE RISK'

      ELSE 'NORMAL RISK'
    END AS risk_category

  FROM industry_benchmark
)

SELECT
  company_name,
  establishment_name,
  state,
  naics_code,
  industry_description,
  size,
  ROUND(avg_employees, 0) AS employees,

  total_injuries,
  total_deaths,
  total_dafw_cases,
  total_djtr_cases,

  ROUND(risk_score, 2) AS risk_score,
  normalized_risk,
  injury_rate,
  fatality_rate,
  severity_load,
  lost_time_index,

  ROUND(industry_avg_risk, 2) AS industry_avg_risk,
  ROUND(risk_z_score, 2) AS risk_z_score,
  risk_category

FROM final_output
ORDER BY normalized_risk DESC;