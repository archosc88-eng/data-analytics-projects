SQL projects

## Proyectos:
- dso_calculation.sql
- reconciliation_query.sql
- invoice_aging.sql
/*
DSO Analysis - Días de Venta Pendiente
Autor: Oscar Archila
*/

SELECT 
    customer_id,
    customer_name,
    ROUND(AVG(CAST(days_to_pay AS FLOAT)), 2) AS avg_dso,
    COUNT(DISTINCT invoice_id) AS num_invoices
FROM (
    SELECT 
        i.customer_id,
        c.customer_name,
        i.invoice_id,
        DATEDIFF(DAY, i.invoice_date, p.payment_date) AS days_to_pay
    FROM invoices i
    LEFT JOIN customers c ON i.customer_id = c.customer_id
    LEFT JOIN payments p ON i.invoice_id = p.invoice_id
    WHERE p.payment_date IS NOT NULL
) AS base
GROUP BY customer_id, customer_name
ORDER BY avg_dso DESC;
