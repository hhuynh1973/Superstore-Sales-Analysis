CREATE DATABASE BusinessAnalysis
GO

USE BusinessAnalysis
GO


SELECT COUNT(*) AS Total_Rows
FROM Superstore;


SELECT TOP 10 *
FROM Superstore;


SELECT 
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit,
	COUNT (DISTINCT Order_ID) AS Total_Orders,	
	COUNT (DISTINCT Customer_ID) AS Total_Customers	,
	AVG(Sales) AS Average_Sales
FROM Superstore;


SELECT
	Category,
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


SELECT Sub_Category,
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit

FROM Superstore
GROUP BY Sub_Category
HAVING SUM(Profit)<0
ORDER BY Total_Profit ASC;


SELECT
	Region,
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


SELECT
	Region,
	Category,
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Category, Region
ORDER BY Total_Sales DESC;


SELECT
    YEAR(Order_Date) AS Sales_Year,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY YEAR(Order_Date)
ORDER BY Total_Profit DESC;


SELECT
    MONTH(Order_Date) AS Sales_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY MONTH(Order_Date)
ORDER BY Sales_Month;

SELECT
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY
    Total_Sales DESC;



WITH YearlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY YEAR(Order_Date)
)
SELECT
    Sales_Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Sales_Year) AS Previous_Year_Sales
FROM YearlySales
ORDER BY Sales_Year;


WITH YearlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        SUM(Profit) AS Total_Profit
    FROM Superstore
    GROUP BY YEAR(Order_Date)
),
SalesGrowth AS
(
    SELECT
        Sales_Year,
        Total_Profit,
        LAG(Total_Profit) OVER (ORDER BY Sales_Year) AS Previous_Year_Profit
    FROM YearlySales
)
SELECT
    Sales_Year,
    Total_Profit,
    Previous_Year_Profit,

    CAST(
        (Total_Profit - Previous_Year_Profit)
        * 100.0
        / Previous_Year_Profit
        AS DECIMAL(10,2)
    ) AS YoY_Growth_Percent

FROM SalesGrowth
ORDER BY Sales_Year;



WITH YearlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY YEAR(Order_Date)
),
SalesGrowth AS
(
    SELECT
        Sales_Year,
        Total_Sales,
        LAG(Total_Sales) OVER (ORDER BY Sales_Year) AS Previous_Year_Sales
    FROM YearlySales
)
SELECT
    Sales_Year,
    Total_Sales,
    Previous_Year_Sales,

    CAST(
        (Total_Sales - Previous_Year_Sales)
        * 100.0
        / Previous_Year_Sales
        AS DECIMAL(10,2)
    ) AS YoY_Growth_Percent

FROM SalesGrowth
ORDER BY Sales_Year;


WITH MonthlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        MONTH(Order_Date) AS Sales_Month,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY
        YEAR(Order_Date),
        MONTH(Order_Date)
),
SalesGrowth AS
(
    SELECT
        Sales_Year,
        Sales_Month,
        Total_Sales,
        LAG(Total_Sales) OVER
        (
            ORDER BY Sales_Year, Sales_Month
        ) AS Previous_Month_Sales
    FROM MonthlySales
)
SELECT
    Sales_Year,
    Sales_Month,
    Total_Sales,
    Previous_Month_Sales,
    CAST(
        (Total_Sales - Previous_Month_Sales)
        * 100.0
        / Previous_Month_Sales
        AS DECIMAL(10,2)
    ) AS MoM_Growth_Percent
FROM SalesGrowth
ORDER BY
    Sales_Year,
    Sales_Month;


SELECT TOP (10)
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Sales DESC;


SELECT TOP (10)
    Customer_ID,
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Profit DESC;


SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Profit DESC;


WITH OrderTotals AS
(
    SELECT
        Order_ID,
        SUM(Sales) AS Order_Sales
    FROM Superstore
    GROUP BY Order_ID
)
SELECT
    AVG(Order_Sales) AS Average_Order_Value
FROM OrderTotals;


SELECT
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Orders DESC;



WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY
        Customer_ID,
        Customer_Name
)
SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC;



WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY
        Customer_ID,
        Customer_Name
)
SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales,

    CASE
        WHEN Total_Sales >= 5000 THEN 'High Value'
        WHEN Total_Sales >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Segment

FROM CustomerSales
ORDER BY Total_Sales DESC;


WITH CustomerSales AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY
        Customer_ID,
        Customer_Name
),
CustomerSegments AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        Total_Sales,

        CASE
            WHEN Total_Sales >= 5000 THEN 'High Value'
            WHEN Total_Sales >= 2000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment

    FROM CustomerSales
)

SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers
FROM CustomerSegments
GROUP BY Customer_Segment
ORDER BY Total_Customers DESC;


SELECT
    Discount,
    COUNT(*) AS Total_Items,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Discount
ORDER BY Discount;


SELECT
    Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,

    CAST(
        SUM(Profit) * 100.0 /
        NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percent

FROM Superstore
GROUP BY Discount
ORDER BY Discount;


SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Group,

    COUNT(*) AS Total_Items,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit

FROM Superstore

GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END

ORDER BY Total_Profit DESC;


SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Group,
    
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit

FROM Superstore

GROUP BY 
    Category,
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END
    
HAVING SUM(Profit)<0

ORDER BY Total_Profit DESC;


WITH ProductSales AS
(
    SELECT
        Category,
        Product_Name,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Superstore
    GROUP BY
        Category,
        Product_Name
)
SELECT *
FROM ProductSales
ORDER BY Category, Total_Sales DESC;


WITH ProductSales AS
(
    SELECT
        Category,
        Product_Name,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Superstore
    GROUP BY
        Category,
        Product_Name
),
RankedProducts AS
(
    SELECT
        Category,
        Product_Name,
        Total_Sales,
        Total_Profit,
        RANK() OVER
        (
            PARTITION BY Category
            ORDER BY Total_Sales DESC
        ) AS Sales_Rank
    FROM ProductSales
)

SELECT
    Category,
    Product_Name,
    Total_Sales,
    Total_Profit,
    Sales_Rank
FROM RankedProducts
WHERE Sales_Rank <= 3
ORDER BY Category, Sales_Rank;