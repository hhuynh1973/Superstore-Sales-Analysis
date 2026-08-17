# Retail Sales & Profitability Analysis

## Project Overview

This project analyzes retail sales data to evaluate revenue, profitability,
customer behavior, product performance, discounting, and regional performance.

The project combines SQL Server for data exploration and business analysis,
Power BI and DAX for interactive reporting, and R for statistical analysis
and regression modeling.

The analysis progresses from descriptive business intelligence to statistical
inference and multivariable modeling, providing both business and technical
perspectives on retail profitability.

---

## Business Objectives

The project addresses the following questions:

- How much revenue and profit did the company generate?
- Which categories and sub-categories perform best?
- Which products generate the highest sales?
- Which products and sub-categories are unprofitable?
- How have sales changed over time?
- What are the year-over-year and month-over-month sales trends?
- Which customers generate the most revenue?
- How can customers be segmented by value?
- Which regions and states perform best or worst?
- How are discounts associated with profitability?
- Are discounted transactions significantly less profitable?
- Does average profit differ across product categories?
- How strongly are discount and profit correlated?
- Which factors help explain variation in profit?

---

## Tools & Technologies

- SQL Server
- SQL Server Management Studio (SSMS)
- Power BI
- DAX
- R
- RStudio
- Excel
- GitHub

### Statistical Techniques

- Descriptive statistics
- Hypothesis testing
- Welch's two-sample t-test
- One-way ANOVA
- Tukey HSD post-hoc analysis
- Pearson correlation
- Simple linear regression
- Multiple linear regression
- Regression diagnostics
- Breusch-Pagan heteroscedasticity test
- HC3 heteroscedasticity-robust standard errors

---

# SQL Analysis

SQL Server was used to explore the dataset, calculate business metrics,
segment customers, investigate profitability, and perform ranking and
time-series analysis.

Key SQL techniques included:

- `SUM()`, `AVG()`, `COUNT()`
- `COUNT(DISTINCT)`
- `CASE`
- `GROUP BY`
- `HAVING`
- Common Table Expressions (CTEs)
- Window functions
- `LAG()`
- `RANK()`
- Year-over-year analysis
- Month-over-month analysis
- Customer segmentation
- Discount segmentation
- Product profitability analysis

---

## Core Business KPIs

The SQL analysis calculated:

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Average Sales
- Profit Margin

The final Power BI model reported approximately:

- **Total Sales:** $2.3M
- **Total Profit:** $286.82K
- **Profit Margin:** 12.49%
- **Total Customers:** 793
- **Total Orders:** 5,009
- **Average Discount:** 15.6%

---

# Customer Analysis

Customers were analyzed by total sales and segmented into value groups.

The portfolio segmentation used the following analytical thresholds:

- **High Value:** $5,000 or more in sales
- **Medium Value:** $2,000–$4,999.99
- **Low Value:** Below $2,000

The final segmentation identified:

- **353 Low-Value Customers**
- **323 Medium-Value Customers**
- **117 High-Value Customers**

These groups total 793 customers.

---

# Discount & Profitability Analysis

Discount levels were grouped into:

- No Discount
- Low Discount
- Medium Discount
- High Discount

The analysis showed that the high-discount group generated substantially
weaker aggregate profitability and motivated additional statistical testing
in R.

Because observational retail data can contain confounding factors, these
results are interpreted as associations rather than proof that discounting
alone causes lower profit.

---

# Statistical & Technical Analysis

R was used to extend the descriptive dashboard analysis with formal
hypothesis testing and statistical modeling.

---

## 1. Welch Two-Sample t-Test

### Business Question

Do discounted and non-discounted transactions have different average profit?

### Hypotheses

**H0:** Mean profit is equal between discounted and non-discounted transactions.

**H1:** Mean profit differs between discounted and non-discounted transactions.

Significance level:

`alpha = 0.05`

### Results

| Group | Transactions | Mean Profit |
|---|---:|---:|
| Discounted | 5,196 | -$6.66 |
| No Discount | 4,798 | $66.90 |

Welch t-test results:

- **t = -15.738**
- **df = 9162.2**
- **p < 2.2e-16**
- **95% CI for mean difference: [-82.72, -64.40]**

### Conclusion

The null hypothesis was rejected.

Discounted transactions had significantly lower mean profit than
non-discounted transactions.

The observed difference is an association and should not by itself be
interpreted as evidence that discounts caused the difference.

