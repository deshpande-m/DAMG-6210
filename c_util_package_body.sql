CREATE OR REPLACE PACKAGE BODY c_utils AS
    
    -- calculate shipping charges
    FUNCTION calculate_shipping_charges(c_shipping_type orders.shipping_type%TYPE) 
    RETURN NUMBER
    IS c_shipping_charges NUMBER;
    BEGIN 
        
        IF c_shipping_type = 'Standard' THEN
            c_shipping_charges := 0;
        ELSIF c_shipping_type = 'Express' THEN
            c_shipping_charges := 10;
        ELSE
            c_shipping_charges := -1;
        END IF;
        
        RETURN c_shipping_charges; 
    
    END calculate_shipping_charges;
    
    -- validating customer id
    FUNCTION validate_customer_id(c_customer_id customer.customer_id%TYPE) 
    RETURN NUMBER
    IS 
        is_customer_id_valid NUMBER;
        fetch_customer_id NUMBER;
        CURSOR customer_rec IS 
        SELECT customer_id FROM customer WHERE customer_id = c_customer_id;
    BEGIN 
        OPEN customer_rec;
        FETCH customer_rec INTO fetch_customer_id;
        IF customer_rec%FOUND THEN
            is_customer_id_valid := 1;
        ELSE
            is_customer_id_valid := 0;
        END IF;
        CLOSE customer_rec;
        
        RETURN is_customer_id_valid; 
    
    END validate_customer_id;
    
    -- validating address id
    FUNCTION validate_address_id(c_address_id address.address_id%TYPE) 
    RETURN NUMBER
    IS 
        is_address_id_valid NUMBER;
        fetch_address_id NUMBER;
        CURSOR address_rec IS 
        SELECT address_id FROM address WHERE address_id = c_address_id;
    BEGIN 
        OPEN address_rec;
        FETCH address_rec INTO fetch_address_id;
        IF address_rec%FOUND THEN
            is_address_id_valid := 1;
        ELSE
            is_address_id_valid := 0;
        END IF;
        CLOSE address_rec;
        
        RETURN is_address_id_valid; 
    
    END validate_address_id;

    -- create an order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE
    ) 
    AS
        ex_customer_not_found EXCEPTION;
        ex_address_not_found EXCEPTION;
        ex_shipping_type_not_valid EXCEPTION;
        
        ex_customer_id_empty EXCEPTION;
        ex_address_id_empty EXCEPTION;
        ex_shipping_type_empty EXCEPTION;
        
        c_shipping_charges NUMBER;
    BEGIN
        c_order_id := -1;
        
        IF (TRIM(c_customer_id) = '' or c_customer_id is null) THEN
            RAISE ex_customer_id_empty;
        ELSIF (TRIM(c_address_id) = '' or c_address_id is null) THEN
            RAISE ex_address_id_empty;
        ELSIF (TRIM(c_shipping_type) = '' or c_shipping_type is null) THEN
            RAISE ex_shipping_type_empty;
        END IF;
        
        c_shipping_charges := calculate_shipping_charges(c_shipping_type);
        
        SAVEPOINT revert_created_order;
        
        IF c_shipping_charges = -1 THEN
            RAISE ex_shipping_type_not_valid;
        END IF;
        
        IF validate_customer_id(c_customer_id) = 1 and validate_address_id(c_address_id) = 1 THEN
            c_order_id := orders_seq.NEXTVAL;
            INSERT INTO orders (order_id, order_date, shipping_type, customer_id, shipping_charges, address_id)
            VALUES (c_order_id, SYSTIMESTAMP,c_shipping_type, c_customer_id, c_shipping_charges, c_address_id);
            --COMMIT;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_customer_not_found;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_address_not_found;
        END IF;
        
    EXCEPTION
        WHEN ex_customer_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer with the provided Id not found');
        WHEN ex_address_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Address with the provided Id not found');
        WHEN ex_shipping_type_not_valid THEN
            DBMS_OUTPUT.PUT_LINE('Shipping type is invalid');
        WHEN ex_customer_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Customer id can not be null or empty');
        WHEN ex_address_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Address id can not be null or empty');
        WHEN ex_shipping_type_empty THEN
            DBMS_OUTPUT.PUT_LINE('Shipping type can not be null or empty');
            
    END create_order;