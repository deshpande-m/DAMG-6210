-- View to get top 3 products sold by quantity per year
select * from top_products;

-- View to get top 3 categories of product sold by quantity
select * from top_categories;

--View to get inventory status and manufacture report to view products low on stock, quantity less than equal 20
Select * from inventory_status;

-- Top customers by order amount
Select * from Top_Customers;

-- Top view total delivery count by delivery vendors
Select * from Delivery_Count;

-- Top manufacturer average ratings and total number of orders placed
Select * from manufacturer_ratings;

-- GET PRODUCT RECOMMENDATIONS
select * from table (inventory_utils.get_products_rec(10));

-- get order details across inventory
SELECT * FROM inventory_order_details;