SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  C_INSERT
( 
   p_customer_id customer.customer_id%TYPE,
   p_first_name  customer.first_name%TYPE,
   p_last_name  customer.last_name%TYPE,
   p_date_of_birth  customer.date_of_birth%TYPE,
   p_email  customer.email%TYPE,
   p_is_active  customer.is_active%TYPE
)
AS
BEGIN
    INSERT INTO CUSTOMER (customer_id, first_name,last_name,date_of_birth,email,is_active)
    VALUES (p_customer_id,p_first_name,p_last_name ,p_date_of_birth,p_email,p_is_active);   
    COMMIT;

END;   
/
EXEC C_INSERT (28,'Jack','Smith',DATE'1967-08-02', 'jack.smith@gmail.com', 1);
EXEC C_INSERT(1111, 'JOSEY', 'RODRICK',DATE '1957-01-03', 'ROD.jose@gmail.com', 0);


SELECT * FROM CUSTOMER;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  ADDRESS_INSERT
( 
   p_address_id address.address_id%TYPE,
   p_customer_id  address.customer_id%TYPE,
   p_address_1 address.address_1%TYPE,
   p_address_2 address.address_2%TYPE,
   p_city address.city%TYPE,
   p_state address.state%TYPE,
   p_zip address.zip%TYPE,
   p_country address.country%TYPE   
)
AS
BEGIN
    INSERT INTO address (address_id,customer_id,address_1, address_2,city,state,zip,country)
    VALUES (p_address_id,p_customer_id,p_address_1, p_address_2,p_city,p_state,p_zip,p_country);        
    COMMIT;

END;   
/
EXEC ADDRESS_INSERT (34,28,'Newbury Street','Rox Street','Rochester','NJ',03115,'USA');
EXEC ADDRESS_INSERT (986,1111,'St Alphonsus','Park Street','Boston','MA',00987,'USA');

COMMIT;



SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  Category_INSERT
( 
   p_category_id Category.category_id%TYPE,
   p_category_name  Category.category_name%TYPE,
   p_category_desc Category.category_desc%TYPE   
)
AS
BEGIN
    INSERT INTO Category(category_id,category_name,category_desc)
    VALUES (p_category_id,p_category_name,p_category_desc);   
    COMMIT;
END;   
/
EXEC Category_INSERT (567,'Electronics','Orginal Applicances of all Brands');
EXEC Category_INSERT (200,'Cosmetics','Latest products and discounts available');


    

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  MANUFACTURER_INSERT
( 
   p_MANUFACTURER_id MANUFACTURER.MANUFACTURER_id%TYPE,
   p_MANUFACTURER_name  MANUFACTURER.MANUFACTURER_name%TYPE,
   p_MANUFACTURER_desc MANUFACTURER.MANUFACTURER_desc%TYPE   
)
AS
BEGIN
    INSERT INTO MANUFACTURER (MANUFACTURER_id,MANUFACTURER_name,MANUFACTURER_desc)
    VALUES (p_MANUFACTURER_id,p_MANUFACTURER_name,p_MANUFACTURER_desc);
    COMMIT;

END;   
/
EXEC MANUFACTURER_INSERT (119,'BEST BUY APLLICANCES','ALL ELECTRONICS');
EXEC MANUFACTURER_INSERT (120,'ROBIN JEWELS','ORNAMENTS');


SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  PRODUCT_INSERT
( 
   p_product_id product.product_id%TYPE,
   p_name product.product_name%TYPE,
   p_quantity product.quantity%TYPE,
   p_price product.price%TYPE,
   p_category_id product.category_id%TYPE,
   p_manufacturer_id product.manufacturer_id%TYPE,
   p_is_active product.is_active%TYPE  
)
AS
BEGIN
    INSERT INTO product (product_id, product_name, quantity , price ,category_id ,manufacturer_id , is_active )
    VALUES (p_product_id, p_name, p_quantity , p_price ,p_category_id ,p_manufacturer_id , p_is_active );    
    COMMIT;
END;   
/
EXEC PRODUCT_INSERT (2000,'GRINDER',15,107,567,119,1);
EXEC PRODUCT_INSERT (3220,'NECKLACE',3,250,200,120,1);

COMMIT;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE  DELIVERY_PARTNER_INSERT
( 
  
   P_delivery_partner_id DELIVERY_PARTNER.DELIVERY_PARTNER_ID%TYPE,
   P_delivery_partner_name DELIVERY_PARTNER.DELIVERY_PARTNER_NAME%TYPE 
   
)
AS
BEGIN
    INSERT INTO DELIVERY_PARTNER (DELIVERY_PARTNER_ID, DELIVERY_PARTNER_NAME)
    VALUES (P_delivery_partner_id, P_delivery_partner_name );        
    COMMIT;
END;   
/
EXEC DELIVERY_PARTNER_INSERT (1001,'PRIME');
EXEC DELIVERY_PARTNER_INSERT (1002,'FEDX');
EXEC DELIVERY_PARTNER_INSERT (1003,'eCOM');
EXEC DELIVERY_PARTNER_INSERT (1004,'GATI');
EXEC DELIVERY_PARTNER_INSERT (1005,'USA POST SERVICE');
EXEC DELIVERY_PARTNER_INSERT (1006,'SHADOWFEX');
EXEC DELIVERY_PARTNER_INSERT (1007,'GETFAST');
EXEC DELIVERY_PARTNER_INSERT (1008,'SHIPROCKET');
EXEC DELIVERY_PARTNER_INSERT (1009,'EASYGIFT');
EXEC DELIVERY_PARTNER_INSERT (1010,'EXPRESS');
EXEC DELIVERY_PARTNER_INSERT (1011,'BLUEDART');
EXEC DELIVERY_PARTNER_INSERT (1012,'FIRSTFLIGHT');

select * from delivery_partner;
COMMIT;







