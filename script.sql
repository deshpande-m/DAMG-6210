SET SERVEROUTPUT ON;

DECLARE
    c_customer_id NUMBER;
    c_address_id NUMBER;
    c_manufacturer_id NUMBER;
    c_category_id NUMBER;
    c_order_id NUMBER;
    c_product_id NUMBER;
    c_delivery_partner_id NUMBER;
BEGIN
    
    --delete records
    
    --c_utils1.delete_records;
    
    --insert delivery partner records
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'PRIME');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'FEDX');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'eCOM');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'GATI');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'USPS');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'SHADOWFEX');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'GETFAST');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'SHIPROCKET');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'EASYGIFT');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'EXPRESS');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'BLUEDART');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'FIRSTFLIGHT');
    c_utils.insert_delivery_partner(c_delivery_partner_id, 'UPS');
 


    -- insert customer records
    c_utils.insert_customer('Jack','Smith',DATE'1967-08-02', 'jack.smith@gmail.com', 1, c_customer_id);
    c_utils.insert_customer('Shruti', 'Jain',DATE '1997-09-09', 'Jain.shruti.mel@gmail.com', 1,c_customer_id);
    c_utils.insert_customer('Akash', 'Singh',DATE '2011-01-04', 'akash.s@gmail.com', 1,c_customer_id);
    c_utils.insert_customer( 'JK', 'Melon',DATE '2002-04-03', 'JK.mel@gmail.com', 1,c_customer_id);
    c_utils.insert_customer('Peter', 'Pan',DATE '2001-08-09', 'peter.pan@gmail.com', 0,c_customer_id);
    c_utils.insert_customer( 'Megan', 'Rose',DATE '1997-01-06', 'megan.rose@gmail.com', 1,c_customer_id);
    c_utils.insert_customer('Sam', 'Jose',DATE '1987-03-01', 'sam.jose@gmail.com', 0,c_customer_id);
    
    -- insert address records
    c_utils.insert_address(c_address_id, 1,'Newbury Street','Rox Street','Rochester','NJ',03115,'USA');
    c_utils.insert_address(c_address_id,994,'876 apple drive','645 Kingsbury St','Boston','MA',021211,'USA');
    c_utils.insert_address(c_address_id,187,'388 22nd Pl S','522 Edge Hill Rd','BOISE','ID',83702,'USA');
    c_utils.insert_address(c_address_id,2874,'132 Crescenta Way','32 S Madison St','FLORIDA','AL',03241,'USA');
    c_utils.insert_address(c_address_id,100,'43 Minnisink Rd','277 Jaclyn Ave','JUNEAU','AK',99801,'USA');
    c_utils.insert_address(c_address_id,2874,'60 Lake Dr.e','250 Cemetery Dr.t','ANNAPOLIS','MD',21411,'USA');
    c_utils.insert_address(c_address_id,2876,'8278 John Ave.','72 North Avenue','ST PAUL','MN',489333,'USA');
    c_utils.insert_address(c_address_id,2976,'8718 Talbot St.','38 W. Lookout St.','DOVER','DE',021211,'USA');
    c_utils.insert_address(c_address_id,1994,'9014 Elm St.','Battle Ground, WA 98604','ALBANY','NY',87501,'USA');
    c_utils.insert_address(c_address_id,2001,'7199 Plumb Branch Avenue','Prattville, AL 36067','TRENTON','NJ',03301,'USA');
    c_utils.insert_address(c_address_id, 2101,'DErry, NH 03038','645 Kingsbury St','HONOLULU','HI',96813,'USA');
    c_utils.insert_address(c_address_id,2176,'15 North Oakwood St.','69 Pineknoll St.','FRANKFORT','KY',451211,'USA'); 
    c_utils.insert_address(c_address_id,1836,'423 Rock Creek St.','551 Paris Hill St','Boston','MA',021211,'USA');
                            
    
    
    -- insert manufacturer records
    c_utils.insert_manufacturer(c_manufacturer_id, 'BEST BUY APLLICANCES','Shopping store');
    c_utils.insert_manufacturer(c_manufacturer_id, 'Walmart','Shopping store');
    c_utils.insert_manufacturer(c_manufacturer_id,'Target','general merchandise');
    c_utils.insert_manufacturer(c_manufacturer_id,'Huawei','Telecommunications equipment, Electronics');
    c_utils.insert_manufacturer(c_manufacturer_id,'Honda','Automotive');
    c_utils.insert_manufacturer(c_manufacturer_id,'Nike','apparels');
    c_utils.insert_manufacturer(c_manufacturer_id,'Samsung Electronics','Electronics, various');
    c_utils.insert_manufacturer(c_manufacturer_id,'Volkswagen Group','Automotive');
    c_utils.insert_manufacturer(c_manufacturer_id,'Toyota Group','Engineering, various');
    
    
     -- insert category records
    c_utils.insert_category(c_category_id, 'Electronics','Orginal Applicances of all Brands');
    c_utils.insert_category(c_category_id, 'Glass','Orginal Applicances of all Brands');
    c_utils.insert_category(c_category_id,'Adaptor', 'SKUGNXW, Poweradd power converter 701, 2-outlet universal travel adapter');
    c_utils.insert_category(c_category_id,'Makeup', 'SKU9763, Maybelline New York Super Stay, 88, Matte ink lip color');
    c_utils.insert_category(c_category_id, 'Beauty appliances', 'SKU76G2T3 Featherweight 1, Hair dryer with 2X speed 2Yr warranty');
    c_utils.insert_category(c_category_id, 'Sneakers', 'SKU8723, Under Armour Micro G running shoes, Black running shoes ');
    c_utils.insert_category(c_category_id, 'Jewelery', 'SKU7263, 10k Rose Gold plated white Gold Diamond ring 83766, 0.75cttw, I-J Color');
    c_utils.insert_category(c_category_id,'Perfume', 'MK flower fragrance');
    c_utils.insert_category(c_category_id,'Appliance', 'Durable and 5 year warranty electronics');
    c_utils.insert_category(c_category_id,'Stationary', 'School supplies');
    c_utils.insert_category(c_category_id, 'Adidas', 'lastest edition footwear and sportswear');
    
  

    
    
    
    
    -- insert products
    c_utils.insert_product(c_product_id, 'GRINDER',15,107,1,2,1);
    c_utils.insert_product(c_product_id, 'MIXER',15,200,1,1,1);
    c_utils.insert_product(c_product_id, 'SHAVER',15,250,2,1,1);
    c_utils.insert_product(c_product_id,'Foundation',10,75,4192,102,0);
    c_utils.insert_product(c_product_id,'Samsung Tablet',200,500,1178,113,0);
    c_utils.insert_product(c_product_id,'Bracelet',25,15,4689,117,1);
    c_utils.insert_product(c_product_id,'Shoes',100,70,4394,117,1);
    c_utils.insert_product(c_product_id,'Acer Laptop',20,700,789,101,1);
    c_utils.insert_product(c_product_id,'Hair dryer',10,40,4298,101,1);
    c_utils.insert_product(c_product_id,'Apple Laptop',20,1000,789,110,0);
    c_utils.insert_product(c_product_id,'Refridgerator',15,500,1034,114,1);
    c_utils.insert_product(c_product_id,'Pens',300,4,746,118,0);
    c_utils.insert_product(c_product_id,'charger',500,100,4467,118,1);
 
    
    -- order flow
    c_utils.create_order(1, 1, 'Standard', c_order_id);
    c_utils.create_order(994,174,'Express',c_order_id);
    c_utils.create_order(1876,1154,'Overight',c_order_id);
    c_utils.create_order(2874,1421,'Standard',c_order_id);
    c_utils.create_order(100,1000,'Standard',c_order_id);
    c_utils.create_order(100,1000,'Express',c_order_id);
    c_utils.create_order(1876,1154,'Express',c_order_id);
    c_utils.create_order(1994,21844,'Overight',c_order_id);
    c_utils.create_order(2876,19642,'Standard',c_order_id);
    c_utils.create_order(1994,21844,'Overight',c_order_id);
    c_utils.create_order(994,174,'Express',c_order_id);
    c_utils.create_order(1836,16434,'Overight',c_order_id);

 
    
    -- order flow
    
 
    c_utils.create_order_items(c_order_id,20,600);
    c_utils.create_order_items(c_order_id,10,200);
    c_utils.create_order_items(c_order_id,20,600);
    c_utils.create_order_items(c_order_id,100,500);
    c_utils.create_order_items(c_order_id,25,400);
    c_utils.create_order_items(c_order_id,200,300);
    c_utils.create_order_items(c_order_id,10,700);
    c_utils.create_order_items(c_order_id,200,300);
    c_utils.create_order_items(c_order_id,10,700);
    c_utils.create_order_items(c_order_id,15,900);
    c_utils.create_order_items(c_order_id,300,1000);
    c_utils.create_order_items(c_order_id,500,1100);
    
    
 -- order flow
    
   
    
    c_utils.create_transaction(100);
    c_utils.create_transaction(200);
    c_utils.create_transaction(300);
    c_utils.create_transaction(400);
    c_utils.create_transaction(500);
    c_utils.create_transaction(600);
    c_utils.create_transaction(700);
    c_utils.create_transaction(800);
    c_utils.create_transaction(900);
    c_utils.create_transaction(1000);
    c_utils.create_transaction(1100);
    c_utils.create_transaction(1200);
    c_utils.create_transaction(1300);


    -- order flow
    
    

    c_utils.create_order_tracking(100);
    c_utils.create_order_tracking(200);
    c_utils.create_order_tracking(300);
    c_utils.create_order_tracking(400);
    c_utils.create_order_tracking(500);
    c_utils.create_order_tracking(600);
    c_utils.create_order_tracking(700);
    c_utils.create_order_tracking(800);
    c_utils.create_order_tracking(900);
    c_utils.create_order_tracking(1000);
    c_utils.create_order_tracking(1100);
    c_utils.create_order_tracking(1200);
    c_utils.create_order_tracking(1300);
    
END;