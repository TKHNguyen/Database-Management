
/*
course: COMP2138
name: Hoa Nguyen
student ID: 100959069
*/
--1--
SELECT CATEGORIES.CATEGORY_NAME , count(PRODUCTS.PRODUCT_ID) as count_of_product, max(PRODUCTS.LIST_PRICE)
FROM CATEGORIES join PRODUCTS on PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID
group by CATEGORIES.CATEGORY_NAME
order by count_of_product desc; 


--2--
SELECT customers.email_address, sum(order_items.item_price*order_items.quantity)as total_items_prices,
sum(order_items.discount_amount*order_items.quantity)as total_discount
FROM customers join orders on orders.customer_id = customers.customer_id 
join order_items on orders.order_id = order_items.order_id
group by customers.email_address
order by total_items_prices desc;

--3
SELECT distinct customers.email_address, count( distinct orders.ORDER_ID) as number_of_order, 
sum((order_items.item_price - order_items.discount_amount)*(order_items.quantity)) as total_amount
FROM customers join orders on orders.customer_id = customers.customer_id 
join order_items on orders.order_id = order_items.order_id
group by customers.email_address
having count( distinct orders.ORDER_ID)>1
order by number_of_order desc;




--4 --
SELECT products.product_name,
sum((order_items.item_price - order_items.discount_amount)*order_items.quantity) as total_amount
FROM products join order_items on products.product_id = order_items.product_id
group by rollup(products.product_name);

--5--
SELECT distinct customers.email_address, count(distinct products.PRODUCT_NAME)as product_count
FROM customers join orders on orders.customer_id = customers.customer_id 
join order_items on orders.order_id = order_items.order_id 
join products on products.product_id = order_items.product_id
group by customers.email_address
having count(distinct products.PRODUCT_NAME)>1 ;

--6--
SELECT distinct CATEGORIES.CATEGORY_NAME FROM CATEGORIES 
where CATEGORY_ID in
(SELECT CATEGORIES.CATEGORY_ID FROM PRODUCTS
where products.CATEGORY_ID = categories.CATEGORY_ID)
order by CATEGORIES.CATEGORY_NAME;

--7--
SELECT product_name, list_price FROM PRODUCTS
where list_price>(SELECT avg(list_price) FROM PRODUCTS)
order by LIST_PRICE desc;

--8--
SELECT distinct CATEGORY_NAME FROM CATEGORIES 
where not exists
(SELECT * FROM products where products.CATEGORY_ID = CATEGORIES.CATEGORY_ID);

--9--

select distinct product_name, DISCOUNT_PERCENT from PRODUCTS 
where PRODUCT_NAME <> all
(SELECT distinct p1.PRODUCT_NAME FROM PRODUCTS p1, PRODUCTS  p2
where  p1.DISCOUNT_PERCENT = p2.DISCOUNT_PERCENT and p1.product_name<>p2.product_name)
order by PRODUCT_NAME;

--10--
SELECT CUSTOMERS.EMAIL_ADDRESS, ORDERS.ORDER_ID, ORDERS.ORDER_DATE 
FROM CUSTOMERS join ORDERS on customers.customer_id = orders.customer_id
where ORDERS.ORDER_DATE = any (
select min(orders.order_date) FROM CUSTOMERS join ORDERS on customers.customer_id = orders.customer_id
group by CUSTOMERS.EMAIL_ADDRESS);




