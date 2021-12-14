-- package declaration for creating tables and deleting records from the table
CREATE OR REPLACE PACKAGE create_delete_utils AS
    
    -- create tables
    PROCEDURE create_table(
        c_table_name VARCHAR2
    );

    -- create sequence
    PROCEDURE create_sequence(
        c_sequence_name VARCHAR2
    );

    -- delete table records
    PROCEDURE delete_records;

    --create type
    PROCEDURE create_type(
        c_type_name VARCHAR2
    );
    
END create_delete_utils;
/

-- package body for creating tables and deleting records from the table
CREATE OR REPLACE PACKAGE BODY create_delete_utils AS
    
    -- create sequence
    PROCEDURE create_sequence(
        c_sequence_name VARCHAR2
    )
    AS
        ex_sequence_not_found EXCEPTION;
        c_sequence_count NUMBER;
        c_upper_sequence_name VARCHAR(100);
    BEGIN
        c_upper_sequence_name := UPPER(c_sequence_name);
        SELECT count(*) INTO c_sequence_count FROM user_sequences where sequence_name = c_upper_sequence_name;

        IF c_sequence_count = 0 THEN
            IF c_upper_sequence_name = 'CUSTOMER_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE CUSTOMER_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'ADDRESS_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE ADDRESS_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'CATEGORY_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE CATEGORY_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'DELIVERY_PARTNER_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE DELIVERY_PARTNER_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'MANUFACTURER_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE MANUFACTURER_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'ORDER_ITEM_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE ORDER_ITEM_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'ORDER_TRACKING_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE ORDER_TRACKING_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'ORDERS_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE ORDERS_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'PRODUCT_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE PRODUCT_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'REVIEWS_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE REVIEWS_SEQ START WITH 1';

            ELSIF c_upper_sequence_name = 'TRANSACTION_SEQ' THEN
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE TRANSACTION_SEQ START WITH 1';
            ELSE 
                RAISE ex_sequence_not_found;
            END IF;
        END IF;

    EXCEPTION
        WHEN ex_sequence_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Sequence name is invalid');

    END create_sequence;

    -- create tables
    PROCEDURE create_table(
        c_table_name VARCHAR2
    )
    AS
        ex_table_not_found EXCEPTION;
        c_user_id VARCHAR(100);
        c_count NUMBER;
        c_upper_table_name VARCHAR(100);
    BEGIN

        c_user_id := USER;
        c_upper_table_name := UPPER(c_table_name);
        SELECT count(1) INTO c_count FROM dba_tables where table_name = c_upper_table_name and OWNER = c_user_id;
        
        IF c_count = 0 THEN
            IF c_upper_table_name = 'CUSTOMER' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE customer (
                    customer_id NUMBER PRIMARY KEY,
                    first_name VARCHAR2(50),
                    last_name VARCHAR2(50),
                    date_of_birth DATE,
                    email VARCHAR2(50),
                    is_active NUMBER 
                )';
                
            ELSIF c_upper_table_name = 'ADDRESS' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE address (
                    address_id NUMBER PRIMARY KEY,
                    customer_id NUMBER,
                    CONSTRAINT fkey_address_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
                    address_1 VARCHAR2(50),
                    address_2 VARCHAR2(50),
                    city VARCHAR2(50),
                    state VARCHAR2(50),
                    zip NUMBER,
                    country VARCHAR2(50)
                )';
                
            ELSIF c_upper_table_name = 'CATEGORY' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE category (
                    category_id NUMBER PRIMARY KEY,
                    category_name VARCHAR2(50),
                    category_desc VARCHAR2(100)
                )';
                
            ELSIF c_upper_table_name = 'MANUFACTURER' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE manufacturer (
                    manufacturer_id NUMBER PRIMARY KEY,
                    manufacturer_name VARCHAR2(50),
                    manufacturer_desc VARCHAR2(100)
                )';
                
            ELSIF c_upper_table_name = 'PRODUCT' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE product (
                    product_id NUMBER PRIMARY KEY,
                    product_name VARCHAR2(50),
                    quantity NUMBER,
                    price NUMBER,
                    category_id NUMBER,
                    manufacturer_id NUMBER,
                    CONSTRAINT fkey_product_category_id FOREIGN KEY(category_id) REFERENCES category(category_id) ON DELETE CASCADE,
                    CONSTRAINT fkey_product_manufacturer_id FOREIGN KEY(manufacturer_id) REFERENCES manufacturer(manufacturer_id) ON DELETE CASCADE,
                    is_active NUMBER
                )';
                
            ELSIF c_upper_table_name = 'DELIVERY_PARTNER' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE delivery_partner (
                    delivery_partner_id NUMBER PRIMARY KEY,
                    delivery_partner_name VARCHAR2(50)
                )';
                
            ELSIF c_upper_table_name = 'ORDERS' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE orders (
                    order_id NUMBER PRIMARY KEY,
                    order_date DATE,
                    shipping_date DATE,
                    shipping_type VARCHAR2(50),
                    order_amount NUMBER,
                    customer_id NUMBER,
                    shipping_charges NUMBER,
                    address_id NUMBER,
                    delivery_datetime TIMESTAMP(6),
                    CONSTRAINT fkey_order_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
                    CONSTRAINT fkey_order_address_id FOREIGN KEY(address_id) REFERENCES address(address_id) ON DELETE CASCADE
                )';
                
            ELSIF c_upper_table_name = 'ORDER_ITEMS' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE order_items (
                    order_item_id NUMBER PRIMARY KEY,
                    order_id NUMBER,
                    quantity NUMBER,
                    product_id NUMBER,
                    CONSTRAINT fkey_order_items_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id),
                    CONSTRAINT fkey_order_items_product_id FOREIGN KEY(product_id) REFERENCES product(product_id)
                )';

            ELSIF c_upper_table_name = 'TRANSACTION' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE transaction (
                    transaction_id NUMBER PRIMARY KEY,
                    order_id NUMBER,
                    transaction_date DATE,
                    total_amount NUMBER,
                    payment_method VARCHAR2(50),
                    CONSTRAINT fkey_transaction_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE
                )';

                EXECUTE IMMEDIATE
                'CREATE INDEX transaction_order_id_I ON TRANSACTION (order_id)';
                
            ELSIF c_upper_table_name = 'ORDER_TRACKING' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE order_tracking (
                    order_tracking_id NUMBER PRIMARY KEY,
                    order_id NUMBER,
                    delivery_partner_id NUMBER,
                    delivery_date DATE,
                    delivery_status VARCHAR2(50),
                    tracking_number VARCHAR2(50),
                    CONSTRAINT fkey_order_tracking_delivery_partner_id FOREIGN KEY(delivery_partner_id) REFERENCES delivery_partner(delivery_partner_id) ON DELETE CASCADE,
                    CONSTRAINT fkey_order_tracking_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE
                )';
                
                EXECUTE IMMEDIATE
                'CREATE INDEX order_tracking_tracking_number_I ON ORDER_TRACKING (tracking_number)';
                
                EXECUTE IMMEDIATE
                'CREATE INDEX order_tracking_order_id_I ON ORDER_TRACKING (order_id)';

            ELSIF c_upper_table_name = 'REVIEWS' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE reviews (
                    review_id NUMBER PRIMARY KEY,
                    order_item_id NUMBER,
                    review VARCHAR2(100),
                    review_date DATE,
                    rating NUMBER,
                    CONSTRAINT fkey_reviews_order_item_id FOREIGN KEY(order_item_id) REFERENCES order_items(order_item_id) ON DELETE CASCADE
                )';

                EXECUTE IMMEDIATE
                'CREATE INDEX reviews_order_item_id_I ON REVIEWS (order_item_id)';
                
            ELSE 
                RAISE ex_table_not_found;
            END IF;
            
        END IF;
        
    EXCEPTION
        WHEN ex_table_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Table name is invalid');
            
    END create_table;

    -- delete table records
    PROCEDURE delete_records
    AS
        c_value VARCHAR2(20);
    BEGIN
        -- disabling constraints
        EXECUTE IMMEDIATE
        'ALTER TABLE address DISABLE CONSTRAINT fkey_address_customer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE product DISABLE CONSTRAINT fkey_product_category_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE product DISABLE CONSTRAINT fkey_product_manufacturer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE orders DISABLE CONSTRAINT fkey_order_customer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE orders DISABLE CONSTRAINT fkey_order_address_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_items DISABLE CONSTRAINT fkey_order_items_order_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_items DISABLE CONSTRAINT fkey_order_items_product_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_tracking DISABLE CONSTRAINT fkey_order_tracking_delivery_partner_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE reviews DISABLE CONSTRAINT fkey_reviews_order_item_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE transaction DISABLE CONSTRAINT fkey_transaction_order_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_tracking DISABLE CONSTRAINT fkey_order_tracking_order_id';
        
        -- deleting records
        EXECUTE IMMEDIATE
        'DELETE FROM customer';
        
        EXECUTE IMMEDIATE
        'DELETE FROM address';
        
        EXECUTE IMMEDIATE
        'DELETE FROM category';
        
        EXECUTE IMMEDIATE
        'DELETE FROM manufacturer';
        
        EXECUTE IMMEDIATE
        'DELETE FROM product';
        
        EXECUTE IMMEDIATE
        'DELETE FROM delivery_partner';
        
        EXECUTE IMMEDIATE
        'DELETE FROM orders';
        
        EXECUTE IMMEDIATE
        'DELETE FROM order_items';
        
        EXECUTE IMMEDIATE
        'DELETE FROM transaction';
        
        EXECUTE IMMEDIATE
        'DELETE FROM order_tracking';
        
        EXECUTE IMMEDIATE
        'DELETE FROM reviews';
        
        -- enabling constraints
        EXECUTE IMMEDIATE
        'ALTER TABLE address ENABLE CONSTRAINT fkey_address_customer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE product ENABLE CONSTRAINT fkey_product_category_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE product ENABLE CONSTRAINT fkey_product_manufacturer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE orders ENABLE CONSTRAINT fkey_order_customer_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE orders ENABLE CONSTRAINT fkey_order_address_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_items ENABLE CONSTRAINT fkey_order_items_order_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_items ENABLE CONSTRAINT fkey_order_items_product_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_tracking ENABLE CONSTRAINT fkey_order_tracking_delivery_partner_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE reviews ENABLE CONSTRAINT fkey_reviews_order_item_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE transaction ENABLE CONSTRAINT fkey_transaction_order_id';
        
        EXECUTE IMMEDIATE
        'ALTER TABLE order_tracking ENABLE CONSTRAINT fkey_order_tracking_order_id';
        
        -- resetting sequence
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE customer_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE address_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE category_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE manufacturer_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE product_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE delivery_partner_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE orders_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE order_item_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE transaction_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE order_tracking_seq RESTART';
        
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE reviews_seq RESTART';
        
    END delete_records;
    
    
    PROCEDURE create_type(
        c_type_name VARCHAR2
    )
    AS
        c_count NUMBER;
        ex_type_not_found EXCEPTION;
    BEGIN
        SELECT count(1) INTO c_count FROM dba_types where type_name = c_type_name;
        IF c_count = 0 THEN
            IF c_type_name = 'PRODUCT_OBJ' THEN
                EXECUTE IMMEDIATE
                'create type PRODUCT_OBJ as object(
                    product_id number,
                    product_name varchar2(50),
                    category_name varchar2(50)
                )';

            ELSIF c_type_name = 'PRODUCT_REC' THEN
                EXECUTE IMMEDIATE
                'create type PRODUCT_REC as table of PRODUCT_OBJ';
            ELSE 
                RAISE ex_type_not_found;
            END IF;    
        END IF;
    EXCEPTION
        WHEN ex_type_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Type name is invalid');
            
    END create_type;
