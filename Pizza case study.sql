Create database Pizza_case;

Use Pizza_case;

/*1.	Share details of top 5 best-selling pizzas.*/

Select pt.*,sum(quantity) as no_of_orders
from Pizza_types pt inner join pizzas p on pt.pizza_type_id= p.pizza_type_id inner join order_details ot on ot.pizza_id= p.pizza_id
group by pt.pizza_type_id
order by no_of_orders desc
limit 5;

/* 2.	What is the most popular pizza size among customers?*/
Select p.size,sum(quantity) as no_of_orders
from Pizzas p inner join order_details ot on p.pizza_id= ot.pizza_id
group by p.size
order by no_of_orders desc
Limit 1;

/*3.	On which day do we sell the most pizzas?*/
Select sum(ot.quantity) as no_of_orders, dayname(o.date) as Day_Name
from order_details ot inner join orders o on ot.order_id= o.order_id
group by Day_Name
order by no_of_orders desc
Limit 1;

/*During what time of day are the most pizzas ordered?*/

Alter table orders 
add column new_time time;

Select * from orders;

Update orders
set new_time=str_to_date(time,"%H:%i:%s");

SET SQL_SAFE_UPDATES = 0;

select new_incident_date, incident_date from claims;

Select sum(quantity) as no_of_orders,
Case when time>"06:00:00" and time<="12:00:00" then "Morning"
when time>"12:00:00" and time<="18:00:00" then "Afternoon"
when time>"18:00:00" and time<="24:00:00" then "Evening"
Else "Night"
end as "Prime_Time"
from orders o inner join order_details od on o.order_id=od.order_id
group by Prime_time
order by no_of_orders desc;

/* 5.	What are the top 5 orders in terms of revenue?*/
Select sum(ot.quantity * p.price) as Revenue, ot.order_id
from order_details ot inner join pizzas p on ot.pizza_id= p.pizza_id
group by ot.order_id
order by Revenue desc
Limit 5;

/*6.	Which pizza category is in highest demand?*/
Select sum(quantity) as no_of_orders, pt.category
from Pizza_types pt inner join pizzas p on pt.pizza_type_id= p.pizza_type_id inner join order_details ot on ot.pizza_id= p.pizza_id
group by pt.category
order by no_of_orders desc
Limit 1;

/* 7.	What is the highest number of pizzas ordered by a single customer?*/
Select order_id,sum(Quantity) as no_of_orders
from order_details
Group by order_id
order by no_of_orders desc
Limit 1;

/* 8.	Do we sell more pizzas on weekends or weekdays?*/
Select sum(ot.quantity) as no_of_orders,
Case when dayname(o.date) in ("Saturday","Sunday") then "Weekends"
Else"Weekdays"
End as "Day"
from orders o inner join order_details ot on ot.order_id= o.order_id
group by Day
order by no_of_orders desc;


