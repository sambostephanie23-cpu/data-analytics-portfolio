# U.S. Airline & Airport Traffic Performance — 2025

## Project Overview

This project analyzes U.S. airline and airport traffic activity throughout 2025 using aviation transportation data from the U.S. Bureau of Transportation Statistics (BTS).

The analysis examines passenger traffic, freight activity, airline market share, airport activity, passenger routes, and monthly traffic patterns to identify major trends and operational patterns across the U.S. aviation network.

The project combines SQL-based data analysis with an interactive Power BI dashboard to transform raw transportation data into actionable business insights.

---

## Business Questions

The analysis was designed to answer the following questions:

- How large was the U.S. aviation network in 2025?
- Which airlines carried the most passengers?
- Which carriers handled the largest freight volumes?
- Which passenger routes had the highest traffic?
- How did passenger traffic change throughout the year?
- Which airports showed strong passenger and freight activity?
- How concentrated was the passenger market among the largest airlines?

---

## Dataset

**Source:** U.S. Bureau of Transportation Statistics (BTS)

**Year:** 2025

The dataset contains airline and airport traffic information including:

- Passenger volume
- Freight volume
- Mail volume
- Flight distance
- Airline and carrier information
- Origin and destination airports
- Origin and destination cities
- Origin and destination states
- Monthly and quarterly information
- Route information

### Dataset Overview

| Metric | Value |
|---|---:|
| Total Records | 253,318 |
| Airlines / Carriers | 145 |
| Origin Airports | 1,272 |
| Destination Airports | 1,295 |
| Unique Routes | 27,976 |
| Total Passengers | 844.60M |
| Total Freight | 23.53B |
| Analysis Period | January–December 2025 |

---

## Tools & Technologies

- **SQL / BigQuery** — Data exploration, aggregation and analytical queries
- **Power BI** — Interactive dashboard and data visualization
- **DAX** — Calculated columns and analytical measures
- **Canva** — Dashboard background and visual design
- **GitHub** — Project documentation and version control

---

## SQL Analysis

SQL was used to transform the raw aviation data into analytical datasets and summary views.

Key analyses included:

### Airline Passenger Performance
- Total passengers by airline
- Passenger market share
- Number of routes operated
- Average route distance
- Ranking of airlines by passenger traffic

### Cargo Performance
- Total freight by carrier
- Total mail volume
- Ranking of major cargo carriers
- Comparison between passenger and cargo-focused operators

### Route Analysis
- Passenger volume by origin-destination route
- Identification of the highest-volume passenger routes
- Unique route counts

### Monthly Traffic Analysis
- Monthly passenger totals
- Identification of peak and low-traffic months
- Seasonal changes in passenger activity

### Airport Analysis
- Passenger activity by airport
- Freight activity by airport
- Comparison of passenger and freight intensity

---

## Power BI Dashboard

The Power BI dashboard provides a one-page executive overview of U.S. aviation operations in 2025.

### Dashboard Components

**KPI Cards**
- Total Passengers
- Total Airlines
- Origin Airports
- Unique Routes
- Total Freight

**Visuals**
- Top 10 Cargo Carriers by Freight Volume
- Airport Passenger & Freight Activity
- Monthly Passenger Traffic
- Top 10 Passenger Routes
- Top Airlines by Passenger Market Share

**Interactive Filters**
- State
- Airport Code

The dashboard allows users to explore aviation activity while filtering the analysis by geographic and airport-level dimensions.

---

# Key Insights

## 1. Passenger traffic exceeded 844 million

The dataset recorded approximately **844.60 million passengers** across the U.S. aviation network during 2025.

This demonstrates the scale of passenger aviation activity across the analyzed routes and carriers.

---

## 2. Passenger traffic was concentrated among a small group of airlines

The largest passenger carriers were:

1. **Southwest Airlines** — 164.33M passengers
2. **Delta Air Lines** — 138.46M
3. **American Airlines** — 131.63M
4. **United Airlines** — 109.48M
5. **SkyWest Airlines** — 44.08M

The five largest carriers accounted for approximately **69.6% of total passenger traffic**, showing a highly concentrated passenger market.

Southwest alone represented approximately **19.5%** of passenger traffic in the analysis.

---

## 3. Cargo activity was dominated by dedicated freight carriers

The largest freight carriers included:

- **Federal Express** — 7.92B
- **United Parcel Service** — 7.00B
- **Air Transport International** — 2.28B
- **Atlas Air** — 1.42B
- **ABX Air** — 1.22B

This highlights a major distinction between passenger and cargo aviation: some of the largest freight operators are specialized cargo carriers rather than traditional passenger airlines.

---

## 4. Passenger traffic peaked during the summer

Monthly passenger activity reached its highest point in **July at approximately 79 million passengers**.

The lowest monthly volume occurred in **February at approximately 58 million passengers**.

This indicates a noticeable seasonal pattern, with passenger activity generally increasing toward the summer period before declining later in the year.

---

## 5. Major airport pairs handled significant passenger volumes

The highest-volume passenger routes included major airport connections such as:

- LAX → JFK
- JFK → LAX
- LGA → ORD
- ORD → LGA
- SFO → LAX
- LAX → SFO
- MCO → ATL

The prominence of these routes reflects strong traffic between major metropolitan and commercial aviation hubs.

---

## 6. The aviation network was highly interconnected

The dataset contains approximately **27,976 unique routes**, connecting more than **1,200 origin airports** with more than **1,200 destination airports**.

This demonstrates the scale and complexity of the U.S. air transportation network.

---

## 7. Passenger and freight activity do not always occur at the same airports

The airport activity analysis shows that airports can have very different operational profiles.

Some airports exhibit strong passenger activity while others show relatively stronger freight activity.

This distinction is important for aviation infrastructure planning, logistics operations, airport capacity management, and transportation investment decisions.

---

# Business Recommendations

Based on the analysis, several areas could be considered by aviation and transportation stakeholders:

### Capacity Planning
Airports and airlines can use seasonal passenger trends to anticipate periods of higher demand and optimize staffing, fleet availability, and airport capacity.

### Route Optimization
High-volume passenger routes can be monitored for capacity constraints, scheduling opportunities, and potential service expansion.

### Cargo Infrastructure
Airports with strong freight activity may require continued investment in cargo handling facilities, logistics infrastructure, and ground transportation connections.

### Market Monitoring
The concentration of passenger traffic among a small number of major carriers highlights the importance of monitoring airline market structure and competitive dynamics.

---

## Project Structure

```text
U.S-Airline-Analysis-2025/
│
├── data/
│   └── airline_traffic_2025.csv
│
├── sql/
│   └── airline_analysis.sql
│
├── powerbi/
│   └── US Airline Analysis 2025.pbix
│
├── images/
│   └── dashboard.png
│
└── README.md