END create_delete_utils;
/

-- script to create tables if doesnt exist
BEGIN
    create_delete_utils.create_sequence('CUSTOMER_SEQ');
    create_delete_utils.create_sequence('ADDRESS_SEQ');
    create_delete_utils.create_sequence('CATEGORY_SEQ');
    create_delete_utils.create_sequence('MANUFACTURER_SEQ');
    create_delete_utils.create_sequence('PRODUCT_SEQ');
    create_delete_utils.create_sequence('DELIVERY_PARTNER_SEQ');
    create_delete_utils.create_sequence('ORDERS_SEQ');
    create_delete_utils.create_sequence('ORDER_ITEM_SEQ');
    create_delete_utils.create_sequence('TRANSACTION_SEQ');
    create_delete_utils.create_sequence('ORDER_TRACKING_SEQ');
    create_delete_utils.create_sequence('REVIEWS_SEQ');
    create_delete_utils.create_table('CUSTOMER');
    create_delete_utils.create_table('ADDRESS');
    create_delete_utils.create_table('CATEGORY');
    create_delete_utils.create_table('MANUFACTURER');
    create_delete_utils.create_table('PRODUCT');
    create_delete_utils.create_table('DELIVERY_PARTNER');
    create_delete_utils.create_table('ORDERS');
    create_delete_utils.create_table('ORDER_ITEMS');
    create_delete_utils.create_table('TRANSACTION');
    create_delete_utils.create_table('ORDER_TRACKING');
    create_delete_utils.create_table('REVIEWS');
    create_delete_utils.create_type('PRODUCT_OBJ');
    create_delete_utils.create_type('PRODUCT_REC');
