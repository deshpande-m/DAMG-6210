/* Decrease inventory on placing an order */
CREATE OR REPLACE TRIGGER QUANTITYUPDATE 
AFTER INSERT ON ORDER_ITEMS 
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity - :new.quantity
    where product.product_id = :new.product_id;
END;

Insert into order_items (order_item_id,order_id,quantity, product_id)
values (4,21,2,4);

/* Increase inventory on canceling an order */
CREATE OR REPLACE TRIGGER INCREASEQUANTITYUPDATE  BEFORE DELETE ON ORDER_ITEMS
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity + :old.quantity
    where product.product_id = :old.product_id;
END;

DELETE FROM order_items WHERE order_item_id = 6;

/* Update delivery date to delivered date on orders when delivery status is set to delivered on tracking */
CREATE OR REPLACE TRIGGER DELIVERYDATEUPDATE
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
BEGIN
    UPDATE orders SET orders.delivery_datetime = SYSDATE where orders.order_id = :new.order_id and :new.delivery_status = 'DELIVERED';
END;

UPDATE order_tracking SET order_tracking.delivery_status = 'DELIVERED'
where order_tracking_id = 2;

/*  Update shipping date to shipped date on orders when delivery status is set to shipped on tracking */
CREATE OR REPLACE TRIGGER SHIPPINGDATEUPDATE
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
BEGIN
    UPDATE orders SET orders.shipping_date = SYSDATE where orders.order_id = :new.order_id and :new.delivery_status = 'SHIPPED';
END;

UPDATE order_tracking SET order_tracking.delivery_status = 'SHIPPED'
where order_tracking_id = 27;