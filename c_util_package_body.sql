CREATE OR REPLACE PACKAGE BODY c_utils AS
    
    -- create an order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE
    ) 
    AS
    BEGIN
        INSERT INTO orders (order_id, order_date, shipping_type, customer_id, shipping_charges, address_id)
        VALUES (c_order_id, SYSTIMESTAMP,c_shipping_type, c_customer_id, c_shipping_charges, c_address_id);
            
    END create_order;
   
END c_utils;