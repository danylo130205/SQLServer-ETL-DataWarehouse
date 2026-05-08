USE DB_OLIST;
GO
-----DETERMINAR LONGITUDES
PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Customers')
SELECT
	MAX(LEN(TRIM(customer_id))) AS len_customer_id,
	MAX(LEN(TRIM(customer_unique_id))) AS len_customer_unique_id,
	MAX(LEN(TRIM(customer_zip_code_prefix))) AS len_customer_zip_code_prefix,
	MAX(LEN(TRIM(customer_city))) AS len_customer_city,
	MAX(LEN(TRIM(customer_state))) AS len_customer_state
FROM RAW.Customers 
SELECT * FROM RAW.Customers
-- La longitud maxima del customer_id NVARCHAR(32)
-- La longitud maxima del customer_unique_id NVARCHAR(32)
-- La longitud maxima del customer_zip_code_prefix NVARCHAR(5)
-- La longitud maxima del customer_citycustomer_city NVARCHAR(32)
-- La longitud maxima del customer_state NVARCHAR(2)

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Geolocation')
SELECT
	MAX(LEN(TRIM(geolocation_zip_code_prefix))) AS len_geolocation_zip_code_prefix,
	MAX(LEN(TRIM(geolocation_lat))) AS len_geolocation_lat,
	MAX(LEN(TRIM(geolocation_lng))) AS len_geolocation_lng,
	MAX(LEN(TRIM(geolocation_city))) AS len_geolocation_city,
	MAX(LEN(TRIM(geolocation_state))) AS len_geolocation_state
FROM RAW.Geolocation
SELECT * FROM RAW.Geolocation
-- La longitud maxima del geolocation_zip_code_prefix NVARCHAR(5)
-- La longitud maxima del geolocation_lat DECIMAL(21,19)
-- La longitud maxima del geolocation_lng DECIMAL(17,15)
-- La longitud maxima del geolocation_city NVARCHAR(38)
-- La longitud maxima del geolocation_state NVARCHAR(2)
PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Items')
SELECT
	MAX(LEN(TRIM(order_id))) AS len_order_id,
	MAX(LEN(TRIM(order_item_id))) AS len_order_item_id,
	MAX(LEN(TRIM(product_id))) AS len_product_id,
	MAX(LEN(TRIM(seller_id))) AS len_seller_id,
	MAX(LEN(TRIM(shipping_limit_date))) AS len_hipping_limit_date,
	MAX(LEN(TRIM(price))) AS len_price,
	MAX(LEN(TRIM(freight_value))) AS len_freight_value
FROM RAW.Items
SELECT * FROM RAW.Items
-- La longitud maxima del order_id NVARCHAR(32)
-- La longitud maxima del order_item_id NVARCHAR(2)
-- La longitud maxima del product_id NVARCHAR(32)
-- La longitud maxima del seller_id NVARCHAR(32)
-- La longitud maxima del shipping_limit_date DATETIME
-- La longitud maxima del price DECIMAL(6,2)
-- La longitud maxima del freight_value DECIMAL(5,2)

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Payments')
SELECT
	MAX(LEN(TRIM(order_id))) AS len_order_id,
	MAX(LEN(TRIM(payment_sequential))) AS len_payment_sequentia,
	MAX(LEN(TRIM(payment_type))) AS len_ayment_typ,
	MAX(LEN(TRIM(payment_installments))) AS len_payment_installments,
	MAX(LEN(TRIM(payment_value))) AS len_payment_value
	
FROM RAW.Payments
SELECT * FROM RAW.Payments
-- La longitud maxima del order_id NVARCHAR(32)
-- La longitud maxima del payment_sequential NVARCHAR(2)
-- La longitud maxima del payment_type NVARCHAR(11)
-- La longitud maxima del payment_installments NVARCHAR(2)
-- La longitud maxima del payment_value DECIMAL(7,2)

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Reviews')
SELECT
	MAX(LEN(TRIM(review_id))) AS len_review_id,
	MAX(LEN(TRIM(order_id))) AS len_order_id,
	MAX(LEN(TRIM(review_score))) AS len_review_score,
	MAX(LEN(TRIM(review_comment_title))) AS len_review_comment_title,
	MAX(LEN(TRIM(review_comment_message))) AS len_review_comment_message,
	MAX(LEN(TRIM(review_creation_date))) AS len_review_creation_date,
	MAX(LEN(TRIM(review_answer_timestamp))) AS len_review_answer_timestam
	
