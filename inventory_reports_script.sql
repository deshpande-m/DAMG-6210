-- View to get top 3 products sold by quantity per year
select * from top_products;
-- to verify
Select oi.product_id, sum(oi.quantity), EXTRACT(YEAR FROM (o.order_date)) AS "Year" from order_items oi join orders o on o.order_id = oi.order_id
group by oi.product_id, EXTRACT(YEAR FROM (o.order_date));

-- View to get top 3 categories of product sold by quantity
select * from top_categories;
-- to verify:
select sum(order_items.quantity) from order_items inner join product on order_items.product_id = product.product_id where product.category_id = 6;

--View to get inventory status and manufacture report to view products low on stock, quantity less than equal 20
Select * from inventory_status;
-- to verify:
select * from product where quantity < 20;

-- Top customers by order amount
Select * from Top_Customers;
-- to verify:
select SUM(order_amount) from orders where customer_id = 1;

-- Top view total delivery count by delivery vendors
Select * from Delivery_Count;
-- to verify:
select * from order_tracking where delivery_partner_id = 3;

-- Top manufacturer average ratings and total number of orders placed
Select * from manufacturer_ratings;
-- to verify
select * from product where manufacturer_id = 2;
select * from order_items where order_items.product_id IN (11, 12, 46, 47);
select avg(rating) from reviews where reviews.order_item_id IN (16, 17, 24, 31, 32, 44, 47, 51, 56, 84);
select count(*) from reviews where order_item_id IN (16, 17, 24, 31, 32, 44, 47, 51, 56, 84);

-- GET PRODUCT RECOMMENDATIONS
select * from table (inventory_utils.get_products_rec(2));
--to verify
select * from orders where customer_id = 2;
select * from order_items where order_items.order_id = 2;
select * from product where product_id = 6;
select * from product where category_id = 1;

-- get order details across inventory
SELECT * FROM inventory_order_details;