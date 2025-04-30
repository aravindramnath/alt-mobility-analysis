-- ==========================================
-- Order Analysis: Total Revenue
-- ==========================================

SELECT 
    SUM(order_amount) AS total_sales_revenue
FROM 
    customer_orders;

-- ==========================================
-- Order Analysis: Order Status Distribution
-- ==========================================

SELECT 
    order_status,
    COUNT(*) AS order_count
FROM 
    customer_orders
GROUP BY 
    order_status
ORDER BY 
    order_count DESC;

-- ==========================================
-- Order Analysis: Revenue by Order Status
-- ==========================================

SELECT 
    order_status,
    SUM(order_amount) AS total_revenue
FROM 
    customer_orders
GROUP BY 
    order_status
ORDER BY 
    total_revenue DESC;

-- ==========================================
-- Order Analysis: Monthly Sales Trend
-- ==========================================

SELECT 
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS order_month,
    SUM(order_amount) AS total_sales
FROM 
    customer_orders
GROUP BY 
    DATE_TRUNC('month', order_date)
ORDER BY 
    order_month;

-- ==========================================
-- Order Analysis: Orders by Status Over Time
-- ==========================================

SELECT 
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS order_month,
    order_status,
    COUNT(order_id) AS order_count
FROM 
    customer_orders
GROUP BY 
    order_month,
    order_status
ORDER BY 
    order_month,
    order_status;