END;
/

-- package declaration to insert and create records with other business logics
CREATE OR REPLACE PACKAGE inventory_utils AS
    
    -- calculate shipping charges
    FUNCTION calculate_shipping_charges(c_shipping_type orders.shipping_type%TYPE) RETURN NUMBER;

    -- validating customer id
    FUNCTION validate_customer_id(c_customer_id customer.customer_id%TYPE) RETURN NUMBER;
    
    -- validating address id
    FUNCTION validate_address_id(c_address_id address.address_id%TYPE) RETURN NUMBER;

    -- validating order id
    FUNCTION validate_order_id(c_order_id orders.order_id%TYPE) RETURN NUMBER;
    
    -- validating order item id
    FUNCTION validate_order_item_id(c_order_item_id reviews.order_item_id%TYPE) RETURN NUMBER;
    
    -- validating product id
    FUNCTION validate_product_id(c_product_id order_items.product_id%TYPE) RETURN NUMBER;
    
    -- validating product quantity
    FUNCTION validate_product_qty(c_product_id order_items.product_id%TYPE) RETURN NUMBER;

    -- fetching total order price based on order items and their quantity
    FUNCTION get_total_order_price(c_order_id orders.order_id%TYPE) RETURN NUMBER;
    
    -- fetching price of a product
    FUNCTION get_product_price(c_product_id order_items.product_id%TYPE) RETURN NUMBER;

    -- get product recommendations
    FUNCTION get_products_rec(c_product_id NUMBER) RETURN product_rec;
    
    -- check if customer is active or not
    FUNCTION is_customer_active(c_customer_id customer.customer_id%TYPE) RETURN NUMBER;
    
    -- check if a product is active or not
    FUNCTION is_product_active(c_product_id order_items.product_id%TYPE) RETURN NUMBER;

    -- create an Order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE,
        c_order_date orders.order_date%TYPE
    );

    -- create order items
    PROCEDURE create_order_items(
        c_order_id orders.order_id%TYPE,
        c_quantity order_items.quantity%TYPE,
        c_product_id order_items.product_id%TYPE
    );

    -- create transaction
    PROCEDURE create_transaction(
        c_order_id orders.order_id%TYPE,
        c_payment_method transaction.payment_method%TYPE,
        c_order_date orders.order_date%TYPE
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
    
    -- inactivate customer
    PROCEDURE inactivate_customer(
        c_customer_id product.product_id%TYPE
    );
    
    -- activate customer
    PROCEDURE activate_customer(
        c_customer_id product.product_id%TYPE
    );
    
    -- inactivate product
    PROCEDURE inactivate_product(
        c_product_id product.product_id%TYPE
    );
    
    -- activate product
    PROCEDURE activate_product(
        c_product_id product.product_id%TYPE
    );

    -- insert customer
    PROCEDURE insert_customer( 
        p_first_name  customer.first_name%TYPE,
        p_last_name  customer.last_name%TYPE,
        p_date_of_birth  customer.date_of_birth%TYPE,
        p_email  customer.email%TYPE,
        p_is_active  customer.is_active%TYPE,
        c_customer_id OUT customer.customer_id%TYPE
    );
    
    -- insert address
    PROCEDURE insert_address( 
        p_address_id OUT address.address_id%TYPE,
        p_customer_id  address.customer_id%TYPE,
        p_address_1 address.address_1%TYPE,
        p_address_2 address.address_2%TYPE,
        p_city address.city%TYPE,
        p_state address.state%TYPE,
        p_zip address.zip%TYPE,
        p_country address.country%TYPE   
    );
    
    -- insert category
    PROCEDURE insert_category( 
        p_category_id OUT Category.category_id%TYPE,
        p_category_name  Category.category_name%TYPE,
        p_category_desc Category.category_desc%TYPE   
    );
    
    --insert manufacturer
    PROCEDURE insert_manufacturer( 
        p_MANUFACTURER_id OUT MANUFACTURER.MANUFACTURER_id%TYPE,
        p_MANUFACTURER_name  MANUFACTURER.MANUFACTURER_name%TYPE,
        p_MANUFACTURER_desc MANUFACTURER.MANUFACTURER_desc%TYPE
    );
    
    --insert product
    PROCEDURE insert_product( 
        p_product_id OUT product.product_id%TYPE,
        p_name product.product_name%TYPE,
        p_quantity product.quantity%TYPE,
        p_price product.price%TYPE,
        p_category_id product.category_id%TYPE,
        p_manufacturer_id product.manufacturer_id%TYPE,
        p_is_active product.is_active%TYPE  
    );
    
    --insert delivery partner
    PROCEDURE insert_delivery_partner( 
        P_delivery_partner_id OUT DELIVERY_PARTNER.DELIVERY_PARTNER_ID%TYPE,
        P_delivery_partner_name DELIVERY_PARTNER.DELIVERY_PARTNER_NAME%TYPE 
    );

    --insert reviews
    PROCEDURE insert_reviews( 
        c_order_item_id reviews.order_item_id%TYPE,
        c_review_notes reviews.review%TYPE,
        c_rating reviews.rating%TYPE
    );
    
END inventory_utils;
/

CREATE OR REPLACE PACKAGE BODY inventory_utils AS
    
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
    
    -- validating order id
    FUNCTION validate_order_item_id(c_order_item_id reviews.order_item_id%TYPE) 
    RETURN NUMBER
    IS 
        is_order_item_id_valid NUMBER;
    BEGIN
        BEGIN
            SELECT order_item_id INTO is_order_item_id_valid FROM order_items WHERE order_item_id = c_order_item_id;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                is_order_item_id_valid := 0;
        END;
        RETURN is_order_item_id_valid; 
    
    END validate_order_item_id;
    
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

    -- get product recommendation
    FUNCTION get_products_rec (c_product_id NUMBER)
        RETURN product_rec
    AS
        return_value product_rec;
    BEGIN
        SELECT product_obj(product_id, product_name, category_name)
        bulk collect INTO return_value      
        FROM product p
        INNER JOIN category c
        ON p.category_id = c.category_id
        WHERE c.category_id = (SELECT DISTINCT category_id FROM product WHERE product_id = c_product_id);
        RETURN return_value;
    END get_products_rec;
    
    -- check if customer is active or not
    FUNCTION is_customer_active(c_customer_id customer.customer_id%TYPE) 
    RETURN NUMBER
    IS 
        c_is_customer_active NUMBER;
    BEGIN
        SELECT is_active INTO c_is_customer_active FROM customer WHERE customer_id = c_customer_id;

        RETURN c_is_customer_active; 
    
    END is_customer_active;
    
    -- check if a product is active or not
    FUNCTION is_product_active(c_product_id order_items.product_id%TYPE) 
    RETURN NUMBER
    IS 
        c_is_product_active NUMBER;
    BEGIN
        SELECT is_active INTO c_is_product_active FROM product WHERE product_id = c_product_id;

        RETURN c_is_product_active; 
    
    END is_product_active;
    
    -- create an order 
    PROCEDURE create_order(
        c_customer_id customer.customer_id%TYPE,
        c_address_id address.address_id%TYPE,
        c_shipping_type orders.shipping_type%TYPE,
        c_order_id OUT orders.order_id%TYPE,
        c_order_date orders.order_date%TYPE
    ) 
    AS
        ex_customer_not_found EXCEPTION;
        ex_address_not_found EXCEPTION;
        ex_shipping_type_not_valid EXCEPTION;
        
        ex_customer_id_empty EXCEPTION;
        ex_address_id_empty EXCEPTION;
        ex_shipping_type_empty EXCEPTION;
        ex_address_not_corresponds_to_customer EXCEPTION;
        ex_customer_not_active EXCEPTION;
        c_shipping_charges NUMBER;
        p_customer_id NUMBER;
    BEGIN
        c_order_id := -1;
        p_customer_id := 0;
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
        
        IF validate_customer_id(c_customer_id) = 1 and validate_address_id(c_address_id) = 1 and is_customer_active(c_customer_id) = 1 THEN
        
            SELECT customer_id INTO p_customer_id FROM address WHERE address_id = c_address_id;
            IF p_customer_id = c_customer_id THEN
                c_order_id := orders_seq.NEXTVAL;
                IF (c_order_date = '' or c_order_date is null) THEN
                    INSERT INTO orders (order_id, order_date, shipping_type, customer_id, shipping_charges, address_id)
                    VALUES (c_order_id, SYSTIMESTAMP,c_shipping_type, c_customer_id, c_shipping_charges, c_address_id);
                ELSE
                    INSERT INTO orders (order_id, order_date, shipping_type, customer_id, shipping_charges, address_id)
                    VALUES (c_order_id, c_order_date,c_shipping_type, c_customer_id, c_shipping_charges, c_address_id);
                END IF;
            ELSE
                RAISE ex_address_not_corresponds_to_customer;
            END IF;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_customer_not_found;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_address_not_found;
        ELSIF is_customer_active(c_customer_id) = 0 THEN
            RAISE ex_customer_not_active;
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
        WHEN ex_address_not_corresponds_to_customer THEN
            DBMS_OUTPUT.PUT_LINE('Adress Id provided doesnt belong to the customer id passed while creating order');
        WHEN ex_customer_not_active THEN
            DBMS_OUTPUT.PUT_LINE('Customer is inactive');     
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
        ex_ordered_qty_exceeds EXCEPTION;
        ex_product_id_empty EXCEPTION;
        ex_transaction_already_present EXCEPTION;
        ex_product_id_not_active EXCEPTION;
        c_transaction_count NUMBER;
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
        ELSIF is_product_active(c_product_id) = 0 THEN
            RAISE ex_product_id_not_active;
        ELSIF validate_product_qty(c_product_id) = 0 THEN
            RAISE ex_product_qty_zero;
        ELSIF c_quantity > validate_product_qty(c_product_id) THEN
            RAISE ex_ordered_qty_exceeds;
        END IF;
        
        SELECT COUNT(1) INTO c_transaction_count FROM transaction WHERE order_id = c_order_id;
        
        IF c_transaction_count > 0 THEN
            RAISE ex_transaction_already_present;
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
        WHEN ex_ordered_qty_exceeds THEN
            DBMS_OUTPUT.PUT_LINE('The quantity of the product ordered is greater than the current quantity of product');
            ROLLBACK TO revert_created_order;
        WHEN ex_transaction_already_present THEN
            DBMS_OUTPUT.PUT_LINE('Order item can not be added as transaction for this order has already been done. Please create a new order');
        WHEN ex_product_id_not_active THEN
            DBMS_OUTPUT.PUT_LINE('Product id is not active'); 
            ROLLBACK TO revert_created_order;        
        
    END create_order_items;

    -- create transaction
    PROCEDURE create_transaction(
        c_order_id orders.order_id%TYPE,
        c_payment_method transaction.payment_method%TYPE,
        c_order_date orders.order_date%TYPE
    )
    AS
        c_total_price NUMBER;
        c_shipping_charges NUMBER;
        ex_order_id_not_found EXCEPTION;
        ex_order_id_empty EXCEPTION;
        ex_payment_method_empty EXCEPTION;
    BEGIN
        
        IF (TRIM(c_order_id) = '' or c_order_id is null) THEN
            RAISE ex_order_id_empty;
        ELSIF (TRIM(c_payment_method) = '' or c_payment_method is null) THEN
            RAISE ex_payment_method_empty;
        END IF;
        
        IF validate_order_id(c_order_id) = 0 THEN
            RAISE ex_order_id_not_found;
        END IF;
        
        SELECT shipping_charges INTO c_shipping_charges FROM orders WHERE order_id = c_order_id;
        
        c_total_price := get_total_order_price(c_order_id);
        
        IF (c_order_date = '' or c_order_date is null) THEN
            INSERT INTO transaction (transaction_id, order_id, transaction_date, total_amount, payment_method)
        VALUES (transaction_seq.NEXTVAL, c_order_id, SYSTIMESTAMP, c_total_price + c_shipping_charges, c_payment_method);
        ELSE
            INSERT INTO transaction (transaction_id, order_id, transaction_date, total_amount, payment_method)
        VALUES (transaction_seq.NEXTVAL, c_order_id, c_order_date, c_total_price + c_shipping_charges, c_payment_method);
        END IF;
        
        UPDATE orders SET order_amount = c_total_price WHERE order_id = c_order_id;
        
    EXCEPTION
        WHEN ex_order_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order with the provided Id not found');
            ROLLBACK TO revert_created_order;
        WHEN ex_order_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order id can not be null or empty');
            ROLLBACK TO revert_created_order;
        WHEN ex_payment_method_empty THEN
            DBMS_OUTPUT.PUT_LINE('Payment method can not be null or empty');
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

    -- update order tracking status
    PROCEDURE update_order_tracking_status(
        c_order_id orders.order_id%TYPE,
        c_status order_tracking.delivery_status%TYPE
    )
    
    AS
        ex_order_id_not_found EXCEPTION;
        ex_order_id_empty EXCEPTION;
        ex_status_empty EXCEPTION;
        ex_status_invalid EXCEPTION;
        ex_shipping_status_change_exception EXCEPTION;
        c_delivery_status VARCHAR2(50);
    BEGIN
        
        IF (TRIM(c_order_id) = '' or c_order_id is null) THEN
            RAISE ex_order_id_empty;
        ELSIF (TRIM(c_status) = '' or c_status is null) THEN
            RAISE ex_status_empty;
        END IF;
        
        IF validate_order_id(c_order_id) = 0 THEN
            RAISE ex_order_id_not_found;
        END IF;
        
        IF c_status != 'SHIPPED' and c_status != 'IN TRANSIT' and c_status != 'OUT FOR DELIVERY' and c_status != 'DELIVERED' and c_status != 'CANCELLED' THEN
            RAISE ex_status_invalid;
        END IF;
        
        SELECT delivery_status INTO c_delivery_status FROM order_tracking WHERE order_id = c_order_id;
        
        IF c_delivery_status = 'IN TRANSIT' and c_status = 'SHIPPED' THEN
            RAISE ex_shipping_status_change_exception;
        ELSIF c_delivery_status = 'OUT FOR DELIVERY' and (c_status = 'SHIPPED' or c_status = 'IN TRANSIT')  THEN
            RAISE ex_shipping_status_change_exception;
        ELSIF c_delivery_status = 'DELIVERED' and (c_status = 'SHIPPED' or c_status = 'OUT FOR DELIVERY' or c_status = 'IN TRANSIT')  THEN
            RAISE ex_shipping_status_change_exception;
        ELSIF c_delivery_status = 'CANCELLED' and (c_status = 'SHIPPED' or c_status = 'OUT FOR DELIVERY' or c_status = 'IN TRANSIT' or c_status = 'DELIVERED')  THEN
            RAISE ex_shipping_status_change_exception;
        END IF;
        
        UPDATE order_tracking SET delivery_status = c_status WHERE order_id = c_order_id;
        
        IF c_status = 'DELIVERED' THEN
            UPDATE order_tracking SET delivery_date = SYSTIMESTAMP WHERE order_id = c_order_id;
        END IF;
        
    EXCEPTION
        WHEN ex_order_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order with the provided Id not found');
        WHEN ex_order_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order id can not be null or empty');
        WHEN ex_status_empty THEN
            DBMS_OUTPUT.PUT_LINE('Status can not be empty');
        WHEN ex_status_invalid THEN
            DBMS_OUTPUT.PUT_LINE('Provided status in invalid. Valid values are SHIPPED, IN TRANSIT, OUT FOR DELIVERY, DELIVERED, CANCELLED');
        WHEN ex_shipping_status_change_exception THEN
            DBMS_OUTPUT.PUT_LINE('Shipping status can not be changed from ' || c_delivery_status || ' to ' || c_status);
            
    END update_order_tracking_status;

    -- update product details
    PROCEDURE update_product(
        c_product_id product.product_id%TYPE,
        c_type VARCHAR2,
        c_value VARCHAR2
    )
    AS
        ex_product_id_empty EXCEPTION;
        ex_type_empty EXCEPTION;
        ex_value_empty EXCEPTION;
        ex_product_id_not_found EXCEPTION;
        ex_invalid_value EXCEPTION;
        ex_product_id_not_active EXCEPTION;
    BEGIN
        
        IF (TRIM(c_product_id) = '' or c_product_id is null) THEN
            RAISE ex_product_id_empty;
        ELSIF (TRIM(c_type) = '' or c_type is null) THEN
            RAISE ex_type_empty;
        ELSIF (TRIM(c_value) = '' or c_value is null) THEN
            RAISE ex_value_empty;
        END IF;
        
        IF validate_product_id(c_product_id) = 0 THEN
            RAISE ex_product_id_not_found;
        ELSIF is_product_active(c_product_id) = 0 THEN
            RAISE ex_product_id_not_active;
        END IF;
        
        IF c_type != 'Quantity' and c_type != 'Price' and c_type != 'Name' THEN
            RAISE ex_invalid_value;
        END IF;
        
        IF c_type = 'Quantity' THEN
            UPDATE product SET quantity = TO_NUMBER(c_value) WHERE product_id = c_product_id;
        ELSIF c_type = 'Price' THEN
            UPDATE product SET price = TO_NUMBER(c_value) WHERE product_id = c_product_id;
        ELSIF c_type = 'Name' THEN
            UPDATE product SET product_name = c_value WHERE product_id = c_product_id;
        END IF;
        
    EXCEPTION
        WHEN ex_product_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Product id can not be null or empty');
        WHEN ex_type_empty THEN
            DBMS_OUTPUT.PUT_LINE('Type can not be null or empty');
        WHEN ex_value_empty THEN
            DBMS_OUTPUT.PUT_LINE('Value can not be empty');
        WHEN ex_product_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Product Id can not be found');
        WHEN ex_invalid_value THEN
            DBMS_OUTPUT.PUT_LINE('Provided value in invalid. Valid values are Quantity, Price, Name');
        WHEN ex_product_id_not_active THEN
            DBMS_OUTPUT.PUT_LINE('Product id is inactive');
            
    END update_product;
    
    -- inactivate customer
    PROCEDURE inactivate_customer(
        c_customer_id product.product_id%TYPE
    )
    AS
        ex_customer_id_empty EXCEPTION;
        ex_customer_id_not_found EXCEPTION;
    BEGIN
        
        IF (TRIM(c_customer_id) = '' or c_customer_id is null) THEN
            RAISE ex_customer_id_empty;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_customer_id_not_found;
        END IF;
        
            UPDATE customer SET is_active = 0 WHERE customer_id = c_customer_id;
        
    EXCEPTION
        WHEN ex_customer_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Customer id can not be null or empty');
        WHEN ex_customer_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer Id can not be found');
            
    END inactivate_customer;
    
    -- activate customer
    PROCEDURE activate_customer(
        c_customer_id product.product_id%TYPE
    )
    AS
        ex_customer_id_empty EXCEPTION;
        ex_customer_id_not_found EXCEPTION;
    BEGIN
        
        IF (TRIM(c_customer_id) = '' or c_customer_id is null) THEN
            RAISE ex_customer_id_empty;
        ELSIF validate_customer_id(c_customer_id) = 0 THEN
            RAISE ex_customer_id_not_found;
        END IF;
        
            UPDATE customer SET is_active = 1 WHERE customer_id = c_customer_id;
        
    EXCEPTION
        WHEN ex_customer_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Customer id can not be null or empty');
        WHEN ex_customer_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer Id can not be found');
            
    END activate_customer;
    
    -- inactivate product
    PROCEDURE inactivate_product(
        c_product_id product.product_id%TYPE
    )
    AS
        ex_product_id_empty EXCEPTION;
        ex_product_id_not_found EXCEPTION;
    BEGIN
        
        IF (TRIM(c_product_id) = '' or c_product_id is null) THEN
            RAISE ex_product_id_empty;
        ELSIF validate_product_id(c_product_id) = 0 THEN
            RAISE ex_product_id_not_found;
        END IF;
        
            UPDATE product SET is_active = 0 WHERE product_id = c_product_id;
        
    EXCEPTION
        WHEN ex_product_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Product id can not be null or empty');
        WHEN ex_product_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Product Id can not be found');
            
    END inactivate_product;
    
    -- activate product
    PROCEDURE activate_product(
        c_product_id product.product_id%TYPE
    )
    AS
        ex_product_id_empty EXCEPTION;
        ex_product_id_not_found EXCEPTION;
    BEGIN
        
        IF (TRIM(c_product_id) = '' or c_product_id is null) THEN
            RAISE ex_product_id_empty;
        ELSIF validate_product_id(c_product_id) = 0 THEN
            RAISE ex_product_id_not_found;
        END IF;
        
            UPDATE product SET is_active = 1 WHERE product_id = c_product_id;
        
    EXCEPTION
        WHEN ex_product_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Product id can not be null or empty');
        WHEN ex_product_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Product Id can not be found');
            
    END activate_product;

    -- insert customer
    PROCEDURE insert_customer( 
        p_first_name  customer.first_name%TYPE,
        p_last_name  customer.last_name%TYPE,
        p_date_of_birth  customer.date_of_birth%TYPE,
        p_email  customer.email%TYPE,
        p_is_active  customer.is_active%TYPE,
        c_customer_id OUT customer.customer_id%TYPE
    )
    AS
        ex_first_name_not_found EXCEPTION;
        ex_last_name_not_found EXCEPTION;
        ex_email_empty EXCEPTION;
        ex_active_status_invalid EXCEPTION;
    BEGIN
        c_customer_id := 0;
        IF (TRIM(p_first_name) = '' or p_first_name is null) THEN
            RAISE ex_first_name_not_found;
        ELSIF (TRIM(p_last_name) = '' or p_last_name is null) THEN
            RAISE ex_last_name_not_found;
        ELSIF (TRIM(p_email) = '' or p_email is null) THEN
            RAISE ex_email_empty;
        END IF;
        IF (p_is_active !=1 and p_is_active !=0) THEN
            RAISE ex_active_status_invalid ;
        END IF;
        
        c_customer_id := customer_seq.NEXTVAL;
        LOCK TABLE CUSTOMER IN EXCLUSIVE MODE; 
        INSERT INTO CUSTOMER (customer_id, first_name,last_name,date_of_birth,email,is_active)
        VALUES (c_customer_id,p_first_name,p_last_name ,p_date_of_birth,p_email,p_is_active);   
        COMMIT;
    
    EXCEPTION
        WHEN ex_first_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer first name not found');
        WHEN ex_last_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer last name not found');
        WHEN ex_email_empty THEN
            DBMS_OUTPUT.PUT_LINE('Customer email id not found');
        WHEN ex_active_status_invalid THEN
            DBMS_OUTPUT.PUT_LINE('Customer status entered is invalid');

    END insert_customer;
    
    -- insert address
    PROCEDURE insert_address( 
        p_address_id OUT address.address_id%TYPE,
        p_customer_id  address.customer_id%TYPE,
        p_address_1 address.address_1%TYPE,
        p_address_2 address.address_2%TYPE,
        p_city address.city%TYPE,
        p_state address.state%TYPE,
        p_zip address.zip%TYPE,
        p_country address.country%TYPE   
    )
    AS
        ex_customer_id_not_found EXCEPTION;
        ex_address_1_not_found EXCEPTION;
        ex_address_2_not_found EXCEPTION;
        ex_city_not_found EXCEPTION;
        ex_state_not_found EXCEPTION;
        ex_country_not_found EXCEPTION;
        ex_zipcode_empty EXCEPTION;
        
    BEGIN
        p_address_id := 0;
        
        IF (TRIM(p_customer_id) = '' or p_customer_id is null) THEN
            RAISE ex_customer_id_not_found;
        ELSIF (TRIM(p_address_1) = '' or p_address_1 is null) THEN
            RAISE ex_address_1_not_found;
        ELSIF (TRIM(p_address_2) = '' or p_address_2 is null) THEN
            RAISE ex_address_2_not_found;
        ELSIF (TRIM(p_city) = '' or p_city is null) THEN
            RAISE ex_city_not_found;
        ELSIF (TRIM(p_state) = '' or p_state is null) THEN
            RAISE ex_state_not_found;
        ELSIF (TRIM(p_country) = '' or p_country is null) THEN
            RAISE ex_country_not_found;    
        END IF;
        IF (REGEXP_LIKE(p_zip, '^[0-9]+$')=False) THEN
            RAISE ex_zipcode_empty ;
        END if; 
        
        p_address_id := address_seq.NEXTVAL;
        LOCK TABLE address IN EXCLUSIVE MODE;
        INSERT INTO address (address_id,customer_id,address_1, address_2,city,state,zip,country)
        VALUES (p_address_id,p_customer_id,p_address_1, p_address_2,p_city,p_state,p_zip,p_country);        
        COMMIT;
    
    EXCEPTION
            
        WHEN ex_customer_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer Id not found');
            
        WHEN ex_address_1_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer address 1 not found');
            
        WHEN ex_address_2_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer address 2 not found');
            
        WHEN  ex_city_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer CITY id not found');
            
        WHEN ex_state_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer STATE NOT FOUND');
            
        WHEN ex_country_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Customer COUNTRY NOT FOUND');
            
        WHEN ex_zipcode_empty THEN
            DBMS_OUTPUT.PUT_LINE('Customer ZIPCODE entered is invalid');
    END insert_address;
    
    -- insert category
    PROCEDURE  insert_category( 
        p_category_id OUT Category.category_id%TYPE,
        p_category_name  Category.category_name%TYPE,
        p_category_desc Category.category_desc%TYPE   
    )
    AS
        ex_category_name_not_found EXCEPTION;
        
    BEGIN
        p_category_id := 0;
        
        IF(TRIM(p_category_name) = '' or p_category_name is null)THEN
            RAISE ex_category_name_not_found;
        END IF;    
        
        p_category_id := category_seq.NEXTVAL;
        LOCK TABLE Category IN EXCLUSIVE MODE; 
        INSERT INTO Category(category_id,category_name,category_desc)
        VALUES (p_category_id,p_category_name,p_category_desc); 
        COMMIT; 
    
    EXCEPTION
        WHEN ex_category_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('CATEGORY NAME entered NOT FOUND');
    END insert_category;
    
    --insert manufacturer
    PROCEDURE  insert_manufacturer( 
        p_MANUFACTURER_id OUT MANUFACTURER.MANUFACTURER_id%TYPE,
        p_MANUFACTURER_name MANUFACTURER.MANUFACTURER_name%TYPE,
        p_MANUFACTURER_desc MANUFACTURER.MANUFACTURER_desc%TYPE
    )
    AS
        ex_MANUFACTURER_name_not_found EXCEPTION;
        ex_DESCRIPTION_not_valid EXCEPTION;

    BEGIN
        p_MANUFACTURER_id := 0;
        
        IF (TRIM(p_MANUFACTURER_name) = '' or p_MANUFACTURER_name is null) THEN
            RAISE ex_MANUFACTURER_name_not_found;
        ELSIF (TRIM(p_MANUFACTURER_desc) = '' or p_MANUFACTURER_desc is null) THEN
            RAISE ex_DESCRIPTION_not_valid;
        END IF;
        
        p_MANUFACTURER_id := manufacturer_seq.NEXTVAL;
        LOCK TABLE MANUFACTURER IN EXCLUSIVE MODE;
        INSERT INTO MANUFACTURER (MANUFACTURER_id,MANUFACTURER_name,MANUFACTURER_desc)
        VALUES (p_MANUFACTURER_id,p_MANUFACTURER_name,p_MANUFACTURER_desc);
        COMMIT;

    EXCEPTION
        WHEN ex_MANUFACTURER_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Manufacturer name cannot be null or empty');
        WHEN  ex_DESCRIPTION_not_valid THEN
            DBMS_OUTPUT.PUT_LINE('Manufacturer description cannot be null or empty');
    END insert_manufacturer;
    
    --insert product
    PROCEDURE insert_product( 
        p_product_id OUT product.product_id%TYPE,
        p_name product.product_name%TYPE,
        p_quantity product.quantity%TYPE,
        p_price product.price%TYPE,
        p_category_id product.category_id%TYPE,
        p_manufacturer_id product.manufacturer_id%TYPE,
        p_is_active product.is_active%TYPE  
    )
    AS
        ex_product_name_not_found EXCEPTION;
        ex_product_PRICE_not_found EXCEPTION;
        ex_product_categoryid_not_found EXCEPTION;
        ex_product_manufacturerid_not_found EXCEPTION;
        ex_product_status_invalid EXCEPTION;
    BEGIN
        p_product_id := 0;
            
        IF (TRIM(p_name) = '' or p_name is null) THEN
            RAISE  ex_product_name_not_found;   
        
        ELSIF (p_price=0) THEN
            RAISE ex_product_PRICE_not_found;
             
        ELSIF (p_category_id=0) THEN
            RAISE ex_product_categoryid_not_found;
            
        ELSIF (p_manufacturer_id= 0) THEN
            RAISE ex_product_manufacturerid_not_found;
        END IF;
       
        p_product_id := product_seq.NEXTVAL;
        LOCK TABLE product IN EXCLUSIVE MODE;
        INSERT INTO product (product_id, product_name, quantity , price ,category_id,manufacturer_id , is_active )
        VALUES (p_product_id, p_name, p_quantity , p_price ,p_category_id ,p_manufacturer_id ,p_is_active );
        COMMIT;

    EXCEPTION
        WHEN ex_product_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('PRODUCT NAME ENTERED ID INVALID');
            
        WHEN ex_product_PRICE_not_found THEN
            DBMS_OUTPUT.PUT_LINE('PRODUCT PRICE ENTERED ID INVALID');
            
        WHEN ex_product_categoryid_not_found THEN
            DBMS_OUTPUT.PUT_LINE('CATEGORY ID id not found');
            
        WHEN ex_product_manufacturerid_not_found THEN
            DBMS_OUTPUT.PUT_LINE('MANUFACTURER ID id not found');     
            
    END insert_product; 
    
    --insert delivery partner
    PROCEDURE insert_delivery_partner( 
        P_delivery_partner_id OUT DELIVERY_PARTNER.DELIVERY_PARTNER_ID%TYPE,
        P_delivery_partner_name DELIVERY_PARTNER.DELIVERY_PARTNER_NAME%TYPE 
    )
    AS
        ex_delivery_partner_name_not_found EXCEPTION;
    BEGIN
        P_delivery_partner_id := 0;
        
        IF (TRIM(P_delivery_partner_name) = '' or P_delivery_partner_name is null) THEN
            RAISE  ex_delivery_partner_name_not_found; 
        END IF;
        
        P_delivery_partner_id := delivery_partner_seq.NEXTVAL;
        LOCK TABLE DELIVERY_PARTNER IN EXCLUSIVE MODE;
        INSERT INTO DELIVERY_PARTNER (DELIVERY_PARTNER_ID, DELIVERY_PARTNER_NAME)
        VALUES (P_delivery_partner_id, P_delivery_partner_name );  
        COMMIT;
        
    EXCEPTION 
        WHEN ex_delivery_partner_name_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Delivery partner NAME ENTERED ID INVALID');
    END insert_delivery_partner;

    --insert reviews
    PROCEDURE insert_reviews( 
        c_order_item_id reviews.order_item_id%TYPE,
        c_review_notes reviews.review%TYPE,
        c_rating reviews.rating%TYPE
    )
    AS
        ex_order_item_id_empty EXCEPTION;
        ex_review_notes_empty EXCEPTION;
        ex_rating_empty EXCEPTION;
        ex_order_item_id_not_found EXCEPTION;
        ex_invalid_rating_value EXCEPTION;
        ex_order_not_delivered EXCEPTION;
        c_order_id NUMBER;
        c_order_status VARCHAR2(100);
    BEGIN
        
        IF (TRIM(c_order_item_id) = '' or c_order_item_id is null) THEN
            RAISE ex_order_item_id_empty;
        ELSIF (TRIM(c_review_notes) = '' or c_review_notes is null) THEN
            RAISE ex_review_notes_empty;
        ELSIF (TRIM(c_rating) = '' or c_rating is null) THEN
            RAISE ex_rating_empty;
        END IF;
        
        IF validate_order_item_id(c_order_item_id) = 0 THEN
            RAISE ex_order_item_id_not_found;
        END IF;
        
        IF c_rating <=0 and c_rating > 5 THEN
            RAISE ex_invalid_rating_value;
        END IF;
        
        SELECT order_id INTO c_order_id FROM order_items WHERE order_item_id = c_order_item_id;
        SELECT delivery_status INTO c_order_status FROM order_tracking WHERE order_id = c_order_id;
        
        IF c_order_status = 'DELIVERED' THEN
            INSERT INTO reviews (review_id, order_item_id, review, review_date, rating)
            VALUES (REVIEWS_SEQ.nextval, c_order_item_id, c_review_notes, SYSTIMESTAMP, c_rating);
        ELSE
            RAISE ex_order_not_delivered;
        END IF;
        
    EXCEPTION
        WHEN ex_order_item_id_empty THEN
            DBMS_OUTPUT.PUT_LINE('Order Item id can not be null or empty');
        WHEN ex_review_notes_empty THEN
            DBMS_OUTPUT.PUT_LINE('Review text can not be null or empty');
        WHEN ex_rating_empty THEN
            DBMS_OUTPUT.PUT_LINE('Ratings can not be empty');
        WHEN ex_order_item_id_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Order Item Id can not be found');
        WHEN ex_invalid_rating_value THEN
            DBMS_OUTPUT.PUT_LINE('Rating number is invalid. It should be from 1 to 5');
        WHEN ex_order_not_delivered THEN
            DBMS_OUTPUT.PUT_LINE('Review can not be given as the item is not delivered yet or it has been cancelled');
            
    END insert_reviews;
    
END inventory_utils;
/

/* Trigger to Decrease inventory on placing an order */
CREATE OR REPLACE TRIGGER QUANTITYUPDATE 
AFTER INSERT ON ORDER_ITEMS 
FOR EACH ROW
BEGIN
    UPDATE product SET product.quantity = product.quantity - :new.quantity
    where product.product_id = :new.product_id;
END;
/

/* Trigger to Update delivery date to delivered date on orders when delivery status is set to delivered on tracking */
CREATE OR REPLACE TRIGGER DELIVERYDATEUPDATE
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
BEGIN
    UPDATE orders SET orders.delivery_datetime = SYSDATE where orders.order_id = :new.order_id and :new.delivery_status = 'DELIVERED';
END;
/

/*  Update shipping date to shipped date on orders when delivery status is set to shipped on tracking */
CREATE OR REPLACE TRIGGER SHIPPINGDATEUPDATE
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
BEGIN
    UPDATE orders SET orders.shipping_date = SYSDATE where orders.order_id = :new.order_id and :new.delivery_status = 'SHIPPED';
END;
/

/* Trigger to Increase inventory on canceling an order */
CREATE OR REPLACE TRIGGER INCREASE_PRODUCT_QUANTITY
AFTER UPDATE ON ORDER_TRACKING 
FOR EACH ROW
DECLARE
    CURSOR order_item_list IS
        SELECT product_id, quantity from order_items WHERE order_items.order_id = :new.order_id and :new.delivery_status = 'CANCELLED';

    curr_order_item order_item_list%ROWTYPE;
    c_quantity NUMBER;
BEGIN
    OPEN order_item_list;
    LOOP
        FETCH order_item_list INTO curr_order_item;
        EXIT WHEN order_item_list%NOTFOUND;
        SELECT quantity INTO c_quantity FROM product WHERE product_id = curr_order_item.product_id;
        UPDATE product SET product.quantity = curr_order_item.quantity + c_quantity
        WHERE product.product_id = curr_order_item.product_id;
    END LOOP;
    CLOSE order_item_list;
END;
/

-- View to get top 3 products sold by quantity per year
CREATE or REPLACE VIEW Top_Products AS
SELECT product_name, "Total Quantity Sold", "Year" FROM
(SELECT p.product_name, SUM(o.quantity) AS "Total Quantity Sold", EXTRACT(YEAR FROM (orders.order_date)) AS "Year",
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM (orders.order_date)) ORDER BY SUM(o.quantity) DESC) AS rn
FROM product p
JOIN order_items o ON p.product_id = o.product_id
JOIN orders ON orders.order_id = o.order_id
GROUP BY p.product_name,orders.order_date,o.quantity) a
WHERE a. rn <= 3;

