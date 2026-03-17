{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww29200\viewh17740\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 --QUERY1 = Top Spenders(last 90 days)\
SELECT\
    u.customer_id,\
    u.full_name,\
    SUM(t.amount) AS total_spend,\
    COUNT(*) AS tx_count,\
    MAX(t.transaction_time) AS last_tx_date\
FROM transactions t\
JOIN cards c ON t.card_id = c.card_id\
JOIN customers u ON c.customer_id = u.customer_id\
WHERE t.status = 'SUCCESS'\
  AND t.transaction_time >= '2024-01-01'\
GROUP BY u.customer_id, u.full_name\
ORDER BY total_spend DESC;\
\
--QUERY2 = Merchant Performance(last 30 days)\
select m.merchant_id, m.merchant_name,sum(t.amount) as total_revenue,count(*) as tx_count\
from transactions t\
join merchants m on m.merchant_id = t.merchant_id\
where t.status = 'SUCCESS'\
  AND t.transaction_time >= '2024-01-01'\
group by m.merchant_id,m.merchant_name\
order by total_revenue desc;\
\
--QUERY3 = Most popular transaction channels in the last 180 days\
select c.channel_name, count(*) as trans_count, sum(amount) as total_revenue\
from transactions t\
join transaction_channels c on t.channel_id = c.channel_id\
where t.status = 'SUCCESS'\
  AND t.transaction_time >= '2024-01-01'\
group by c.channel_name\
order by trans_count, total_revenue desc;\
\
--QUERY4 = High-risk locations based on number of fraud alerts\
select l.location_id, l.city, l.country, count(*) as total_fraud_count, sum(amount) as total_fraud_amount--, f.alert_type\
from locations l\
join transactions t on l.location_id = t.location_id\
join fraud_alerts f on f.transaction_id = t.transaction_id\
--where t.status = 'SUCCESS'\
group by l.location_id, l.city, l.country--, f.alert_type\
order by total_fraud_count desc;\
\
--QUERY5 = Fraud by Device Type\
select d.device_id,d.device_type, count(*) as total_fraud_transactions, sum(amount) as total_fraud_amount\
from devices d\
join transactions t on t.device_id = d.device_id\
join fraud_alerts f on t.transaction_id = f.transaction_id\
group by d.device_id, d.device_type\
order by total_fraud_transactions desc;\
\
--QUERY6 = Hight risk merchants\
SELECT \
    m.merchant_id, \
    m.merchant_name,\
    COUNT(*) AS total_fraud_transactions,\
    SUM(t.amount) AS total_fraud_amount,\
    ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 2) AS fraud_ratio\
FROM transactions t\
JOIN merchants m ON m.merchant_id = t.merchant_id\
JOIN fraud_alerts f ON t.transaction_id = f.transaction_id\
GROUP BY m.merchant_id, m.merchant_name\
ORDER BY total_fraud_transactions DESC;\
\
--QUERY6 = Hight Risk Merchants(risk score customer-based)\
SELECT \
    m.merchant_id, \
    m.merchant_name,\
    round(AVG(rs.score),2) AS avg_customer_risk,\
    COUNT(f.transaction_id) AS total_fraud_transactions,\
    SUM(t.amount) AS total_fraud_amount\
