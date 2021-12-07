CREATE TRIGGER  QuantityUpdate
AFTER INSERT
   ON order_items FOR EACH ROW

BEGIN

UPDATE product
SET products.quantity = Products.quantity - New.quantity 
WHERE products.Product_ID = New.Product_ID ;

END;