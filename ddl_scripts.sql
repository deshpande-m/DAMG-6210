CREATE TABLE customer (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE,
    email VARCHAR2(50),
    is_active NUMBER 
);

CREATE TABLE address (
    address_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    address_1 VARCHAR2(50),
    address_2 VARCHAR2(50),
    city VARCHAR2(50),
    state VARCHAR2(50),
    zip NUMBER,
    country VARCHAR2(50)
);

CREATE TABLE category (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(50),
    category_desc VARCHAR2(100)
);

CREATE TABLE manufacturer (
    manufacturer_id NUMBER PRIMARY KEY,
    manufacturer_name VARCHAR2(50),
    manufacturer_desc VARCHAR2(100)
);

CREATE TABLE product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    quantity NUMBER,
    price NUMBER,
    category_id NUMBER,
    manufacturer_id NUMBER,
    FOREIGN KEY(category_id) REFERENCES category(category_id),
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturer(manufacturer_id),
    is_active NUMBER
);

CREATE TABLE delivery_partner (
    delivery_partner_id NUMBER PRIMARY KEY,
    delivery_partner_name VARCHAR2(50)
);

CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    order_date DATE,
    shipping_date DATE,
    shipping_type VARCHAR2(50),
    order_amount NUMBER,
    customer_id NUMBER,
    shipping_charges NUMBER,
    address_id NUMBER,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(address_id) REFERENCES address(address_id)
);

CREATE TABLE order_items (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    quantity NUMBER,
    product_id NUMBER,
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id)
);

CREATE TABLE transaction (
    transaction_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    transaction_date DATE,
    total_amount NUMBER,
    payment_method VARCHAR2(50)
);

CREATE TABLE order_tracking (
    order_tracking_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    delivery_partner_id NUMBER,
    delivery_date DATE,
    delivery_status VARCHAR2(50),
    FOREIGN KEY(delivery_partner_id) REFERENCES delivery_partner(delivery_partner_id)
);

CREATE TABLE reviews (
    review_id NUMBER PRIMARY KEY,
    order_item_id NUMBER,
    review VARCHAR2(100),
    review_date DATE,
    rating NUMBER,
    FOREIGN KEY(order_item_id) REFERENCES order_items(order_item_id)
);

ALTER TABLE order_tracking 
ADD tracking_number VARCHAR2(50);

CREATE SEQUENCE orders_seq START WITH 1;
CREATE SEQUENCE order_item_seq START WITH 1;
CREATE SEQUENCE transaction_seq START WITH 1;
CREATE SEQUENCE order_tracking_seq START WITH 1;
CREATE SEQUENCE reviews_seq START WITH 1;