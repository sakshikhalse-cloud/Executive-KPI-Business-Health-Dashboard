CREATE TABLE business_kpi_data (
    customer_id VARCHAR(10),
    signup_date DATE,
    region VARCHAR(50),
    plan VARCHAR(20),
    revenue INT,
    is_active INT,
    date DATE
);
-----------Total revenue
select sum(revenue) as total_revenue
from business_kpi_data;
----------total costumers
select count(Distinct customer_id) as total_revenue
from business_kpi_data;
--------------Active Costumers
select count(Distinct customer_id) as active_costumers
from business_kpi_data
where is_active = 1;
------------churned costumers
select count(Distinct customer_id) as active_costumers
from business_kpi_data
where is_active = 0;
-------- churn rate
select round(count
(case when is_active=0 then customer_id end)*100.0/
count (Distinct customer_id)
,2
) as churned_rate_percent
from business_kpi_data;
----------- average revenue per user
select 
round(sum(revenue)*1.0/count(distinct customer_id),2) as average_revenue_per_user
from business_kpi_data;
---------- Revenue Trend over time
select date,sum(revenue) as montly_revenue
from business_kpi_data
group by date
order by date;
----------- revenue by plan
select plan,sum(revenue) as total_revenue
from business_kpi_data
group by plan
order by total_revenue desc;
-------------revenue by region
select region,sum(revenue) as total_revenue
from business_kpi_data
group by region
order by total_revenue desc;
------------ high risk segment(churn by plan)
SELECT 
    plan,
    COUNT(CASE WHEN is_active = 0 THEN customer_id END) AS churned_customers,
    COUNT(customer_id) AS total_customers,
    ROUND(
        COUNT(CASE WHEN is_active = 0 THEN customer_id END) * 100.0 
        / COUNT(customer_id),
        2
    ) AS churn_rate_percent
FROM business_kpi_data
GROUP BY plan
ORDER BY churn_rate_percent DESC;