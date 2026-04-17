# 📚 GravityBooks Data Warehouse & Analytics Project

## 🎯 Business Problem
GravityBooks management faces challenges in strategic decision-making due to fragmented OLTP data. They need insights on:
- Monthly sales trends & YoY comparison
- Shipping performance & delay impact on satisfaction
- VIP customer identification & geographic demand analysis

## 🏗️ Architecture
End-to-End Data Engineering Pipeline:
`OLTP (SQL Server) → SSIS (ETL) → Star Schema DW → SSAS (Cube) → Power BI (Dashboard)`

### 📊 Star Schema Design
- **Fact Table:** `Fact_Sales` (Transactional, Grain: 1 row per order line)
- **Dimensions:** `Dim_Date` (Role-Playing), `Dim_Customer` (SCD Type 2), `Dim_Book`, `Dim_Location`, `Dim_Shipping`, `Dim_OrderStatus`

## 🛠️ Tech Stack
| Component | Tool |
|-----------|------|
| Database & DW | SQL Server 2022 |
| ETL | SSIS (Visual Studio) |
| OLAP / Cube | SSAS Multidimensional |
| Visualization | Power BI Desktop |
| Version Control | Git & GitHub |

## 🚀 How to Run
1. **DW Setup:** Run scripts in `01_SQL_DW_Scripts/` to create tables & indexes.
2. **ETL:** Open `02_SSIS_Packages/` in SSDT, update Connection Managers, and execute.
3. **Cube:** Deploy `03_SSAS_Cube/` to local Analysis Services instance.
4. **Dashboard:** Open `04_PowerBI_Report/GravityBooks_Analysis.pbix` and refresh.

## 📈 Key Insights Delivered
- ✅ Identified top 10 profitable books by category & publisher
- ✅ Calculated avg. shipping delay & correlated with cancellation rates
- ✅ Segmented customers into VIP/Regular based on lifetime value
- ✅ Geographic heatmaps showing highest demand regions

## 📂 Project Structure
