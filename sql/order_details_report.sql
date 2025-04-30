-- ==========================================
-- 1. Full Order-Payment Report
-- ==========================================
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    o.order_status,
    o.shipping_address,
    p.payment_id,
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    p.payment_status
FROM customer_orders o
LEFT JOIN payments p 
    ON o.order_id = p.order_id
ORDER BY o.order_date DESC;


-- ==========================================
-- 2. Total Orders, Paid Orders, and Unpaid Orders
-- ==========================================
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT p.order_id) AS paid_orders,
    COUNT(DISTINCT o.order_id) - COUNT(DISTINCT p.order_id) AS unpaid_orders
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id;


-- ==========================================
-- 3. Fulfillment vs Payment Status Crosstab
-- ==========================================
SELECT 
    o.order_status,
    p.payment_status,
    COUNT(*) AS count
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_status, p.payment_status
ORDER BY o.order_status, p.payment_status;


-- ==========================================
-- 4. Orders Without Payment
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


-- ==========================================
-- 5. Payments Without Matching Orders (Data Quality Check)
-- ==========================================
SELECT 
    p.payment_id,
    p.order_id,
    p.payment_date,
    p.payment_amount,
    p.payment_status
FROM payments p
LEFT JOIN customer_orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;
