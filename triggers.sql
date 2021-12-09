/* Decrease inventory on placing an order */
CREATE OR REPLACE TRIGGER QUANTITYUPDATE 
AFTER INSERT ON ORDER_ITEMS 
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity - :new.quantity
    where product.product_id = :new.product_id;
END;

/* Increase inventory on canceling an order */
CREATE OR REPLACE TRIGGER INCREASEQUANTITYUPDATE  BEFORE DELETE ON ORDER_ITEMS
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity + :old.quantity
    where product.product_id = :old.product_id;
END;

/* Update delivery date to delivered date on orders when delivery status is set to delivered on tracking */
CREATE OR REPLACE TRIGGER DELIVERYDATEUPDATE
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
BEGIN
    UPDATE orders SET orders.delivery_datetime = SYSDATE where orders.order_id = :new.order_id and :new.delivery_status = 'DELIVERED';
END;