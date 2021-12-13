-- package declaration for creating tables and deleting records from the table
CREATE OR REPLACE PACKAGE create_delete_utils AS
    
    -- create tables
    PROCEDURE create_table(
        c_table_name VARCHAR2
    );

    -- delete table records
    PROCEDURE delete_records;
    
END create_delete_utils;
/

-- package body for creating tables and deleting records from the table
CREATE OR REPLACE PACKAGE BODY create_delete_utils AS
    
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

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE customer_seq START WITH 1';
                
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

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE address_seq START WITH 1';
                
            ELSIF c_upper_table_name = 'CATEGORY' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE category (
                    category_id NUMBER PRIMARY KEY,
                    category_name VARCHAR2(50),
                    category_desc VARCHAR2(100)
                )';

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE category_seq START WITH 1';
                
            ELSIF c_upper_table_name = 'MANUFACTURER' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE manufacturer (
                    manufacturer_id NUMBER PRIMARY KEY,
                    manufacturer_name VARCHAR2(50),
                    manufacturer_desc VARCHAR2(100)
                )';

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE manufacturer_seq START WITH 1';
                
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

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE product_seq START WITH 1';
                
            ELSIF c_upper_table_name = 'DELIVERY_PARTNER' THEN
                EXECUTE IMMEDIATE
                'CREATE TABLE delivery_partner (
                    delivery_partner_id NUMBER PRIMARY KEY,
                    delivery_partner_name VARCHAR2(50)
                )';

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE delivery_partner_seq START WITH 1';
                
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

                EXECUTE IMMEDIATE
                'CREATE SEQUENCE orders_seq START WITH 1';
                
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
                
                EXECUTE IMMEDIATE
                'CREATE SEQUENCE order_item_seq START WITH 1';

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
                'CREATE SEQUENCE transaction_seq START WITH 1';
                
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
                'CREATE SEQUENCE order_tracking_seq START WITH 1';
                
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
                'CREATE SEQUENCE reviews_seq START WITH 1';
                
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
    
END create_delete_utils;
/

-- script to create tables if doesnt exist
BEGIN
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
END;
/