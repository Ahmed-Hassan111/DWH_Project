# 📚 GravityBooks Data Warehouse & Analytics Project

## 🎯 Business Problem & Strategic Questions
Library management struggles to make strategic decisions despite having extensive OLTP data. They lack visibility into key performance indicators. This end-to-end Data Warehouse project answers four critical strategic questions:

1. **Which book categories are the most profitable?**
   - 📊 *Power BI Visual:* `Book Sales Distribution`
   - 📖 *Category Logic:* Derived from `num_pages`:
     - `Large Book` → ≥ 500 pages
     - `Medium Book` → ≥ 200 pages
     - `Small Book` → < 200 pages

2. **Who are the (VIP) customers?**
   - 📊 *Power BI Visual:* `VIP Customers`

3. **What are the annual sales trends?**
   - 📊 *Power BI Visual:* `Annual Sales Trend (2020–2025)`

4. **Which geographical areas have the highest demand?**
   - 📊 *Power BI Visual:* `Top Demand Areas`

## 🏗️ Solution Architecture
End-to-End Data Engineering Pipeline:
`OLTP (SQL Server) → SSIS (ETL) → Star Schema DW → SSAS Multidimensional Cubes → Power BI Dashboard`

### 📊 Data Modeling Strategy
- **Schema Type:** Star Schema (Kimball Methodology)
- **Fact Table:** `Fact_Sales` (Grain: 1 row per order line, Transactional Fact)
- **Dimensions:** 
  - `Dim_Date` (Role-Playing for Order, Ship, Delivery dates)
  - `Dim_Customer` (SCD Type 2 for address/history tracking)
  - `Dim_Book`, `Dim_Location`, `Dim_Shipping`, `Dim_OrderStatus`

## 🛠️ Tech Stack
| Component | Tool |
|-----------|------|
| Database & DW | SQL Server 2022 |
| ETL & Orchestration | SSIS (Visual Studio / SSDT) |
| OLAP & Semantic Model | SSAS Multidimensional |
| Visualization & Reporting | Power BI Desktop |
| Version Control | Git & GitHub |


## 🚀 How to Deploy & Run
1. **Database Setup:** Execute `ETL_Project/ETL_Project/Creation.sql` in SSMS to create `GravityBooks_DW` and all tables.
2. **ETL Execution:** Open `GravityBooks_ETL.dtproj` in SSDT/Visual Studio. Update connection strings if needed, then run packages in sequence (`Load_Dimensions.dtsx` → `Load_Fact_Sales.dtsx`).
3. **Cube Deployment:** Open `Gravity_Books_Cubes.dwproj`, deploy to local SSAS Multidimensional instance, and process fully.
4. **Visualization:** Open `DWH_Project_Dashboard.pbix` in Power BI Desktop and refresh data.

## 📈 Key Insights Delivered
- ✅ **Category Profitability:** Identified "Large Books" as the highest revenue driver, enabling focused inventory procurement.
- ✅ **Customer Segmentation:** Successfully isolated VIP customers based on lifetime value and order frequency for targeted loyalty campaigns.
- ✅ **Temporal Analysis:** Revealed consistent annual growth (2020–2025) with identifiable seasonal peaks, optimizing marketing spend.
- ✅ **Geographic Demand:** Mapped high-demand regions to optimize shipping routes, warehouse allocation, and delivery SLAs.

## 🤝 Contributing & Contact
This project was developed as a comprehensive Data Warehouse capstone. Feedback, improvements, and collaboration are welcome!

---
*Built with ❤️ for Data Engineering & Analytics*