---

# 2. One-Way ANOVA

### Business Question

Does average profit differ among Furniture, Office Supplies, and Technology?

### Mean Profit by Category

| Category | Mean Profit |
|---|---:|
| Furniture | $8.70 |
| Office Supplies | $20.33 |
| Technology | $78.75 |

### ANOVA Results

- **F(2, 9991) = 54.31**
- **p < 2e-16**

The null hypothesis of equal category means was rejected.

At least one category had a significantly different mean profit.

---

## Tukey HSD Post-Hoc Test

Because the overall ANOVA was significant, Tukey HSD was used to determine
which category pairs differed.

| Comparison | Mean Difference | Adjusted p-value | Significant? |
|---|---:|---:|---|
| Office Supplies - Furniture | $11.63 | 0.1181 | No |
| Technology - Furniture | $70.05 | <0.001 | Yes |
| Technology - Office Supplies | $58.42 | <0.001 | Yes |

### Interpretation

Technology had significantly higher mean profit than both Furniture and
Office Supplies.

The difference between Office Supplies and Furniture was not statistically
significant at the 5% level.

---

# 3. Pearson Correlation

### Business Question

Is discount linearly associated with profit?

### Results

- **Pearson r = -0.2195**
- **t = -22.488**
- **df = 9992**
- **p < 2.2e-16**
- **95% CI: [-0.2381, -0.2007]**

### Interpretation

Discount and profit demonstrated a statistically significant but weak
negative linear correlation.

Higher discounts therefore tended to be associated with lower profits,
although the magnitude of the linear relationship was relatively weak.

---

# 4. Simple Linear Regression

A simple regression model was estimated:

`Profit = 67.559 - 249.051(Discount)`

### Results

- **Discount coefficient:** -249.051
- **p < 2e-16**
- **R-squared = 0.0482**
- **Adjusted R-squared = 0.0481**
- **F = 505.7**
- **Model p < 2.2e-16**

Because Discount is stored from 0 to 1, a 10-percentage-point increase
corresponds to a 0.10 increase in the variable.

Therefore:

`-249.051 x 0.10 = -$24.91`

A 10-percentage-point increase in discount was associated with approximately
**$24.91 lower predicted profit** in the simple model.

However, discount alone explained only approximately **4.8% of the variation
in profit**, indicating that additional factors are important.

---

# 5. Multiple Linear Regression

A multivariable model was developed using:

- Sales
- Quantity
- Discount
- Category
- Region
- Customer Segment

The model specification was:

`Profit ~ Sales + Quantity + Discount + Category + Region + Segment`

### Model Performance

- **R-squared = 0.2806**
- **Adjusted R-squared = 0.2798**
- **F(10, 9983) = 389.3**
- **p < 2.2e-16**

The multiple regression explained approximately **28.1% of observed profit
variation**, compared with approximately 4.8% for the discount-only model.

---

## Discount Effect in the Multiple Model

The estimated Discount coefficient was:

**-236.28**

Therefore, a 10-percentage-point increase in discount corresponded to:

`-236.28 x 0.10 = -$23.63`

Holding Sales, Quantity, Category, Region, and Segment constant, a
10-percentage-point increase in discount was associated with approximately
**$23.63 lower predicted profit**.

---

# Regression Diagnostics

Regression assumptions were evaluated rather than relying only on coefficient
p-values and R-squared.

Diagnostic plots included:

- Residuals vs Fitted
- Normal Q-Q
- Scale-Location
- Residuals vs Leverage
- Cook's Distance

The diagnostics indicated:

- Heteroscedasticity
- Heavy-tailed/non-normal residuals
- Increasing residual variance at higher fitted values
- Potentially influential observations

---

## Breusch-Pagan Test

A Breusch-Pagan test was performed to formally test for heteroscedasticity.

### Results

- **BP = 2883**
- **df = 10**
- **p < 2.2e-16**

The null hypothesis of constant residual variance was rejected.

Because strong evidence of heteroscedasticity was detected, conventional OLS
standard errors were not relied upon for final coefficient inference.

---

# HC3 Robust Standard Errors

HC3 heteroscedasticity-robust standard errors were calculated.

Key results included:

