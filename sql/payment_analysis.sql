-- ==========================================
-- 1. Payment Status Distribution
-- ==========================================
SELECT 
    payment_status,
    COUNT(*) AS count
FROM payments
GROUP BY payment_status
ORDER BY count DESC;


-- ==========================================
-- 2. Payment Method Breakdown
-- ==========================================
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(payment_amount) AS total_amount
FROM payments
WHERE payment_status = 'completed'
GROUP BY payment_method
ORDER BY total_amount DESC;


-- ==========================================
-- 3. Payment Status by Method (Pivot)
-- ==========================================
SELECT 
    payment_method,
    COUNT(*) FILTER (WHERE payment_status = 'completed') AS completed,
    COUNT(*) FILTER (WHERE payment_status = 'failed') AS failed,
    COUNT(*) FILTER (WHERE payment_status = 'pending') AS pending
FROM payments
GROUP BY payment_method
ORDER BY payment_method;


-- ==========================================
-- 4. Failed Payments Over Time (Count)
-- ==========================================
SELECT 
    TO_CHAR(DATE_TRUNC('month', payment_date), 'YYYY-MM') AS payment_month,
    COUNT(*) AS failed_payment_count
FROM payments
WHERE payment_status = 'failed'
GROUP BY payment_month
ORDER BY payment_month;


-- ==========================================
-- 5. Revenue Lost to Failed Payments
-- ==========================================
SELECT 
    SUM(payment_amount) AS revenue_lost
FROM payments
WHERE payment_status = 'failed';


-- ==========================================
-- 6. Total Revenue from Completed Payments
-- ==========================================
SELECT 
    SUM(payment_amount) AS total_successful_payments
FROM payments
WHERE payment_status = 'completed';


-- ==========================================
-- 7. Monthly Trend of Payment Status
-- ==========================================
SELECT 
    TO_CHAR(DATE_TRUNC('month', payment_date), 'YYYY-MM') AS payment_month,
    payment_status,
    COUNT(*) AS count
FROM payments
GROUP BY payment_month, payment_status
ORDER BY payment_month, payment_status;


-- ==========================================
-- 8. Orders Without Payments (Missing Payments)
-- ==========================================
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    o.order_status
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.order_id IS NULL;
