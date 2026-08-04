with clean_data as (
  select UDI, `Product ID`, Type, `Air temperature _K_`, `Process temperature _K_`, `Rotational speed _rpm_`, `Torque _Nm_`, `Target`, `Failure Type`,`Tool wear _min_`
  from `predictive-maintenance-495204.Equipment_Downtime_Failure_Analysis.edfa`
  where Type is not null
  and `Target` is not null
  and `Failure Type` is not null
  and `Tool wear _min_` is not null
),

machine_profile as (
  select `Product ID`,
  max(`Tool wear _min_`) as highest_wear_machine,
  avg (`Air temperature _K_`) as avg_air_Temp,
  avg(`Process temperature _K_`) as avg_process_temp,
  avg(`Rotational speed _rpm_`) as avg_rotational_speed,
  sum(`Tool wear _min_`) as total_tool_wear,
  avg(`Torque _Nm_`) as avg_torque
from clean_data
group by `Product ID`
),

failure_analysis as (
  select Type,
  sum(`Target`) as total_failures,
  countif(`Failure Type`= 'No Failure') as confirmed_failures,
  count(*) as total_records
 from clean_data
 group by Type
),

risk_segmentation as (
  select   
    `Product ID`,
    Type,
    `Failure Type`,
    `Torque _Nm_`,
    `Tool wear _min_`,
    `Air temperature _K_`,
    `Process temperature _K_`,
    `Rotational speed _rpm_`,

    (
      case when `Air temperature _K_` > 305 then 1 else 0 end +
      case when `Process temperature _K_` > 315 then 1 else 0 end +
      case when `Torque _Nm_` > 50 then 1 else 0 end +
      case when `Tool wear _min_` > 150 then 1 else 0 end +
      case when `Rotational speed _rpm_` > 1600 then 1 else 0 end
    ) as risk_score,

    case 
      when `Target` = 1 and lower(`Failure Type`) != 'no failure' 
        then 'Critical Failure'

      when (
        case when `Air temperature _K_` > 305 then 1 else 0 end +
        case when `Process temperature _K_` > 315 then 1 else 0 end +
        case when `Torque _Nm_` > 50 then 1 else 0 end +
        case when `Tool wear _min_` > 150 then 1 else 0 end +
        case when `Rotational speed _rpm_` > 1600 then 1 else 0 end
      ) >= 3 
        then 'High Risk'

      when (
        case when `Air temperature _K_` > 305 then 1 else 0 end +
        case when `Torque _Nm_` > 50 then 1 else 0 end +
        case when `Tool wear _min_` > 150 then 1 else 0 end
      ) = 2
        then 'Medium Risk'

      else 'Low Risk'
    end as risk_classification
  from clean_data
)

select 
  risk_segmentation.*,
  -- Instead of machine_profile.*, we select everything EXCEPT the duplicate Product ID
  machine_profile.highest_wear_machine,
  machine_profile.avg_air_Temp,
  machine_profile.avg_process_temp,
  machine_profile.avg_rotational_speed,
  machine_profile.total_tool_wear,
  machine_profile.avg_torque,
  rank () over (partition by risk_segmentation.`Failure Type` order by risk_segmentation.`Product ID` desc) as highest_failure_per_product_id,
  rank () over (partition by risk_segmentation.Type order by risk_segmentation.`Product ID` desc) as worst_machine_types
from risk_segmentation
join machine_profile
on risk_segmentation.`Product ID` = machine_profile.`Product ID`