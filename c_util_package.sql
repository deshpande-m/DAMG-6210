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

    -- fetching total order price based on order items and their quantity
    FUNCTION get_total_order_price(c_order_id orders.order_id%TYPE) RETURN NUMBER;
    
    -- fetching price of a product
    FUNCTION get_product_price(c_product_id order_items.product_id%TYPE) RETURN NUMBER;

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

    -- create transaction
    PROCEDURE create_transaction(
        c_order_id orders.order_id%TYPE
    );

    -- create order tracking
    PROCEDURE create_order_tracking(
        c_order_id orders.order_id%TYPE
    );

    -- update order tracking status
    PROCEDURE update_order_tracking_status(
        c_order_id orders.order_id%TYPE,
        c_status order_tracking.delivery_status%TYPE
    );

    -- update product details
    PROCEDURE update_product(
        c_product_id product.product_id%TYPE,
        c_type VARCHAR2,
        c_value VARCHAR2
    );
    
END c_utils; 