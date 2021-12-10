INSERT ALL
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2874,'Jack','Smith',DATE '1967-08-02', 'jack.smith@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2876, 'Sam', 'Jose',DATE '1987-03-01', 'sam.jose@gmail.com', 0)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2976, 'Megan', 'Rose',DATE '1997-01-06', 'megan.rose@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (1876, 'Peter', 'Pan',DATE '2001-08-09', 'peter.pan@gmail.com', 0)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2001, 'JK', 'Melon',DATE '2002-04-03', 'JK.mel@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (1996, 'Akash', 'Singh',DATE '2011-01-04', 'akash.s@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (1994, 'Shruti', 'Jain',DATE '1997-09-09', 'Jain.shruti.mel@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2176, 'James', 'Forbis',DATE '1992-07-01', 'J.forbis@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (1836, 'Melvin', 'Barr',DATE '2012-02-02', 'mel.barr@gmail.com', 0)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (2101, 'Roger', 'Fed',DATE '2003-01-07', 'rogf@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (1976, 'Ronald', 'Cornor',DATE '1991-02-03', 'ronald.c@gmail.com', 1)
INTO CUSTOMER ( customer.customer_id, customer.first_name,customer.last_name,customer.date_of_birth,customer.email,customer.is_active)
VALUES (994, 'Sharon', 'Janv',DATE '1997-09-09', 'Janv.sharon.mel@gmail.com', 1)

SELECT * FROM dual; 
select customer.customer_id from customer ;
COMMIT;  

select * from ADDRESS ;





INSERT ALL
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (174,994,'876 apple drive','645 Kingsbury St','Boston','MA',021211,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (344,1,'388 22nd Pl S','522 Edge Hill Rd','BOISE','ID',83702,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (1421,2874,'132 Crescenta Way','32 S Madison St','FLORIDA','AL',03241,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (184,1,'43 Minnisink Rd','277 Jaclyn Ave','JUNEAU','AK',99801,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (085,2874,'60 Lake Dr.e','250 Cemetery Dr.t','ANNAPOLIS','MD',21411,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (19642,2876,'8278 John Ave.','72 North Avenue','ST PAUL','MN',489333,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (7854,2976,'8718 Talbot St.','38 W. Lookout St.','DOVER','DE',021211,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (21844,1994,'9014 Elm St.','Battle Ground, WA 98604','ALBANY','NY',87501,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (818324,2001,'7199 Plumb Branch Avenue','Prattville, AL 36067','TRENTON','NJ',03301,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (3787,2101,'DErry, NH 03038','645 Kingsbury St','HONOLULU','HI',96813,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (11174,2176,'15 North Oakwood St.','69 Pineknoll St.','FRANKFORT','KY',451211,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (16434,1836,'423 Rock Creek St.','551 Paris Hill St','Boston','MA',021211,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (1154,1876,'8699 Wild Rose Street','7911 Woodside Drive','HELENA','MT',59623,'USA')
INTO ADDRESS (address_id,ADDRESS.customer_id,address_1, address_2,city,state,zip,country)
VALUES (17004,1996,'Youngstown, OH 44512','69 Brickell Street','CARSON CITY','NV',89701,'USA')

SELECT * FROM dual; 

select * from ADDRESS;
COMMIT;     


INSERT ALL

INTO CATEGORY (category_id,category_name,category_desc)
VALUES (1178, 'Tablet', 'SKU6789 Kindle Paperwhite  767 Tablet high-resolution display with builtin light')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (789,  'Laptop', 'SKUB00V, ASUS Chromebook C201' )
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4467,  'Adaptor', 'SKUGNXW, Poweradd power converter 701, 2-outlet universal travel adapter')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4192, 'Makeup', 'SKU9763, Maybelline New York Super Stay,  88, Matte ink lip color')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4298,  'Beauty appliances', 'SKU76G2T3 Featherweight 1, Hair dryer with 2X speed 2Yr warranty')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4394,  'Sneakers', 'SKU8723, Under Armour Micro G running shoes, Black running shoes ')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4689,  'Jewelery', 'SKU7263, 10k Rose Gold plated white Gold Diamond ring 83766, 0.75cttw, I-J Color')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (4600,  'Perfume', 'MK flower fragrance')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (1034,  'Appliance', 'Durable and 5 year warranty electronics')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (746,  'Stationary', 'School supplies')
INTO CATEGORY (category_id,category_name,category_desc)
VALUES (9807,  'Adidas', 'lastest edition footwear and sportswear')

SELECT * FROM dual; 

select * from category;
COMMIT;     



INSERT ALL

INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(101,'Foxconn','Electronics')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(113,'Samsung Electronics','Electronics, various')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(114,'Volkswagen Group','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(115,'Toyota Group','Engineering, various')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(106,'General Motors','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(107,'Daimler','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(108,'Cardinal Health','Pharmaceuticals')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(109,'China Railway and Engineering Group','Engineering')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(110,'Huawei','Telecommunications equipment, Electronics')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(112,'Honda','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(116,'Nike','apparels')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(102,'Lakme','Cosmetics')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(103,'SAIC Motor','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(104,'BMW','Automotive')
INTO MANUFACTURER( manufacturer_id, manufacturer_name, manufacturer_desc)
VALUES(118,'philips','Electronics')


INSERT ALL



SELECT * FROM dual; 

SELECT * FROM dual; 

select * from Manufacturer;
select * from category;
COMMIT; 

delete from Manufacturer;



INTO PRODUCT( product.product_id,product.product_name,product.quantity,product.price,product.category_id,product.manufacturer_id,product.is_active)
VALUES(100,'Mist',2,50,4600,102,1)


INSERT ALL
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(200,'Foundation',10,75,4192,102,0)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(300,'Samsung Tablet',200,500,1178,113,0)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(400,'Bracelet',25,15,4689,117,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(500,'Shoes',100,70,4394,117,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(600,'Acer Laptop',20,700,789,101,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(700,'Hair dryer',10,40,4298,101,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(800,'Apple Laptop',20,1000,789,110,0)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(900,'Refridgerator',15,500,1034,114,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(1000,'Pens',300,4,746,118,0)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(1100,'charger',500,100,4467,118,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(1200,'Running Shoes',300,750,4394,116,1)
INTO PRODUCT( product_id,product_name,quantity,price,category_id,manufacturer_id,is_active)
VALUES(1300,'Services',2,170,4689,105,0)

SELECT * FROM dual; 

select * from product;
COMMIT; 

INSERT ALL
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1001,'Anne')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1002,'Audrey')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1003,'Ava')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1004,'Bella')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1005,'Bernadette')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1006,'Carol')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1007,'Caroline')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1008,'Gordon	')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1010,'Ellison')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1011,'Grace	')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1012,'McDonald')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1013,'Alison	')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1015,'Wilkins')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1014,'Lucas')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1016,'Cornish')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
Values(1017,'Peter')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1018,'Mackenzie')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1019,'Richard')
INTO delivery_partner( delivery_partner_id, delivery_partner_name)
VALUES(1020,'Wallace')


SELECT * FROM dual; 

select * from delivery_partner;
COMMIT;