-- View to get top 3 categories of product sold by quantity
CREATE or REPLACE VIEW Top_Categories AS
SELECT a.category_name, a.product_name, a.prodcount FROM
(SELECT c.category_name, p.product_name, sum(o.quantity) AS prodcount,
RANK() OVER (PARTITION BY c.category_name ORDER BY SUM(o.quantity) DESC) AS rn FROM Category c 
LEFT JOIN product p
on c.category_id = p.category_id
JOIN order_items o on o.product_id = p.product_id
GROUP BY c.category_name, p.product_name) a
WHERE rn in (1,2,3);

--View to get inventory status and manufacture report to view products low on stock, quantity less than equal 20
CREATE OR REPLACE VIEW Inventory_status AS
SELECT p.product_id,p.product_name,p.quantity AS "Inventory",c.category_name,m.manufacturer_name FROM product p
INNER JOIN category c on p.category_id = c.category_id
INNER JOIN manufacturer m on p.manufacturer_id = m.manufacturer_id
WHERE p.quantity <=20
ORDER BY p.quantity asc;

-- Top customers by order amount
CREATE or REPLACE VIEW Top_Customers AS
SELECT c.customer_id,first_name, last_name,SUM(o.order_amount) AS "Total Order Amount" FROM customer c
JOIN orders o on o.customer_id = c.customer_id
GROUP BY c.customer_id,first_name,last_name
ORDER BY SUM(o.order_amount) DESC;

