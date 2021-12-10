-- View to get top 3 products sold by quantity per year
create or replace view Top_Products as
select p.product_name, sum(o.quantity) as "Total Quantity Sold", EXTRACT(YEAR from (orders.order_date)) as "Year"  from product p
join order_items o on p.product_id = o.product_id
join orders on orders.order_id = o.order_id
group by p.product_name,orders.order_date,o.quantity
order by 3 desc,2 desc;

-- View to get top 3 categories of product sold by quantity
Create or replace view Top_Categories as
select c.category_name, p.product_name, sum(o.quantity) as "Total Quantity Sold" from Category c
join product p on c.category_id = p.product_id
join order_items o on o.product_id = p.product_id
group by c.category_name,p.product_name;

--View to get inventory status and manufacture report to view products low on stock
CREATE OR REPLACE VIEW Inventory_status as
SELECT p.product_id,p.product_name,p.quantity as "Inventory",c.category_name,m.manufacturer_name from product p
inner join category c on p.category_id = c.category_id
inner join manufacturer m on p.manufacturer_id = m.manufacturer_id
order by p.quantity asc;