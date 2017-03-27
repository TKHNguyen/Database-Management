/*
   Assignment 2
Course: COMP2138
Name:   Hoa Nguyen
ID:     100959069
*/
--1--
CREATE OR REPLACE PROCEDURE insert_category 
(
  category_name_param  VARCHAR2
)
AS
  v_category_id NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_category_id FROM CATEGORIES;
  INSERT INTO CATEGORIES
  VALUES (v_category_id + 1, category_name_param);
  COMMIT;
END;
/
--CALL statement that test procedure
CALL INSERT_CATEGORY('Piano1');
CALL INSERT_CATEGORY('Violin2');


--2--
CREATE OR REPLACE FUNCTION discount_price
(
  item_id_param NUMBER
)
RETURN NUMBER
AS
  discount_price NUMBER;
BEGIN 
  SELECT (item_price - discount_amount) INTO discount_price FROM order_items
  WHERE item_id =  item_id_param;
  RETURN discount_price;
END;
/
--SELECT statement that test this function
SELECT ITEM_ID, ITEM_PRICE,
DISCOUNT_PRICE(ITEM_ID) AS DISCOUNT_PRICE
FROM ORDER_ITEMS;

--3--
CREATE OR REPLACE TRIGGER product_before_update
BEFORE UPDATE ON PRODUCTS
FOR EACH ROW
BEGIN
IF :NEW.DISCOUNT_PERCENT > 100  OR :NEW.DISCOUNT_PERCENT < 0 THEN
RAISE_APPLICATION_ERROR (-20000,
'This is not a valid discount percent');
END IF;
IF :NEW.DISCOUNT_PERCENT > 0 AND :NEW.DISCOUNT_PERCENT < 1 THEN
    :NEW.DISCOUNT_PERCENT := :NEW.DISCOUNT_PERCENT *100;
END IF;
END;
/
--UPDATE statement to test this trigger
 UPDATE products 
 SET discount_percent = 0.2
 WHERE product_id=2;
 
 --4--
 CREATE OR REPLACE TRIGGER products_before_insert
BEFORE INSERT ON PRODUCTS
FOR EACH ROW
BEGIN
IF :NEW.DATE_ADDED IS NULL THEN
  :NEW.DATE_ADDED := SYSDATE;
END IF;
END;
/
--INSERT statement to test this trigger
INSERT INTO products (PRODUCT_ID, CATEGORY_ID, PRODUCT_CODE, PRODUCT_NAME,
DESCRIPTION, LIST_PRICE, DISCOUNT_PERCENT, DATE_ADDED)
VALUES (13,3,'sg1','Gibson SG','This Gibson',40.00,20,NULL);
 
 
 
