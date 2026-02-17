USE Pizza_DB

-- CAST() is a function that converts datatype
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
AS DECIMAL(10,2))
AS Avg_Pizza_perOrder FROM pizza_sales

SELECT*FROM pizza_sales

-- No of Orders Per Weekday
SET DATEFIRST 1 -- Making sure Monday shows first

SELECT DATENAME(DW, order_date) AS  order_day, COUNT(DISTINCT order_id) AS  No_of_Orders FROM pizza_sales
GROUP BY DATENAME(DW, order_date),
DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(DW,order_date)

--No of Orders per Month highlighting the month with highest sales
SELECT DATENAME(MONTH, order_date) AS order_day, COUNT(DISTINCT order_id) AS No_of_Orders_perMonth FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

--Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) AS Total_Sales,
SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS Percentage_PizzaSales
FROM pizza_sales
WHERE MONTH(order_date) = 1 -- for January
GROUP BY pizza_category
ORDER BY SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) DESC

--Percentage of Sales by Pizza Size
SELECT pizza_size, ROUND(SUM(total_price),2) AS Total_Sales,
ROUND(SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1),2) AS Percentage_PizzaSize
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_PizzaSize DESC

--TOP 5 Pizza
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Sales FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Sales DESC

--Bottom 5 Pizza
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Sales FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Sales ASC
