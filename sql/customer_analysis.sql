-- ==========================================
-- Customer Analysis: Total Number of Unique Customers
-- ==========================================
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customer_orders;


-- ==========================================
-- Customer Analysis: Repeat vs. One-Time Customers
-- ==========================================
SELECT 
    COUNT(*) FILTER (WHERE order_count = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM customer_orders
    GROUP BY customer_id
) AS customer_orders_count;


-- ==========================================
-- Customer Analysis: Customer Orders Over Time
-- ==========================================
SELECT 
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS order_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM customer_orders
GROUP BY order_month
ORDER BY order_month;


-- ==========================================
-- Customer Analysis: Top 10 Customers by Revenue
-- ==========================================
SELECT 
    customer_id,
    SUM(order_amount) AS total_spent,
    COUNT(order_id) AS order_count
FROM customer_orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- ==========================================
-- Customer Analysis: Monthly New vs. Returning Customers
-- ==========================================
WITH first_orders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM customer_orders
    GROUP BY customer_id
),
labeled_orders AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date,
        DATE_TRUNC('month', o.order_date) AS order_month,
        CASE 
            WHEN o.order_date = f.first_order_date THEN 'New'
            ELSE 'Returning'
        END AS customer_type
    FROM customer_orders o
    JOIN first_orders f
      ON o.customer_id = f.customer_id
)
SELECT 
    TO_CHAR(order_month, 'YYYY-MM') AS order_month,
    COUNT(*) FILTER (WHERE customer_type = 'New') AS new_customers,
    COUNT(*) FILTER (WHERE customer_type = 'Returning') AS returning_customers
FROM labeled_orders
GROUP BY order_month
ORDER BY order_month;


-- ==========================================
-- Customer Analysis: Customer Segmentation by Lifetime Spend
-- ==========================================
WITH customer_spend AS (
    SELECT 
        customer_id,
        SUM(order_amount) AS total_spent
    FROM customer_orders
    GROUP BY customer_id
),
segmented_customers AS (
    SELECT 
        customer_id,
        total_spent,
        NTILE(3) OVER (ORDER BY total_spent) AS spend_segment
    FROM customer_spend
)
SELECT 
    CASE 
        WHEN spend_segment = 1 THEN 'Low'
        WHEN spend_segment = 2 THEN 'Medium'
        WHEN spend_segment = 3 THEN 'High'
    END AS segment,
    COUNT(*) AS customer_count
FROM segmented_customers
GROUP BY segment
ORDER BY customer_count DESC;
