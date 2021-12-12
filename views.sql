-- View to get top 3 products sold by quantity per year
create or replace view Top_Products as
select product_name, "Total Quantity Sold", "Year" from
(select p.product_name, sum(o.quantity) as "Total Quantity Sold", EXTRACT(YEAR from (orders.order_date)) as "Year",
rank() over (partition by EXTRACT(YEAR from (orders.order_date)) order by sum(o.quantity) desc) as rn
from product p
join order_items o on p.product_id = o.product_id
join orders on orders.order_id = o.order_id
group by p.product_name,orders.order_date,o.quantity) a
where a. rn <= 3;

select * from top_products;

-- View to get top 3 categories of product sold by quantity
Create or replace view Top_Categories as
select a.category_name, a.product_name, a.prodcount from
(select c.category_name, p.product_name, sum(o.quantity) as prodcount,
rank() over(partition by c.category_name order by sum(o.quantity) desc) as rn from Category c 
left join product p
on c.category_id = p.category_id
join order_items o on o.product_id = p.product_id
group by c.category_name, p.product_name) a
where rn in (1,2,3);

select * from top_categories;

--View to get inventory status and manufacture report to view products low on stock, quantity less than equal 20
CREATE OR REPLACE VIEW Inventory_status as
SELECT p.product_id,p.product_name,p.quantity as "Inventory",c.category_name,m.manufacturer_name from product p
inner join category c on p.category_id = c.category_id
inner join manufacturer m on p.manufacturer_id = m.manufacturer_id
where p.quantity <=20
order by p.quantity asc;

Select * from inventory_status;


-- Top customers by order amount
Create or replace view Top_Customers as
select c.customer_id,first_name, last_name,SUM(o.order_amount) as "Total Order Amount" from customer c
join orders o on o.customer_id = c.customer_id
group by c.customer_id,first_name,last_name
order by sum(o.order_amount) desc;

Select * from Top_Customers;

-- Top view total delivery count by delivery vendors
Create or replace view Delivery_Count as
select d.delivery_partner_id, d.delivery_partner_name,count(o.delivery_partner_id) as "Total Count" from delivery_partner d
join order_tracking o on o.delivery_partner_id = d.delivery_partner_id
group by d.delivery_partner_id, d.delivery_partner_name
order by count(o.delivery_partner_id) desc;

Select * from Delivery_Count;

-- Top manufacturer average ratings and total number of orders placed
CREATE OR REPLACE VIEW manufacturer_ratings AS
SELECT m.manufacturer_id, m.manufacturer_name, AVG(r.rating) as "AVG RATINGS", COUNT(oi.order_item_id) as "NO OF ORDERS PLACED",
CASE
    WHEN avg(r.rating) >= 1 AND avg(r.rating)  <=2.5 
        THEN 'LOW'
    WHEN avg(r.rating) >2.5 AND avg(r.rating) <= 4
        THEN 'MEDIUM'
    ELSE 
        'HIGH'
END CATEGORY
FROM reviews r ,order_items oi, product p, manufacturer m 
WHERE r.order_item_id = oi.order_item_id and oi.product_id = p.product_id 
AND p.manufacturer_id = m.manufacturer_id 
GROUP BY m.manufacturer_id, m.manufacturer_name, m.manufacturer_id ORDER BY AVG(r.rating) DESC;