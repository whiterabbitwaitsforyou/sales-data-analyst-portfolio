/* =====================================================
    SALES DATA ANALYSIS
    Author  : Erfa Dini Prastiani
    Purpose : Business insight for sales performance
    ===================================================== */

/* =========================
    1. DATA OVERVIEW
    ========================= */

-- Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM orders;

-- Total number of products
SELECT COUNT(*) AS total_products
FROM products;


/* =========================
    2. CUSTOMER ANALYSIS
    ========================= */

-- Top 5 most active customers by number of orders
SELECT
     customer_id,
     COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 5;

-- Top 5 customers by total spending
SELECT
     c.customer_name,
     SUM(o.quantity * o.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;


/* =========================
    3. PRODUCT ANALYSIS
    ========================= */

-- Top 5 best-selling products (by quantity)
SELECT
     p.product_name,
     SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;


/* =========================
    4. REVENUE ANALYSIS
    ========================= */

-- Total revenue
SELECT
     SUM(quantity * price) AS total_revenue
FROM orders;

-- Monthly revenue trend
SELECT
    strftime('%Y-%m', order_date) AS month, /*SQLite way untuk extract bulan*/
    SUM(quantity * price) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- KPI Summary
SELECT
    SUM(quantity * price) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;

-- Top 5 products by revenue
SELECT
    p.product_name,
    SUM(o.quantity * o.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Revenue by category
SELECT
    p.category,
    SUM(o.quantity * o.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


