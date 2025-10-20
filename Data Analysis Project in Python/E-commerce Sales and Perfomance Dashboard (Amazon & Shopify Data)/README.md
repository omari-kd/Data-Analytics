# 🛍️ E-commerce Data Analytics Dashboard

**Data Analyst / BI Specialist Mock Project**

<img width="1277" height="714" alt="Image" src="https://github.com/user-attachments/assets/f00330c9-d717-4f68-944c-a9a7d332b556" />

## Overview

This project simulates a real-world **E-commerce Data Analyst** role. It integrates mock data from **Amazon**, **Shopify**, and **Ad Spend** platforms to develop an interactive **Power BI dashboard** that tracks revenue, ad performance, and ROI.

The goal is to demonstrate skills in:

- Data extraction and cleaning (Python + Pandas)
- Building a star schema model in Power BI
- Designing business dashboards with DAX measures and visuals
- Interpreting metrics like ROI, Profit Margin, and Regional Performance

## Tools & Technologies

| Category        | Tools Used                              |
| --------------- | --------------------------------------- |
| Data Cleaning   | Python (Pandas, NumPy)                  |
| Data Modelling  | Power BI                                |
| Visualisation   | Power BI (DAX, Measures, Relationships) |
| File Storage    | CSV                                     |
| Scripting       | Power Query Editor, Python              |
| Version Control | Git & GitHub                            |

---

## Key DAX Measures

```DAX
Total Revenue =
SUM(cleaned_amazon_sales[Revenue_GHS]) +
SUM(cleaned_shopify_sales[Revenue_GHS])

Total Ad Spend = SUM(ad_spend[Ad_Spend_GHS])

Profit = [Total Revenue] - [Total Ad Spend]

ROI = DIVIDE([Total Revenue] - [Total Ad Spend], [Total Ad Spend])

Profit Margin = DIVIDE([Profit], [Total Revenue])
```

---

## Dashboard Highlights

- **KPIs:** Total Revenue, Ad Spend, Profit, ROI %, Profit Margin %
- **Charts:**
  - Regional Revenue (Bar Chart)
  - Monthly Sales Trend (Line Chart)
  - Ad Spend vs ROI Comparison
  - Platform Performance (Amazon vs Shopify)
- **Filters:** Month, Platform, Region

---

## Mock Data (Local Currency: GHS)

Each dataset uses **Ghana Cedi (₵)** to simulate realistic regional e-commerce performance.

| Platform | Description                            |
| -------- | -------------------------------------- |
| Amazon   | Regional and product category sales    |
| Shopify  | Daily store transactions               |
| Ad Spend | Marketing spend from Google & Meta Ads |

---

## How to Use

1. Clone the repository
   ```bash
   git clone https://github.com/<your-username>/ecommerce-analytics.git
   ```
2. Open the `mockdata_notebook.ipynb` notebook and run the Python cleaning steps.
3. Open `E-Commerce Dashboard.pbix` in Power BI.
4. Refresh data connections → Explore the dashboard visuals.

---

## Insights Gained

- Amazon outperformed Shopify by ~35% in total revenue.
- ROI reached **490%**, indicating strong marketing efficiency.

---

## Future Improvements

- Integrate live APIs for automatic data refresh.
- Add predictive analytics for sales forecasting (using Python).
- Deploy the dashboard via Power BI Service for public access.
