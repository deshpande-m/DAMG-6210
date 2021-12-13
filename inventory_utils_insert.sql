set serveroutput on;
DECLARE
 c_product_id NUMBER;
BEGIN
    -- delete existing records
 

    -- inserting delivery partner records
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'PRIME');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'FEDX');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'eCOM');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'GATI');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'USPS');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'SHADOWFEX');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'GETFAST');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'SHIPROCKET');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'EASYGIFT');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'EXPRESS');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'BLUEDART');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'FIRSTFLIGHT');
    inventory_utils.insert_delivery_partner(c_delivery_partner_id, 'UPS');
    
    -- insert customer records
    inventory_utils.insert_customer('Jack','Smith',DATE'1967-08-02', 'jack.smith@gmail.com', 1, c_customer_id);
    inventory_utils.insert_customer('Shruti', 'Jain',DATE '1997-09-09', 'Jain.shruti.mel@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Akash', 'Singh',DATE '2011-01-04', 'akash.s@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('JK', 'Melon',DATE '2002-04-03', 'JK.mel@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Peter', 'Pan',DATE '2001-08-09', 'peter.pan@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Megan', 'Rose',DATE '1997-01-06', 'megan.rose@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Sam', 'Jose',DATE '1987-03-01', 'sam.jose@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Viraj','Rajopadhaye',DATE'2000-08-02', 'viraj.r@gmail.com', 1, c_customer_id);
    inventory_utils.insert_customer('Marry', 'OnMan',DATE '2001-09-09', 'marry.o@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Adarsh', 'Rajnikanth',DATE '2001-01-04', 'adarsh.r@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Swapnil', 'Joshi',DATE '2002-05-12', 'joshi.s@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Rahul', 'Chakankar',DATE '2001-10-09', 'chakankar.rahul@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Samuel', 'Jose',DATE '1997-10-06', 'samuel.jose@gmail.com', 1,c_customer_id);
    inventory_utils.insert_customer('Sameer', 'Sinha',DATE '1987-08-01', 'sinha.sameer@gmail.com', 1,c_customer_id);
    
    -- insert address records
    inventory_utils.insert_address(c_address_id,1,'Newbury Street','Rox Street','Rochester','NJ',03115,'USA');
    inventory_utils.insert_address(c_address_id,2,'876 apple drive','645 Kingsbury St','Boston','MA',021211,'USA');
    inventory_utils.insert_address(c_address_id,3,'388 22nd Pl S','522 Edge Hill Rd','BOISE','ID',83702,'USA');
    inventory_utils.insert_address(c_address_id,4,'132 Crescenta Way','32 S Madison St','FLORIDA','AL',03241,'USA');
    inventory_utils.insert_address(c_address_id,5,'43 Minnisink Rd','277 Jaclyn Ave','JUNEAU','AK',99801,'USA');
    inventory_utils.insert_address(c_address_id,6,'606-3727 Ullamcorper. Street','Rox Street','New Mexico','MA',98765,'USA');
    inventory_utils.insert_address(c_address_id,7,'Ap #867-859 Sit Rd.','645 Kingsbury St','San Jose','CA',09765,'USA');
    inventory_utils.insert_address(c_address_id,8,'7292 Dictum Av.','522 Edge Hill Rd','Seattle','WA',89543,'USA');
    inventory_utils.insert_address(c_address_id,9,'191-103 Integer Rd.','32 S Madison St','Utah','UT',43212,'USA');
    inventory_utils.insert_address(c_address_id,10,'511-5762 At Rd.','277 Jaclyn Ave','Austin','TX',78765,'USA');
    inventory_utils.insert_address(c_address_id,11,'935-9940 Tortor. Street','Rox Street','Illnois','CH',03115,'USA');
    inventory_utils.insert_address(c_address_id,12,'Erie Rhode Island 24975','645 Kingsbury St','Boston','MA',34212,'USA');
    inventory_utils.insert_address(c_address_id,13,'Bandera South Dakota 45149','522 Edge Hill Rd','BOISE','ID',45768,'USA');
    inventory_utils.insert_address(c_address_id,14,'347-7666 Iaculis St.','32 S Madison St','FLORIDA','AL',72343,'USA');
    
    -- insert manufacturer records
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Walmart','Shopping store'); --1
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Target','general merchandise'); --2
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Stop and Shop','General Store'); --3
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Huawei','Telecommunications equipment, Electronics'); --4
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Logitech','Telecommunications equipment, Electronics'); --5
    inventory_utils.insert_manufacturer(c_manufacturer_id,'HP','Laptop Dealers'); --6
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Apple','Products'); --7
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Mosiso','Laptop Dealer'); --8
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Dell','Laptop brands'); --9
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Nike','apparels'); --10
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Levis','apparels'); --11
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Samsung Electronics','Electronics, various'); --12
    inventory_utils.insert_manufacturer(c_manufacturer_id,'LG','Electronics'); --13
    inventory_utils.insert_manufacturer(c_manufacturer_id,'BEST BUY Appliances','Big electronics store'); --14
    inventory_utils.insert_manufacturer(c_manufacturer_id,'CVS Pharmacy','Pharmacy and Medical'); --15
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Walgreens','Pharmacy and Medical'); --16
    inventory_utils.insert_manufacturer(c_manufacturer_id,'PaperSauce','Stationary'); --17
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Stationary Co','Stationary'); --18
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Yale Applicances','various appliances available'); --19
    inventory_utils.insert_manufacturer(c_manufacturer_id,'AAA Applicances','various appliances available'); --20
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Ulta','beauty products'); --21
    inventory_utils.insert_manufacturer(c_manufacturer_id,'Lakme','beauty brands'); --22
    

    -- insert category records
    inventory_utils.insert_category(c_category_id, 'Electronics','Contains all electronic categories'); --1
    inventory_utils.insert_category(c_category_id, 'General Shopping','General shopping of all brands'); --2
    inventory_utils.insert_category(c_category_id, 'Pharmacy', 'Medical and surgery stuff'); --3
    inventory_utils.insert_category(c_category_id, 'Beauty', 'Beauty products'); --4
    inventory_utils.insert_category(c_category_id, 'Apparels', 'Various apparels category'); --5
    inventory_utils.insert_category(c_category_id, 'Telecom', 'Various telecom products'); --6
    inventory_utils.insert_category(c_category_id, 'Laptop', 'Major laptop brands'); --7
    inventory_utils.insert_category(c_category_id, 'Appliance', 'Appliance store'); --8
    inventory_utils.insert_category(c_category_id, 'Stationary', 'School supplies'); --9
    

    
    
    
    -- insert products
    inventory_utils.insert_product(c_product_id, 'MacBook Pro 14 Inch 2021', 100, 1999, 7, 7, 1);
    inventory_utils.insert_product(c_product_id, 'Apple Magic Keyboard', 100, 1399, 1, 7, 1);
    
    inventory_utils.insert_product(c_product_id, 'Dell Latitude 13 Inch', 100, 799, 7, 9, 1);
    inventory_utils.insert_product(c_product_id, 'Dell Headphones', 100, 799, 1, 9, 1);
    
    inventory_utils.insert_product(c_product_id, 'HP Inspiron 16 Inch 2021', 100, 1099, 7, 6, 1);
    inventory_utils.insert_product(c_product_id, 'HP Mouse Bluetooth', 100, 499, 1, 6, 1);
    
    inventory_utils.insert_product(c_product_id, 'Mosiso Hardcase - 14 Inch', 100, 25, 2, 8, 1);
    inventory_utils.insert_product(c_product_id, 'Mosiso Sleeve Bag', 100, 49, 2, 8, 1);
    
    
     inventory_utils.insert_product(c_product_id, 'Night Lamp',50,30,8,1,1);--1
    inventory_utils.insert_product(c_product_id, 'Sofa',60,200,8,1,1);--1
    inventory_utils.insert_product(c_product_id, 'Bedcovers',70,40,2,2,1);--2
    inventory_utils.insert_product(c_product_id, 'Pillows',10,20,2,2,1);--2
    inventory_utils.insert_product(c_product_id, 'Rice',90,30,2,3,1);--3
    inventory_utils.insert_product(c_product_id, 'Milk',11,10,2,3,1);--3
    inventory_utils.insert_product(c_product_id, 'Power Bank',12,40,6,4,1);--4
    inventory_utils.insert_product(c_product_id, 'Switches',12,20,6,4,1);--4
    inventory_utils.insert_product(c_product_id, 'Laptop Cord',13,35,7,5,1);--5
    inventory_utils.insert_product(c_product_id, 'Wireless Mouse',70,30,7,5,1);--5
    inventory_utils.insert_product(c_product_id, 'Nike Jordans',10,90,5,10,1);--10
    inventory_utils.insert_product(c_product_id, 'Headband',100,15,5,10,1);--10
     inventory_utils.insert_product(c_product_id, 'Cropped Tshirt',100,40,5,11,1);--11
    inventory_utils.insert_product(c_product_id, 'Leggings',100,23,5,11,1);--11
    inventory_utils.insert_product(c_product_id, 'Refridgerator',50,500,1,12,1);--12
    inventory_utils.insert_product(c_product_id, 'Air Conditioner',20,400,1,12,1);--12
    inventory_utils.insert_product(c_product_id, 'Mixer',20,70,8,13,1);--13
    inventory_utils.insert_product(c_product_id, 'Purifier',30,70,8,13,1);--13
    inventory_utils.insert_product(c_product_id, 'Laptop',700,2000,7,14,1);--14
    inventory_utils.insert_product(c_product_id, 'Hard disk',300,70,7,14,1);--14
    inventory_utils.insert_product(c_product_id, 'Heay Patches',25,9,3,15,1);--15
    inventory_utils.insert_product(c_product_id, 'Relief Spray',45,12,3,15,1);--15
     inventory_utils.insert_product(c_product_id, 'Bandages',70,6,3,16,1);--16
    inventory_utils.insert_product(c_product_id, 'Burn Ointment',30,9,3,16,1);--16
    inventory_utils.insert_product(c_product_id, 'Eraser',60,2,9,17,1);--17
    inventory_utils.insert_product(c_product_id, 'Coloured Pens',100,7,9,17,1);--17
    inventory_utils.insert_product(c_product_id, 'Paper Cutter',70,10,9,18,1);--18
    inventory_utils.insert_product(c_product_id, 'Glue',100,10,9,18,1);--18
    inventory_utils.insert_product(c_product_id, 'Electric Bicycle',30,300,2,19,1);--19
    inventory_utils.insert_product(c_product_id, 'Batteries',400,15,6,19,1);--19
    inventory_utils.insert_product(c_product_id, 'Charging Cords',200,40,6,20,1);--20
    inventory_utils.insert_product(c_product_id, 'Extension Board',50,20,6,20,1);--20
    inventory_utils.insert_product(c_product_id, 'Beauty Blender',500,10,4,21,1);--21
    inventory_utils.insert_product(c_product_id, 'Face Cream',600,20,4,21,1);--21
    inventory_utils.insert_product(c_product_id, 'Foundation',800,50,4,22,1);--22
    inventory_utils.insert_product(c_product_id, 'Concealer',600,35,4,22,1);--22
    
 
commit;
END;
/

