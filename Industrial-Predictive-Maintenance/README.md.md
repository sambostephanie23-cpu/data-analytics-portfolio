# Equipment Failure & Predictive Maintenance Analysis

## Overview

This project analyzes industrial equipment sensor data to identify equipment failure patterns, monitor machine wear, assess operating conditions, and classify equipment into maintenance risk levels.

The analysis uses SQL to transform raw equipment readings into machine-level maintenance indicators that can support predictive maintenance planning and help prioritize equipment for inspection.

## Business Objective

Unplanned equipment failures can lead to production downtime, maintenance costs, and operational disruption.

This analysis aims to identify early warning indicators of equipment failure and provide a risk-based approach to maintenance prioritization.

## Key Questions

- Which machines show the highest levels of tool wear?
- Which machines have the highest number of confirmed failures?
- How are failure types distributed across product types (H, M, and L)?
- What are the average operating conditions for different machine profiles?
- Which machines should receive higher maintenance priority?
- How can equipment be classified into low, medium, and high-risk categories?

## Tools & Platform

- SQL
- Google BigQuery
- Git
- GitHub

## Dataset

**Dataset:** Equipment Downtime Failure Analysis (EDFA)

**Size:** ~10,000 rows | 18 columns

The dataset contains equipment operating measurements and failure information, including:

- Air temperature
- Process temperature
- Rotational speed (RPM)
- Torque
- Tool wear
- Product type
- Failure type

## SQL Techniques Used

| SQL Technique | Purpose |
|---|---|
| CTEs (`WITH`) | Build a structured multi-stage analysis pipeline |
| Data filtering | Remove or handle invalid and missing records |
| `MAX()` | Identify maximum tool-wear readings |
| `AVG()` | Profile average operating conditions |
| `SUM()` | Calculate cumulative tool wear |
| `COUNTIF()` | Count confirmed equipment failures |
| `CASE WHEN` | Classify equipment into risk categories |
| `GROUP BY` | Aggregate machine and product-level metrics |
| Risk scoring | Combine equipment indicators into a maintenance risk score |

## Analysis Pipeline

```text
Raw Equipment Data
        ↓
Clean Data
        ↓
Machine Profile
        ↓
Failure Analysis
        ↓
Risk Scoring
        ↓
Risk Classification
        ↓
Final Maintenance Analysis