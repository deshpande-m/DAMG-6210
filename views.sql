-- View to get top 3 products sold by quantity per year
create or replace view Top_Products as
select p.product_name, sum(o.quantity) as "Total Quantity Sold", EXTRACT(YEAR from (orders.order_date)) as "Year"  from product p
join order_items o on p.product_id = o.product_id
join orders on orders.order_id = o.order_id
group by p.product_name,orders.order_date,o.quantity
order by 3 desc,2 desc;