| Predictor | Estimate | HC3 p-value |
|---|---:|---:|
| Sales | 0.1845 | 0.0017 |
| Quantity | -3.2231 | 0.2826 |
| Discount | -236.2802 | <0.001 |
| Office Supplies vs Furniture | 50.1266 | <0.001 |
| Technology vs Furniture | 41.1102 | <0.001 |
| East vs Central | -11.5047 | 0.0956 |
| South vs Central | -15.0162 | 0.0808 |
| West vs Central | -15.2915 | 0.0082 |
| Corporate vs Consumer | 3.1565 | 0.4812 |
| Home Office vs Consumer | 1.5986 | 0.7852 |

After robust standard errors were applied, Quantity, East, and South were no
longer statistically significant at the 5% level.

Discount remained a highly significant negative predictor.

This demonstrates why model diagnostics and robust inference are important
when interpreting regression results.

---

# Power BI Dashboard

The final Power BI report contains five analytical pages.

## Page 1 - Executive Sales Dashboard

Provides an executive overview of:

- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Sales trends
- Category performance
- Regional performance
- Sub-category profitability

## Page 2 - Product & Profitability Analysis

Analyzes:

- Total Sales
- Total Profit
- Average Discount
- Profit Margin
- Profit by Discount Group
- Profit by Sub-Category
- Profit Margin by Category
- Top Products by Sales

## Page 3 - Customer & Regional Analysis

Analyzes:

- Total Customers
- Total Orders
- Average Order Value
- Sales per Customer
- Sales by Segment
- Sales and Profit by Region
- Top Customers
- Lowest-Profit States
- Customer Value Segmentation

## Page 4 - Customer Detail Analysis

An interactive drill-through page allows users to investigate individual
customers and their:

- Orders
- Products purchased
- Sales
- Profit
- Quantity
- Discounts

## Page 5 - Technical & Statistical Analysis

Summarizes:

- Welch t-test
- One-way ANOVA
- Tukey HSD
- Pearson correlation
- Simple linear regression
- Multiple linear regression
- Regression diagnostics
- Breusch-Pagan test
- HC3 robust inference

---

# Key Findings

1. The retail dataset generated approximately **$2.3M in sales** and
   **$286.82K in profit**.

2. Consumer customers represented the largest sales segment.

3. Technology demonstrated substantially higher unadjusted mean profit than
   Furniture and Office Supplies.

4. Discounted transactions averaged **-$6.66 profit**, compared with
   **$66.90** for transactions without discounts.

5. The Welch t-test confirmed that this mean-profit difference was
   statistically significant.

6. Discount and profit had a statistically significant but weak negative
   correlation (**r = -0.219**).

7. Discount alone explained only approximately **4.8%** of profit variation.

8. The multiple regression model increased explained variation to
   approximately **28.1%**.

9. After controlling for Sales, Quantity, Category, Region, and Segment, a
   10-percentage-point increase in discount was associated with approximately
   **$23.63 lower predicted profit**.

10. Regression diagnostics detected substantial heteroscedasticity, so HC3
    robust standard errors were used for final coefficient inference.

---

# Business Recommendations

- Monitor profit margin alongside revenue rather than evaluating product
  performance from sales alone.

- Review discount policies associated with persistently weak profitability.

- Investigate high-discount products and transactions before expanding
  promotional programs.

- Give additional attention to loss-making sub-categories even when they
  generate substantial sales.

- Use customer segmentation to support retention and targeting strategies for
  high-value customers.

- Investigate geographic markets with weak profitability rather than focusing
  exclusively on high-sales regions.

- Consider multiple business factors simultaneously when evaluating
  profitability because discount alone explains only a small portion of total
  profit variation.

---

# Statistical Limitations

This project uses observational retail data.

Statistically significant associations should therefore not automatically be
interpreted as causal relationships.

The regression diagnostics also identified heteroscedasticity, non-normal
residual behavior, and potentially influential observations. HC3 robust
standard errors were used to improve inference under heteroscedasticity, but
additional modeling approaches could be explored in future work.

---

# Future Enhancements

Potential extensions include:

- Interaction effects between Discount and Category
- Nonlinear relationships
- Robust regression
- Time-series forecasting
- Customer clustering
- Product-level predictive modeling
- Cross-validation
- Outlier and influence sensitivity analysis

---

# Author

**Henri Huynh**

Data Analyst

Skills demonstrated in this project:

`SQL Server | Power BI | DAX | R | Statistical Analysis | Hypothesis Testing |
ANOVA | Regression | Data Visualization | Business Intelligence`