-- Top view total delivery count by delivery vendors
CREATE or REPLACE VIEW Delivery_Count AS
SELECT d.delivery_partner_id, d.delivery_partner_name,count(o.delivery_partner_id) AS "Total Count" FROM delivery_partner d
JOIN order_tracking o on o.delivery_partner_id = d.delivery_partner_id
GROUP BY d.delivery_partner_id, d.delivery_partner_name
ORDER BY COUNT(o.delivery_partner_id) DESC;

-- Top manufacturer average ratings and total number of orders placed
CREATE OR REPLACE VIEW manufacturer_ratings AS
SELECT m.manufacturer_id, m.manufacturer_name, ROUND(AVG(r.rating), 2) AS "AVG RATING", COUNT(oi.order_item_id) AS "NO OF ORDERS PLACED",
CASE
    WHEN ROUND(AVG(r.rating), 2) >= 1 AND ROUND(AVG(r.rating), 2)  <=2.5 
        THEN 'LOW'
    WHEN ROUND(AVG(r.rating), 2) >2.5 AND ROUND(AVG(r.rating), 2) <= 4
        THEN 'MEDIUM'
    ELSE 
        'HIGH'
END CATEGORY
FROM reviews r ,order_items oi, product p, manufacturer m 
WHERE r.order_item_id = oi.order_item_id and oi.product_id = p.product_id 
AND p.manufacturer_id = m.manufacturer_id 
GROUP BY m.manufacturer_id, m.manufacturer_name, m.manufacturer_id ORDER BY ROUND(AVG(r.rating), 2) DESC;