FROM RAW.Reviews
SELECT * FROM RAW.Reviews
-- La longitud maxima del review_id  NVARCHAR(32)
-- La longitud maxima del order_id  NVARCHAR(32)
-- La longitud maxima del review_score  NVARCHAR(1)
-- La longitud maxima del review_comment_title  NVARCHAR(26)
-- La longitud maxima del review_comment_message  NVARCHAR(255)
-- La longitud maxima del review_creation_date DATETIME
-- La longitud maxima del review_answer_timestamp DATETIME

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Orders')
SELECT
	MAX(LEN(TRIM(order_id))) AS len_order_id,
	MAX(LEN(TRIM(customer_id))) AS len_customer_id,
	MAX(LEN(TRIM(order_status))) AS len_order_status,
	MAX(LEN(TRIM(order_purchase_timestamp))) AS len_order_purchase_timestamp,
	MAX(LEN(TRIM(order_approved_at))) AS len_order_approved_at,
	MAX(LEN(TRIM(order_delivered_carrier_date))) AS len_order_delivered_carrier_date,
	MAX(LEN(TRIM(order_delivered_customer_date))) AS len_order_delivered_customer_date,
	MAX(LEN(TRIM(order_estimated_delivery_date))) AS len_order_estimated_delivery_date	
FROM RAW.Orders
SELECT * FROM RAW.Orders
-- La longitud maxima del order_id  NVARCHAR(32)
-- La longitud maxima del customer_id  NVARCHAR(32)
-- La longitud maxima del order_status  NVARCHAR(11)
-- La longitud maxima del order_purchase_timestamp DATETIME
-- La longitud maxima del order_approved_at DATETIME
-- La longitud maxima del order_delivered_carrier_date DATETIME
-- La longitud maxima del order_delivered_customer_date DATETIME
-- La longitud maxima del order_estimated_delivery_date DATETIME

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Products')
SELECT
	MAX(LEN(TRIM(product_id))) AS len_product_id,
	MAX(LEN(TRIM(product_category_name))) AS len_product_category_name,
	MAX(LEN(TRIM(product_name_lenght))) AS len_product_name_lenght,
	MAX(LEN(TRIM(product_description_lenght))) AS len_product_description_lenght,
	MAX(LEN(TRIM(product_photos_qty))) AS len_product_photos_qty,
	MAX(LEN(TRIM(product_weight_g))) AS len_product_weight_g,
	MAX(LEN(TRIM(product_length_cm))) AS len_product_length_cm,
	MAX(LEN(TRIM(product_height_cm))) AS len_product_height_cm,
	MAX(LEN(TRIM(product_width_cm))) AS len_product_width_cm
FROM RAW.Products
SELECT * FROM RAW.Products
-- La longitud maxima del product_id  NVARCHAR(32)
-- La longitud maxima del product_category_name  NVARCHAR(50)
-- La longitud maxima del product_name_lenght INT
-- La longitud maxima del product_description_lenght INT
-- La longitud maxima del product_photos_qty INT
-- La longitud maxima del product_weight_g INT
-- La longitud maxima del product_length_cm INT
-- La longitud maxima del product_height_cm INT
-- La longitud maxima del product_width_cm INT

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Sellers')
SELECT
	MAX(LEN(TRIM(seller_id))) AS len_seller_id,
	MAX(LEN(TRIM(seller_zip_code_prefix))) AS len_seller_zip_code_prefix,
	MAX(LEN(TRIM(seller_city))) AS len_seller_city,
	MAX(LEN(TRIM(seller_state))) AS len_seller_state
FROM RAW.Sellers
SELECT * FROM RAW.Sellers
-- La longitud maxima del seller_id  NVARCHAR(32)
-- La longitud maxima del seller_zip_code_prefix  NVARCHAR(5)
-- La longitud maxima del seller_city  NVARCHAR(40)
-- La longitud maxima del seller_state  NVARCHAR(2)

PRINT('#---------------------------------------------#')

PRINT('#---------------------------------------------#')
PRINT('Determinar longitudes de la tabla Category')
SELECT
	MAX(LEN(TRIM(product_category_name ))) AS len_product_category_name,
	MAX(LEN(TRIM(product_category_name_english ))) AS len_product_category_name_english
FROM RAW.Category
SELECT * FROM RAW.Category
-- La longitud maxima del product_category_name NVARCHAR(46)
-- La longitud maxima del product_category_name_english NVARCHAR(39)

PRINT('#---------------------------------------------#')
