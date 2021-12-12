-- package declaration for creating tables and deleting records from the table
CREATE OR REPLACE PACKAGE create_delete_utils AS
    
    -- create tables
    PROCEDURE create_table(
        c_table_name VARCHAR2
    );
    
END create_delete_util;

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
                
            ELSE 
                RAISE ex_table_not_found;
            END IF;
            
        END IF;
        
    EXCEPTION
        WHEN ex_table_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Table name is invalid');
            
    END create_table;
    
END create_delete_utils; 