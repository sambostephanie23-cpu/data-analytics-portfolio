CREATE OR REPLACE TABLE `environmental-esg.oil.oil_spill_cleaned` AS

WITH cleaned AS (

SELECT


    NULLIF(TRIM(id), '') AS id,

    CASE
        WHEN company IS NULL
          OR TRIM(company) = ''
          OR LOWER(TRIM(company)) IN
             ('nan', 'null', 'none', 'undefined', 'unknown')
            THEN 'Unknown'

        WHEN REGEXP_CONTAINS(TRIM(company), r'^[0-9.]+$')
            THEN 'Unknown'

        WHEN REGEXP_CONTAINS(
            TRIM(company),
            r'^\d{4}[-/]\d{1,2}[-/]\d{1,2}$'
        )
            THEN 'Unknown'

        ELSE UPPER(TRIM(company))
    END AS company,

    NULLIF(LOWER(TRIM(status)), '') AS status,

    NULLIF(TRIM(incidentnumber), '') AS incident_number,



    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(incidentdate), '')
    ) AS incident_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(reportdate), '')
    ) AS report_date,


    

    NULLIF(TRIM(contaminant), '') AS contaminant,


    CASE

        WHEN LOWER(TRIM(estimatedquantity))
            IN (
                '',
                'nan',
                'null',
                'none',
                'infinity',
                '+infinity',
                '-infinity'
            )
            THEN NULL

        WHEN SAFE_CAST(
            TRIM(estimatedquantity) AS FLOAT64
        ) IS NULL
            THEN NULL

        WHEN SAFE_CAST(
            TRIM(estimatedquantity) AS FLOAT64
        ) < 0
            THEN NULL

    
        WHEN SAFE_CAST(
            TRIM(estimatedquantity) AS FLOAT64
        ) > 100000

        AND (company IS NULL OR TRIM(company) = '')
        AND (incidentnumber IS NULL OR TRIM(incidentnumber) = '')
        AND (incidentdate IS NULL OR TRIM(incidentdate) = '')
        AND (statesaffected IS NULL OR TRIM(statesaffected) = '')
        AND (sitelocationname IS NULL OR TRIM(sitelocationname) = '')

            THEN NULL

        ELSE SAFE_CAST(
            TRIM(estimatedquantity) AS FLOAT64
        )

    END AS estimated_quantity,


    CASE

        WHEN LOWER(TRIM(quantityrecovered))
            IN (
                '',
                'nan',
                'null',
                'none',
                'infinity',
                '+infinity',
                '-infinity'
            )
            THEN NULL

        WHEN SAFE_CAST(
            TRIM(quantityrecovered) AS FLOAT64
        ) IS NULL
            THEN NULL

        WHEN SAFE_CAST(
            TRIM(quantityrecovered) AS FLOAT64
        ) < 0
            THEN NULL

        ELSE SAFE_CAST(
            TRIM(quantityrecovered) AS FLOAT64
        )

    END AS quantity_recovered,


  
    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(spillstopdate), '')
    ) AS spill_stop_date,


    NULLIF(
        INITCAP(TRIM(typeoffacility)),
        ''
    ) AS facility_type,


    CASE

        WHEN cause IS NULL
          OR TRIM(cause) = ''
            THEN 'Unknown'

        WHEN LOWER(TRIM(cause)) LIKE '%sabotage%'
            THEN 'Sabotage'

        WHEN LOWER(TRIM(cause)) LIKE '%equipment failure%'
            THEN 'Equipment Failure'

        WHEN LOWER(TRIM(cause)) LIKE '%corrosion%'
            THEN 'Corrosion'

        WHEN LOWER(TRIM(cause)) = 'ome'
            THEN 'Operational / Maintenance Error'

        WHEN LOWER(TRIM(cause)) = 'ytd'
            THEN 'Under Investigation'

        WHEN LOWER(TRIM(cause)) LIKE 'other%'
            THEN 'Other'

        WHEN REGEXP_CONTAINS(
            TRIM(cause),
            r'^[0-9.]+$'
        )
            THEN 'Unknown'

        WHEN LOWER(TRIM(cause)) IN ('sw', 'la')
            THEN 'Other'

        ELSE INITCAP(TRIM(cause))

    END AS cause,



    NULLIF(
        TRIM(initialcontainmentmeasures),
        ''
    ) AS initial_containment_measures,


    NULLIF(
        TRIM(sitelocationname),
        ''
    ) AS site_location,

    CASE
        WHEN LOWER(TRIM(latitude))
            IN (
                '',
                'nan',
                'null',
                'none',
                'infinity',
                '+infinity',
                '-infinity'
            )
            THEN NULL

        ELSE SAFE_CAST(
            TRIM(latitude) AS FLOAT64
        )
    END AS latitude,

    CASE
        WHEN LOWER(TRIM(longitude))
            IN (
                '',
                'nan',
                'null',
                'none',
                'infinity',
                '+infinity',
                '-infinity'
            )
            THEN NULL

        ELSE SAFE_CAST(
            TRIM(longitude) AS FLOAT64
        )
    END AS longitude,

    NULLIF(
        INITCAP(TRIM(lga)),
        ''
    ) AS lga,


    CASE

        WHEN statesaffected IS NULL
          OR TRIM(statesaffected) = ''
          OR LOWER(TRIM(statesaffected))
             IN ('undefined', 'unknown', 'null', 'nan')
            THEN NULL

        WHEN LOWER(TRIM(statesaffected)) = 'ab'
            THEN 'Abia'

        WHEN LOWER(TRIM(statesaffected)) = 'ak'
            THEN 'Akwa Ibom'

        WHEN LOWER(TRIM(statesaffected)) = 'an'
            THEN 'Anambra'

        WHEN LOWER(TRIM(statesaffected)) = 'ba'
            THEN 'Bauchi'

        WHEN LOWER(TRIM(statesaffected)) = 'by'
            THEN 'Bayelsa'

        WHEN LOWER(TRIM(statesaffected)) = 'be'
            THEN 'Benue'

        WHEN LOWER(TRIM(statesaffected)) = 'bo'
            THEN 'Borno'

        WHEN LOWER(TRIM(statesaffected)) = 'cr'
            THEN 'Cross River'

        WHEN LOWER(TRIM(statesaffected)) = 'de'
            THEN 'Delta'

        WHEN LOWER(TRIM(statesaffected)) = 'eb'
            THEN 'Ebonyi'

        WHEN LOWER(TRIM(statesaffected)) = 'ed'
            THEN 'Edo'

        WHEN LOWER(TRIM(statesaffected)) = 'ek'
            THEN 'Ekiti'

        WHEN LOWER(TRIM(statesaffected)) = 'en'
            THEN 'Enugu'

        WHEN LOWER(TRIM(statesaffected))
             IN ('fc', 'fct')
            THEN 'Federal Capital Territory'

        WHEN LOWER(TRIM(statesaffected)) = 'go'
            THEN 'Gombe'

        WHEN LOWER(TRIM(statesaffected)) = 'im'
            THEN 'Imo'

        WHEN LOWER(TRIM(statesaffected)) = 'ji'
            THEN 'Jigawa'

        WHEN LOWER(TRIM(statesaffected)) = 'kd'
            THEN 'Kaduna'

        WHEN LOWER(TRIM(statesaffected)) = 'kn'
            THEN 'Kano'

        WHEN LOWER(TRIM(statesaffected)) = 'kt'
            THEN 'Katsina'

        WHEN LOWER(TRIM(statesaffected)) = 'ke'
            THEN 'Kebbi'

        WHEN LOWER(TRIM(statesaffected)) = 'ko'
            THEN 'Kogi'

        WHEN LOWER(TRIM(statesaffected)) = 'kw'
            THEN 'Kwara'

        WHEN LOWER(TRIM(statesaffected)) = 'la'
            THEN 'Lagos'

        WHEN LOWER(TRIM(statesaffected)) = 'na'
            THEN 'Nasarawa'

        WHEN LOWER(TRIM(statesaffected)) = 'ni'
            THEN 'Niger'

        WHEN LOWER(TRIM(statesaffected)) = 'og'
            THEN 'Ogun'

        WHEN LOWER(TRIM(statesaffected)) = 'on'
            THEN 'Ondo'

        WHEN LOWER(TRIM(statesaffected)) = 'os'
            THEN 'Osun'

        WHEN LOWER(TRIM(statesaffected)) = 'oy'
            THEN 'Oyo'

        WHEN LOWER(TRIM(statesaffected)) = 'pl'
            THEN 'Plateau'

        WHEN LOWER(TRIM(statesaffected)) = 'ri'
            THEN 'Rivers'

        WHEN LOWER(TRIM(statesaffected)) = 'so'
            THEN 'Sokoto'

        WHEN LOWER(TRIM(statesaffected)) = 'ta'
            THEN 'Taraba'

        WHEN LOWER(TRIM(statesaffected)) = 'yo'
            THEN 'Yobe'

        WHEN LOWER(TRIM(statesaffected)) = 'za'
            THEN 'Zamfara'

        WHEN LOWER(TRIM(statesaffected))
             IN ('gusau', 'gusua')
            THEN 'Zamfara'

        WHEN LOWER(TRIM(statesaffected))
             = 'kaduna-north'
            THEN 'Kaduna'

        WHEN REGEXP_CONTAINS(
            statesaffected,
            r','
        )
            THEN NULL

        WHEN REGEXP_CONTAINS(
            TRIM(statesaffected),
            r'^\d'
        )
            THEN NULL

        ELSE INITCAP(
            TRIM(statesaffected)
        )

    END AS state,


    NULLIF(
        INITCAP(TRIM(zonaloffice)),
        ''
    ) AS zonal_office,



    NULLIF(
        INITCAP(TRIM(spillareahabitat)),
        ''
    ) AS spill_area_habitat,

    CASE

        WHEN LOWER(TRIM(estimatedspillarea))
            IN (
                '',
                'nan',
                'null',
                'none',
                'infinity',
                '+infinity',
                '-infinity'
            )
            THEN NULL

        WHEN SAFE_CAST(
            TRIM(estimatedspillarea) AS FLOAT64
        ) < 0
            THEN NULL

        ELSE SAFE_CAST(
            TRIM(estimatedspillarea) AS FLOAT64
        )

    END AS estimated_spill_area,

    NULLIF(
        TRIM(descriptionofimpact),
        ''
    ) AS description_of_impact,


    NULLIF(
        LOWER(TRIM(jivpresent)),
        ''
    ) AS jiv_present,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(jivdate), '')
    ) AS jiv_date,


    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(cleanupdate), '')
    ) AS cleanup_date,

    NULLIF(
        INITCAP(TRIM(cleanupmethods)),
        ''
    ) AS cleanup_methods,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(cleanupcompleteddate), '')
    ) AS cleanup_completed_date,


    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(remediationstart), '')
    ) AS remediation_start,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(remediationend), '')
    ) AS remediation_end,

    NULLIF(
        INITCAP(TRIM(remediationtype)),
        ''
    ) AS remediation_type,


    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(postcleanupinspectiondate), '')
    ) AS post_cleanup_inspection_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(postimpactassessmentdate), '')
    ) AS post_impact_assessment_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(finalsamplingdate), '')
    ) AS final_sampling_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(finallabresultsdate), '')
    ) AS final_lab_results_date,


    NULLIF(
        TRIM(certificatenumber),
        ''
    ) AS certificate_number,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(certificatedate), '')
    ) AS certificate_date,



    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(formadate), '')
    ) AS form_a_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(formbdate), '')
    ) AS form_b_date,

    SAFE.PARSE_DATE(
        '%Y-%m-%d',
        NULLIF(TRIM(formcdate), '')
    ) AS form_c_date,



    updatefor AS update_for,

    NULLIF(
        TRIM(attachments),
        ''
    ) AS attachments,

    NULLIF(
        TRIM(lastupdatedby),
        ''
    ) AS last_updated_by

FROM `environmental-esg.oil.oil_spill_analyis`
)


SELECT
    *,
    
    CASE
        WHEN estimated_quantity IS NULL
            THEN 'Unknown'

        WHEN estimated_quantity < 1
            THEN 'Low'

        WHEN estimated_quantity < 10
            THEN 'Moderate'

        WHEN estimated_quantity < 100
            THEN 'High'

        ELSE 'Critical'
    END AS severity

FROM cleaned;