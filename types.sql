-- Product recommendation object
create or replace type product_obj as object(
product_id number,
product_name varchar2(50),
category_name varchar2(50)
);

create or replace type product_rec as table of product_obj;