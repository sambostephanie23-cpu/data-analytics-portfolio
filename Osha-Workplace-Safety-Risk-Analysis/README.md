# OSHA Workplace Safety Risk Analysis (2024–2025)

## Overview

This project analyzes U.S. workplace safety data from OSHA to identify establishments with elevated injury, fatality, and severity risks.

Using SQL in Google BigQuery, the analysis aggregates workplace safety indicators, benchmarks establishments against their industry averages, calculates statistical risk deviation, and classifies establishments into risk categories.

The goal is to identify high-risk workplaces and industries that may require greater attention from a workplace safety and risk-management perspective.

## Business Objective

Workplace injury counts alone do not always provide a complete picture of safety risk.

This analysis combines multiple safety indicators to evaluate establishment-level risk and identify workplaces whose safety performance deviates significantly from their industry benchmarks.

## Key Questions

- Which establishments have the highest injury and fatality rates?
- Which companies have the highest severity burden?
- How does each establishment's risk compare with its industry average?
- Which establishments are statistical outliers?
- Which industries have the highest cumulative safety risk?
- Which establishments should receive the highest risk priority?

## Tools & Platform

- SQL
- Google BigQuery
- Git
- GitHub

## Dataset

**Dataset:** OSHA Data 2024–2025

**Size:** ~398,158 rows | 20 columns

The dataset contains workplace injury and illness information used to evaluate establishment-level safety performance.

## Analysis Framework

The analysis follows a multi-stage SQL pipeline:

```text
OSHA Incident Data
        ↓
Company-Level Aggregation
        ↓
Risk Score Calculation
        ↓
Industry Benchmarking
        ↓
Risk Normalization
        ↓
Z-Score Calculation
        ↓
Risk Classification
        ↓
Establishment Ranking
