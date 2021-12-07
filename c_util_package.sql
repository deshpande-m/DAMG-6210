CREATE OR REPLACE PACKAGE c_utils AS
    
    -- validating customer id
    FUNCTION validate_customer_id(c_customer_id customer.customer_id%TYPE) RETURN NUMBER;
    
    -- validating address id
    FUNCTION validate_address_id(c_address_id address.address_id%TYPE) RETURN NUMBER;
    
    -- create an Order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE
    );
    
END c_utils; 