FROM merchants m\
JOIN transactions t ON m.merchant_id = t.merchant_id\
JOIN cards c ON c.card_id = t.card_id\
join customers cu on cu.customer_id = c.customer_id\
JOIN risk_scores rs ON rs.customer_id = c.customer_id\
JOIN fraud_alerts f ON f.transaction_id = t.transaction_id\
GROUP BY m.merchant_id, m.merchant_name\
ORDER BY avg_customer_risk DESC, total_fraud_transactions DESC;\
\
--QUERY7 = Customer Fraud Ratio & Ranking\
select c.customer_id, c.full_name, count(f.transaction_id) as total_fraud_count, count(t.transaction_id) as total_trans_count, round((count(f.transaction_id)*1.0/count(t.transaction_id)),2) as fraud_ratio, rank() over(order by round((count(f.transaction_id)*1.0/count(t.transaction_id)),2) desc) as rank_no\
from customers c\
join cards cs on c.customer_id = cs.customer_id\
join transactions t on t.card_id = cs.card_id\
left join fraud_alerts f on f.transaction_id = t.transaction_id\
group by c.customer_id,c.full_name\
order by fraud_ratio desc;\
\
--QUERY8 = Fraud by device/channel patterns\
with fraud_data as(\
select d.device_type, c.channel_name,DATE_TRUNC('month', t.transaction_time) as month,\
	   count(t.transaction_id) as total_trans_count,\
	   SUM(CASE WHEN f.transaction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fraud_count,\
	   sum(t.amount) as total_trans_amount,\
	   sum(case when f.transaction_id IS NOT NULL then t.amount else 0 end ) as total_fraud_amount\
from devices d\
join transactions t on d.device_id = t.device_id\
join transaction_channels c on t.channel_id = c.channel_id\
left join fraud_alerts f on f.transaction_id = t.transaction_id\
group by d.device_type, c.channel_name,DATE_TRUNC('month', t.transaction_time)\
)\
select *, round((total_fraud_count*1.0/NULLIF(total_trans_count,0)),2) as fraud_ratio,\
          rank() over(order by round((total_fraud_count*1.0/NULLIF(total_trans_count,0)),2) desc) as risk_rank,\
		  row_number() over(partition by month ORDER BY (total_fraud_count*1.0/NULLIF(total_trans_count,0)) DESC) as per_month\
from fraud_data\
order by fraud_ratio desc;\
\
--QUERY9 = Top 5 customers per month by fraud exposure\
-- Top 5 customers per month by fraud exposure\
WITH monthly_customer_fraud AS (\
    SELECT \
        c.customer_id,\
        c.full_name,\
        DATE_TRUNC('month', t.transaction_time) AS month,\
        COUNT(t.transaction_id) AS total_trans_count,\
        SUM(t.amount) AS total_trans_amount,\
        SUM(CASE WHEN f.transaction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fraud_count,\
        SUM(CASE WHEN f.transaction_id IS NOT NULL THEN t.amount ELSE 0 END) AS total_fraud_amount\
    FROM customers c\
	join cards cs on cs.customer_id = c.customer_id \
    JOIN transactions t ON cs.card_id = t.card_id\
    LEFT JOIN fraud_alerts f ON f.transaction_id = t.transaction_id\
    GROUP BY c.customer_id, c.full_name, DATE_TRUNC('month', t.transaction_time)\
),\
fraud_exposure AS (\
    SELECT \
        customer_id,\
        full_name,\
        month,\
        total_trans_count,\
        total_fraud_count,\
        total_trans_amount,\
        total_fraud_amount,\
        ROUND(total_fraud_count * 1.0 / NULLIF(total_trans_count,0), 3) AS fraud_ratio,\
        ROUND(total_fraud_amount * 1.0 / NULLIF(total_trans_amount,0), 3) AS fraud_amount_ratio\
    FROM monthly_customer_fraud\
),\
ranked_customers AS (\
    SELECT \
        *,\
        RANK() OVER (PARTITION BY month ORDER BY fraud_amount_ratio DESC, fraud_ratio DESC) AS rnk\
    FROM fraud_exposure\
)\
SELECT \
    customer_id,\
    full_name,\
    month,\
    total_trans_count,\
    total_fraud_count,\
    total_trans_amount,\
    total_fraud_amount,\
    fraud_ratio,\
    fraud_amount_ratio,\
    rnk\
FROM ranked_customers\
WHERE rnk <= 5\
ORDER BY month DESC, rnk;\
\
--QUERY10 = High-risk customers have failed transactions, fraud alerts and fraud ratio\
WITH customer_fraud AS (\
    SELECT \
        c.customer_id,\
        c.full_name,\
        rs.score,\
        COUNT(DISTINCT fa.alert_id) AS total_alerts,\
        COUNT(CASE WHEN t.status = 'FAILED' THEN 1 END) AS failed_payments,\
        COUNT(DISTINCT t.transaction_id) AS total_transactions,\
        SUM(CASE WHEN fa.transaction_id IS NOT NULL THEN 1 ELSE 0 END) AS fraud_count,\
        ROUND(\
            SUM(CASE WHEN fa.transaction_id IS NOT NULL THEN 1 ELSE 0 END)*1.0 \
            / NULLIF(COUNT(t.transaction_id),0),2\
        ) AS fraud_ratio\
    FROM customers c\
    JOIN risk_scores rs ON c.customer_id = rs.customer_id\
	join cards cs on cs.customer_id = c.customer_id\
    JOIN transactions t ON cs.card_id = t.card_id\
    LEFT JOIN fraud_alerts fa ON t.transaction_id = fa.transaction_id\
   -- WHERE t.status = 'FAILED'\
    GROUP BY c.customer_id, c.full_name, rs.score\
)\
SELECT \
    customer_id,\
    full_name,\
    score,\
    total_alerts,\
    failed_payments,\
    total_transactions,\
    fraud_count,\
    fraud_ratio,\
    (score * COALESCE(fraud_ratio,0)) AS combined_risk_score,\
    RANK() OVER(ORDER BY (score * COALESCE(fraud_ratio,0)) DESC) AS risk_rank\
FROM customer_fraud\
ORDER BY combined_risk_score DESC, total_alerts DESC;\
\
--QUERY11 = Find customers with multiple failed login attempts who are also on the blacklist.\
WITH failed_login_data AS (\
    SELECT \
        c.customer_id, \
        c.full_name, \
        b.reason,\
        d.device_type,\
        COALESCE(SUM(CASE WHEN l.status = 'FAILED' THEN 1 ELSE 0 END), 0) AS failed_login,\
        COALESCE(COUNT(l.login_id), 0) AS total_logins\
    FROM customers c \
    JOIN cards cs ON cs.customer_id = c.customer_id\
    JOIN blacklist b ON b.card_id = cs.card_id\
    LEFT JOIN logins l ON l.customer_id = c.customer_id\
    LEFT JOIN devices d ON d.device_id = l.device_id\
    GROUP BY c.customer_id, c.full_name, b.reason, d.device_type\
) \
SELECT *, \
       CASE \
           WHEN failed_login >= 4 THEN 'HIGH RISK'\
           WHEN failed_login BETWEEN 1 AND 3 THEN 'MEDIUM RISK'\
           WHEN failed_login = 0 AND total_logins > 0 THEN 'LOW RISK'\
           WHEN total_logins = 0 THEN 'NO ACTIVITY'\
       END AS risk_level\
FROM failed_login_data\
ORDER BY failed_login DESC;\
\
--QUERY12 = Customers whose fraud ratio is greater than overall average fraud ratio.\
SELECT \
    c.customer_id,\
    c.full_name,\
    round((COUNT(f.transaction_id) * 1.0 / COUNT(t.transaction_id)),2) AS fraud_ratio\
FROM customers c\
left join cards cs on cs.customer_id = c.customer_id\
LEFT JOIN transactions t ON cs.card_id = t.card_id\
LEFT JOIN fraud_alerts f ON t.transaction_id = f.transaction_id\
GROUP BY c.customer_id, c.full_name\
HAVING (COUNT(f.transaction_id) * 1.0 / NULLIF(COUNT(t.transaction_id), 0)) >\
       (\
           SELECT COUNT(f2.transaction_id) * 1.0 / COUNT(t2.transaction_id)\
           FROM transactions t2\
           LEFT JOIN fraud_alerts f2 ON t2.transaction_id = f2.transaction_id\
       );\
\
--QUERY13 = Final Consolidated Query (Customer Risk Dashboard)\
WITH fraud_data AS (\
    SELECT \
        c.customer_id,\
        c.full_name,\
        COUNT(t.transaction_id) AS total_trans,\
        COUNT(f.transaction_id) AS total_fraud,\
        ROUND(COUNT(f.transaction_id) * 1.0 / NULLIF(COUNT(t.transaction_id), 0), 2) AS fraud_ratio\
    FROM customers c\
    LEFT JOIN cards cs ON cs.customer_id = c.customer_id\
    LEFT JOIN transactions t ON cs.card_id = t.card_id\
    LEFT JOIN fraud_alerts f ON t.transaction_id = f.transaction_id\
    GROUP BY c.customer_id, c.full_name\
),\
fraud_risk AS (\
    SELECT \
        fd.*,\
        CASE \
            WHEN fraud_ratio >= 0.5 THEN 'HIGH RISK'\
            WHEN fraud_ratio > 0 AND fraud_ratio < 0.5 THEN 'MEDIUM RISK'\
            ELSE 'LOW RISK'\
        END AS fraud_category\
    FROM fraud_data fd\
),\
failed_login_data AS (\
    SELECT \
        l.customer_id,\
        SUM(CASE WHEN l.status = 'FAILED' THEN 1 ELSE 0 END) AS failed_login_count\
    FROM logins l\
    GROUP BY l.customer_id\
),\
login_risk AS (\
    SELECT \
        customer_id,\
        failed_login_count,\
        CASE \
            WHEN failed_login_count >= 5 THEN 'HIGH LOGIN RISK'\
            WHEN failed_login_count BETWEEN 1 AND 4 THEN 'MEDIUM LOGIN RISK'\
            ELSE 'NO LOGIN RISK'\
        END AS login_category\
    FROM failed_login_data\
),\
blacklist_data AS (\
    SELECT \
        c.customer_id,\
        STRING_AGG(DISTINCT b.reason, ', ') AS blacklist_reasons\
    FROM customers c\
    JOIN cards cs ON c.customer_id = cs.customer_id\
    JOIN blacklist b ON cs.card_id = b.card_id\
    GROUP BY c.customer_id\
)\
SELECT \
    fr.customer_id,\
    fr.full_name,\
    fr.total_trans,\
    fr.total_fraud,\
    fr.fraud_ratio,\
    fr.fraud_category,\
    COALESCE(lr.failed_login_count, 0) AS failed_login_count,\
    COALESCE(lr.login_category, 'NO LOGIN RISK') AS login_category,\
    COALESCE(bl.blacklist_reasons, 'NOT BLACKLISTED') AS blacklist_reasons,\
    rs.score\
FROM fraud_risk fr\
LEFT JOIN login_risk lr ON fr.customer_id = lr.customer_id\
LEFT JOIN blacklist_data bl ON fr.customer_id = bl.customer_id\
LEFT JOIN risk_scores rs ON rs.customer_id = fr.customer_id\
ORDER BY fr.fraud_ratio DESC, lr.failed_login_count DESC;\
\
--QUERY14 = Transaction Anomaly Checks (amount-based)\
WITH avg_amount AS (\
    SELECT \
        c.customer_id,\
        cs.card_id,\
        round(AVG(t.amount),2) AS average_amount\
    FROM customers c\
    JOIN cards cs ON c.customer_id = cs.customer_id\
    JOIN transactions t ON t.card_id = cs.card_id\
    GROUP BY c.customer_id, cs.card_id\
)\
SELECT \
    t.transaction_id,\
    t.card_id,\
    ag.customer_id,\
    t.amount,\
    ag.average_amount,\
    CASE \
        WHEN t.amount > 3 * ag.average_amount THEN 'ANOMALY'\
        ELSE 'NORMAL'\
    END AS anomaly_flag\
FROM avg_amount ag\
JOIN transactions t ON ag.card_id = t.card_id\
ORDER BY ag.customer_id, t.amount DESC;\
\
-- QUERY15 = Geographic / Device Anomalies\
SELECT \
    c.customer_id,\
    DATE_TRUNC('day', t.transaction_time) AS day,\
    COUNT(DISTINCT l.country) AS distinct_countries,\
    COUNT(DISTINCT d.device_type) AS distinct_devices,\
    CASE \
        WHEN COUNT(DISTINCT l.country) > 1 THEN 'GEO ANOMALY'\
        ELSE 'NO ANOMALY'\
    END AS geographic_anomalies,\
    CASE \
        WHEN COUNT(DISTINCT d.device_type) > 1 THEN 'DEVICE ANOMALY'\
        ELSE 'NO ANOMALY'\
    END AS device_anomalies\
FROM customers c\
JOIN cards cs ON cs.customer_id = c.customer_id\
JOIN transactions t ON t.card_id = cs.card_id\
JOIN devices d ON d.device_id = t.device_id\
JOIN locations l ON l.location_id = t.location_id\
GROUP BY c.customer_id, DATE_TRUNC('day', t.transaction_time)\
ORDER BY c.customer_id, day;\
\
--QUERY16 = Trend Analysis (for management view)\
SELECT \
    cs.card_type, \
    TO_CHAR(t.transaction_time, 'YYYY-MM') AS month,\
    COUNT(t.transaction_id) AS total_txn,\
    COUNT(DISTINCT f.transaction_id) AS fraud_txn,\
    ROUND(\
        COUNT(DISTINCT f.transaction_id)::numeric \
        / NULLIF(COUNT(t.transaction_id),0), \
        4\
    ) AS fraud_ratio\
FROM cards cs\
JOIN transactions t ON t.card_id = cs.card_id\
LEFT JOIN fraud_alerts f ON f.transaction_id = t.transaction_id\
GROUP BY cs.card_type, TO_CHAR(t.transaction_time, 'YYYY-MM')\
ORDER BY month DESC;\
\
--QUERY17 = Temporal Risk (Velocity Checks)\
SELECT \
    c.customer_id,\
    cs.card_id,\
    DATE_TRUNC('hour', t.transaction_time) AS hour_window,\
    COUNT(t.transaction_id) AS txn_count,\
    CASE \
        WHEN COUNT(t.transaction_id) > 5 THEN 'HIGH RISK' \
        ELSE 'NORMAL'\
    END AS velocity_flag\
FROM customers c\
JOIN cards cs ON cs.customer_id = c.customer_id\
JOIN transactions t ON t.card_id = cs.card_id\
GROUP BY c.customer_id, cs.card_id, DATE_TRUNC('hour', t.transaction_time)\
ORDER BY txn_count DESC;}