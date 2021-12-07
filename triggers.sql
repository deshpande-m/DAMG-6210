CREATE OR REPLACE TRIGGER QUANTITYUPDATE 
AFTER INSERT ON ORDER_ITEMS 
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity - :new.quantity
    where product.product_id = :new.product_id;
END;