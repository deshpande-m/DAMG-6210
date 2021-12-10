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

    -- validating order id
    FUNCTION validate_order_id(c_order_id orders.order_id%TYPE) 
    RETURN NUMBER
    IS 
        is_order_id_valid NUMBER;
    BEGIN
        BEGIN
            SELECT order_id INTO is_order_id_valid FROM orders WHERE order_id = c_order_id;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                is_order_id_valid := 0;
        END;
        RETURN is_order_id_valid; 
    
    END validate_order_id;
    
    -- validating product id
    FUNCTION validate_product_id(c_product_id order_items.product_id%TYPE) 
    RETURN NUMBER
    IS 
        is_product_id_valid NUMBER;
    BEGIN
        BEGIN
            SELECT product_id INTO is_product_id_valid FROM product WHERE product_id = c_product_id;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                is_product_id_valid := 0;
        END;
        RETURN is_product_id_valid; 
    
    END validate_product_id;
    
    -- validating product quantity
    FUNCTION validate_product_qty(c_product_id order_items.product_id%TYPE) 
    RETURN NUMBER
    IS 
        c_product_qty NUMBER;
    BEGIN
        BEGIN
            SELECT quantity INTO c_product_qty FROM product WHERE product_id = c_product_id;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                c_product_qty := -1;
        END;
        RETURN c_product_qty; 
    
    END validate_product_qty;

    -- fetching price of a product
    FUNCTION get_product_price(c_product_id order_items.product_id%TYPE)
    RETURN NUMBER
    IS 
        c_product_price NUMBER;
    BEGIN
        SELECT price INTO c_product_price FROM product WHERE product_id = c_product_id;

        RETURN c_product_price; 
    
    END get_product_price;
    
    -- fetching total order price based on order items and their quantity
    FUNCTION get_total_order_price(c_order_id orders.order_id%TYPE) 
    RETURN NUMBER
    IS 
        c_total_price NUMBER;
        CURSOR order_items_rec IS 
        SELECT product_id, quantity FROM order_items WHERE order_id = c_order_id;
    BEGIN
        c_total_price := 0;
        FOR order_item in order_items_rec
        LOOP
            c_total_price := c_total_price + (get_product_price(order_item.product_id)*order_item.quantity);
        END LOOP;
        RETURN c_total_price; 
    
    END get_total_order_price;

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

    -- create order items
    PROCEDURE create_order_items(
        c_order_id orders.order_id%TYPE,
        c_quantity order_items.quantity%TYPE,
        c_product_id order_items.product_id%TYPE
    )
    AS
        ex_order_id_not_found EXCEPTION;
        ex_product_id_not_found EXCEPTION;
        ex_product_qty_zero EXCEPTION;
        ex_order_id_empty EXCEPTION;
        ex_quantity_empty EXCEPTION;
        
        ex_quantity_zero EXCEPTION;
        ex_quantity_invalid EXCEPTION;
        
        ex_product_id_empty EXCEPTION;
    BEGIN
        
        IF (TRIM(c_order_id) = '' or c_order_id is null) THEN
            RAISE ex_order_id_empty;
        ELSIF (TRIM(c_quantity) = '' or c_quantity is null) THEN
            RAISE ex_quantity_empty;
        ELSIF (TRIM(c_product_id) = '' or c_product_id is null) THEN
            RAISE ex_product_id_empty;
        END IF;
        
        IF (REGEXP_LIKE(c_quantity, '^[0-9]+$')) THEN
            IF c_quantity <= 0 THEN
                RAISE ex_quantity_zero;
            END IF;
        ELSE
            RAISE ex_quantity_invalid;
        END IF;
        
        IF validate_order_id(c_order_id) = 0 THEN
            RAISE ex_order_id_not_found;
        ELSIF validate_product_id(c_product_id) = 0 THEN
            RAISE ex_product_id_not_found;
        ELSIF validate_product_qty(c_product_id) = 0 THEN
            RAISE ex_product_qty_zero;
        END IF;
        
        INSERT INTO order_items (order_item_id, order_id, quantity, product_id)
        VALUES (order_item_seq.NEXTVAL, c_order_id, c_quantity, c_product_id);
        
    EXCEPTION
        WHEN ex_order_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order with the provided Id not found');
            ROLLBACK TO revert_created_order;
        WHEN ex_product_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Product with the provided Id not found');
            ROLLBACK TO revert_created_order;
        WHEN ex_product_qty_zero THEN
            DBMS_OUTPUT.PUT_LINE('Quantity of the selected product is 0');
            ROLLBACK TO revert_created_order;
        WHEN ex_quantity_zero THEN
            DBMS_OUTPUT.PUT_LINE('Quantity of the selected product can not be 0 or less than 0');
            ROLLBACK TO revert_created_order;
        WHEN ex_quantity_invalid THEN
            DBMS_OUTPUT.PUT_LINE('Quantity of the selected product is invalid');
            ROLLBACK TO revert_created_order;
        WHEN ex_order_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order id can not be null or empty');
            ROLLBACK TO revert_created_order;
        WHEN ex_quantity_empty THEN
            DBMS_OUTPUT.PUT_LINE('Quantity can not be null or empty');
            ROLLBACK TO revert_created_order;
        WHEN ex_product_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Product id can not be null or empty');
            ROLLBACK TO revert_created_order;
        
    END create_order_items;

    -- create transaction
    PROCEDURE create_transaction(
        c_order_id orders.order_id%TYPE
    )
    AS
        c_total_price NUMBER;
        c_shipping_charges NUMBER;
        ex_order_id_not_found EXCEPTION;
        ex_order_id_empty EXCEPTION;
    BEGIN
        
        IF (TRIM(c_order_id) = '' or c_order_id is null) THEN
            RAISE ex_order_id_empty;
        END IF;
        
        IF validate_order_id(c_order_id) = 0 THEN
            RAISE ex_order_id_not_found;
        END IF;
        
        SELECT shipping_charges INTO c_shipping_charges FROM orders WHERE order_id = c_order_id;
        
        c_total_price := get_total_order_price(c_order_id);
        
        INSERT INTO transaction (transaction_id, order_id, transaction_date, total_amount)
        VALUES (transaction_seq.NEXTVAL, c_order_id, SYSTIMESTAMP, c_total_price + c_shipping_charges);
        
        UPDATE orders SET order_amount = c_total_price WHERE order_id = c_order_id;
        
    EXCEPTION
        WHEN ex_order_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order with the provided Id not found');
            ROLLBACK TO revert_created_order;
        WHEN ex_order_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order id can not be null or empty');
            ROLLBACK TO revert_created_order;
        
    END create_transaction;

    -- create order tracking
    PROCEDURE create_order_tracking(
        c_order_id orders.order_id%TYPE
    )
    AS
        c_tracking_number order_tracking.tracking_number%TYPE;
        c_delivery_partner_id NUMBER;
        ex_order_id_not_found EXCEPTION;
        ex_order_id_empty EXCEPTION;
    BEGIN
        
        IF (TRIM(c_order_id) = '' or c_order_id is null) THEN
            RAISE ex_order_id_empty;
        END IF;
        
        IF validate_order_id(c_order_id) = 0 THEN
            RAISE ex_order_id_not_found;
        END IF;
        
        SELECT dbms_random.string('X',10) INTO c_tracking_number FROM dual;
        
        SELECT delivery_partner_id INTO c_delivery_partner_id FROM(SELECT delivery_partner_id FROM delivery_partner ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum = 1;
        
        INSERT INTO order_tracking (order_tracking_id, order_id, delivery_partner_id, delivery_status, tracking_number)
        VALUES (order_tracking_seq.NEXTVAL, c_order_id, c_delivery_partner_id, 'ORDER PLACED', c_tracking_number);
        
    EXCEPTION
        WHEN ex_order_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order with the provided Id not found');
            ROLLBACK TO revert_created_order;
        WHEN ex_order_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order id can not be null or empty');
            ROLLBACK TO revert_created_order;
        
    END create_order_tracking;

END c_utils; 