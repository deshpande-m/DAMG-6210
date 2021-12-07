CREATE OR REPLACE PACKAGE c_utils AS
    
    -- create an Order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE
    );
    
END c_utils; 