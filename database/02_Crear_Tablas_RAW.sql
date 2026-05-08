USE DB_OLIST;
GO
PRINT(' CREACIÓN DE TABLAS ORIGEN EN LA CAPA RAW ')
PRINT('-------------------------------------------------------
------------------- TABLA: Customers -------------------')
DROP TABLE IF EXISTS RAW.Customers;
GO
BEGIN TRY
	CREATE TABLE RAW.Customers(
		customer_id NVARCHAR(255),
		customer_unique_id NVARCHAR(255),
		customer_zip_code_prefix NVARCHAR(255),
		customer_city NVARCHAR(255),
		customer_state NVARCHAR(255)
	);
	PRINT('RAW.Customers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Customers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
    PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH;
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Geolocation ------------------')
DROP TABLE IF EXISTS RAW.Geolocation
GO
BEGIN TRY
	CREATE TABLE RAW.Geolocation(
		geolocation_zip_code_prefix NVARCHAR(255),
		geolocation_lat NVARCHAR(255),
		geolocation_lng NVARCHAR(255),
		geolocation_city NVARCHAR(255),
		geolocation_state NVARCHAR(255)
	);
	PRINT('RAW.Geolocation creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Geolocation debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Items -------------------')
DROP TABLE IF EXISTS RAW.Items
GO
BEGIN TRY
	CREATE TABLE RAW.Items(
		order_id NVARCHAR(255),
		order_item_id NVARCHAR(255),
		product_id NVARCHAR(255),
		seller_id NVARCHAR(255),
		shipping_limit_date NVARCHAR(255),
		price NVARCHAR(255),
		freight_value NVARCHAR(255)
	);
	PRINT('RAW.Items creado correctamente')
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Items debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: PAYMENTS -------------------')
DROP TABLE IF EXISTS RAW.Payments
GO
BEGIN TRY
	CREATE TABLE RAW.Payments(
		order_id NVARCHAR(255),
		payment_sequential NVARCHAR(255),
		payment_type NVARCHAR(255),
		payment_installments NVARCHAR(255),
		payment_value NVARCHAR(255)
	);
	PRINT('RAW.Payments creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Payments debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: REVIEWS -------------------')
DROP TABLE IF EXISTS RAW.Reviews
GO
BEGIN TRY
	CREATE TABLE RAW.Reviews(
		review_id NVARCHAR(255),
		order_id NVARCHAR(255),
		review_score NVARCHAR(255),
		review_comment_title NVARCHAR(255),
		review_comment_message NVARCHAR(MAX),
		review_creation_date NVARCHAR(255),
		review_answer_timestamp NVARCHAR(255)
	);
	PRINT('RAW.Reviews creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Reviews debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Orders -------------------')
DROP TABLE IF EXISTS  RAW.Orders
GO
BEGIN TRY
	CREATE TABLE RAW.Orders(
		order_id NVARCHAR(255),
		customer_id NVARCHAR(255),
		order_status NVARCHAR(255),
		order_purchase_timestamp NVARCHAR(255),
		order_approved_at NVARCHAR(255),
		order_delivered_carrier_date NVARCHAR(255),
		order_delivered_customer_date NVARCHAR(255),
		order_estimated_delivery_date NVARCHAR(255),
	);
	PRINT('RAW.Orders creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Orders debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Products -------------------')
DROP TABLE IF EXISTS RAW.Products
GO
BEGIN TRY
	CREATE TABLE RAW.Products(
		product_id NVARCHAR(255),
		product_category_name NVARCHAR(255),
		product_name_lenght NVARCHAR(255),
		product_description_lenght NVARCHAR(255),
		product_photos_qty NVARCHAR(255),
		product_weight_g NVARCHAR(255),
		product_length_cm NVARCHAR(255),
		product_height_cm NVARCHAR(255),
		product_width_cm NVARCHAR(255)
	);
	PRINT('RAW.Products creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Products debido a un error');
	PRINT('Mensaje:' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Nínea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Sellers -------------------')
DROP TABLE IF EXISTS  RAW.Sellers
GO
BEGIN TRY
	CREATE TABLE RAW.Sellers(
		seller_id NVARCHAR(255),
		seller_zip_code_prefix NVARCHAR(255),
		seller_city NVARCHAR(255),
		seller_state NVARCHAR(255)
	);
	PRINT('RAW.Sellers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Sellers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO

PRINT('-------------------------------------------------------
------------------- TABLA: Category -------------------')
DROP TABLE IF EXISTS  RAW.Category
GO
BEGIN TRY
	CREATE TABLE RAW.Category(
		product_category_name NVARCHAR(255),
		product_category_name_english NVARCHAR(255)
	);
	PRINT('RAW.Category creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla RAW.Category debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
FIN DE CREACIÓN DE TABLAS ORIGEN EN LA CAPA RAW ')