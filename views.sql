-- View to get top 3 products sold by quantity per year
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

--View to get inventory status and manufacture report to view products low on stock
CREATE OR REPLACE VIEW Inventory_status as
SELECT p.product_id,p.product_name,p.quantity as "Inventory",c.category_name,m.manufacturer_name from product p
inner join category c on p.category_id = c.category_id
inner join manufacturer m on p.manufacturer_id = m.manufacturer_id
order by p.quantity asc;

Select * from inventory_status;

