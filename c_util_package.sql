CREATE OR REPLACE PACKAGE c_utils AS
    
    -- calculate shipping charges
    FUNCTION calculate_shipping_charges(c_shipping_type orders.shipping_type%TYPE) RETURN NUMBER;

    -- validating customer id
    FUNCTION validate_customer_id(c_customer_id customer.customer_id%TYPE) RETURN NUMBER;
    
    -- validating address id
    FUNCTION validate_address_id(c_address_id address.address_id%TYPE) RETURN NUMBER;

    -- validating order id
    FUNCTION validate_order_id(c_order_id orders.order_id%TYPE) RETURN NUMBER;
    
    -- validating product id
    FUNCTION validate_product_id(c_product_id order_items.product_id%TYPE) RETURN NUMBER;
    
    -- validating product quantity
    FUNCTION validate_product_qty(c_product_id order_items.product_id%TYPE) RETURN NUMBER;
    
    -- create an Order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE
    );

    -- create order items
    PROCEDURE create_order_items(
        c_order_id orders.order_id%TYPE,
        c_quantity order_items.quantity%TYPE,
        c_product_id order_items.product_id%TYPE
    );
    
END c_utils; 