# Superstore-Sales-Analysis
# Retail Sales & Profitability Analysis

## Project Overview

This project analyzes retail sales data to identify trends in revenue,
profitability, customer behavior, product performance, discounts, and
regional performance.

The analysis combines SQL Server for data exploration and business analysis
with Power BI for interactive visualization and reporting.

## Business Questions

The project addresses the following questions:

- How much revenue and profit did the company generate?
- Which categories and sub-categories perform best?
- Which products generate the highest sales and profit?
- Which products or sub-categories are unprofitable?
- How have sales changed over time?
- What are the year-over-year and month-over-month sales trends?
- Which customers generate the most revenue?
- How can customers be segmented by value?
- Which regions and states perform best or worst?
- How are discounts associated with profitability?

## Tools Used

- SQL Server
- SQL Server Management Studio (SSMS)
- Power BI
- DAX
- Microsoft Excel
- GitHub

## SQL Analysis

SQL was used for:

- Data exploration and validation
- Aggregate KPI calculations
- Category and sub-category analysis
- Regional analysis
- Customer analysis
- Customer segmentation using CASE
- Discount and profitability analysis
- Year-over-year sales growth using LAG()
- Month-over-month sales growth
- Product ranking using RANK()
- CTEs and window functions

## Power BI Dashboard

The Power BI report contains four pages:

### 1. Executive Sales Dashboard

Provides an overview of:

- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Sales trends
- Category performance
- Regional performance
- Sub-category profitability

### 2. Product & Profitability Analysis

Analyzes:

- Sales and profit by product
- Profit margin by category
- Discount groups
- Loss-making sub-categories
- Top-performing products

### 3. Customer & Regional Analysis

Analyzes:

- Customer value
- Average order value
- Sales per customer
- Customer segments
- Top customers
- Regional performance
- Low-profit states

### 4. Customer Detail Analysis

Interactive drill-through page that allows users to investigate an
individual customer's:

- Orders
- Products purchased
- Sales
- Profit
- Quantity
- Discounts

## Key Findings

The analysis identified several important business patterns:

- Sales increased over the analyzed period.
- Consumer customers represent the largest sales segment.
- The West region generates the highest sales.
- Technology and Office Supplies have stronger profit margins than Furniture.
- High-discount transactions show substantially weaker overall profitability.
- Some sub-categories generate negative profit despite producing sales.
- A relatively small group of high-value customers contributes substantial revenue.

## Business Recommendations

- Review discount policies for products associated with persistent losses.
- Investigate loss-making sub-categories before increasing sales volume.
- Focus retention efforts on high-value customers.
- Analyze successful practices in stronger-performing regions.
- Monitor profit margin alongside sales rather than using revenue alone as a performance measure.
- Use customer-level drill-through analysis to investigate unusually profitable or unprofitable orders.

## Dashboard Preview

Add screenshots of the four Power BI dashboard pages here.

## Author

Henri Huynh  
Data Analyst
