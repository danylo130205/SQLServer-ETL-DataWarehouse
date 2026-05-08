USE DB_OLIST;
GO
/* Creacion de tablas en la capa STAGING
usando de guia las longitudes y tipos
definidos en el anterior Query*/

PRINT(' CREACIÓN DE TABLAS ORIGEN EN LA CAPA STAGING ')
PRINT('-------------------------------------------------------
------------------- TABLA: Customers -------------------')
DROP TABLE IF EXISTS STAGING.Customers;
GO
BEGIN TRY
	CREATE TABLE STAGING.Customers(
		customer_id NVARCHAR(32),
		customer_unique_id NVARCHAR(32),
		customer_zip_code_prefix NVARCHAR(5),
		customer_city NVARCHAR(32),
		customer_state NVARCHAR(2)
	);
	PRINT('STAGING.Customers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Customers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
    PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH;
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Geolocation ------------------')
DROP TABLE IF EXISTS STAGING.Geolocation
GO
BEGIN TRY
	CREATE TABLE STAGING.Geolocation(
		geolocation_zip_code_prefix NVARCHAR(5),
		geolocation_lat DECIMAL(21,19),
		geolocation_lng DECIMAL(17,15),
		geolocation_city NVARCHAR(38),
		geolocation_state NVARCHAR(2)
	);
	PRINT('STAGING.Geolocation creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Geolocation debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Items -------------------')
DROP TABLE IF EXISTS STAGING.Items
GO
BEGIN TRY
	CREATE TABLE STAGING.Items(
		order_id NVARCHAR(32),
		order_item_id INT,
		product_id NVARCHAR(32),
		seller_id NVARCHAR(32),
		shipping_limit_date DATETIME2,
		price DECIMAL(6,2),
		freight_value DECIMAL(5,2)
	);
	PRINT('STAGING.Items creado correctamente')
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Items debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: PAYMENTS -------------------')
DROP TABLE IF EXISTS STAGING.Payments
GO
BEGIN TRY
	CREATE TABLE STAGING.Payments(
		order_id NVARCHAR(32),
		payment_sequential INT,
		payment_type NVARCHAR(11),
		payment_installments INT,
		payment_value DECIMAL(7,2)
	);
	PRINT('STAGING.Payments creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Payments debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: REVIEWS -------------------')
DROP TABLE IF EXISTS STAGING.Reviews
GO
BEGIN TRY
	CREATE TABLE STAGING.Reviews(
		review_id NVARCHAR(32),
		order_id NVARCHAR(32),
		review_score INT,
		review_comment_title NVARCHAR(26),
		review_comment_message NVARCHAR(MAX),
		review_creation_date DATETIME2,
		review_answer_timestamp DATETIME2
	);
	PRINT('STAGING.Reviews creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Reviews debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Orders -------------------')
DROP TABLE IF EXISTS  STAGING.Orders
GO
BEGIN TRY
	CREATE TABLE STAGING.Orders(
		order_id NVARCHAR(32),
		customer_id NVARCHAR(32),
		order_status NVARCHAR(11),
		order_purchase_timestamp DATETIME2,
		order_approved_at DATETIME2,
		order_delivered_carrier_date DATETIME2,
		order_delivered_customer_date DATETIME2,
		order_estimated_delivery_date DATETIME2
	);
	PRINT('STAGING.Orders creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Orders debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Products -------------------')
DROP TABLE IF EXISTS STAGING.Products
GO
BEGIN TRY
	CREATE TABLE STAGING.Products(
		product_id NVARCHAR(32),
		product_category_name NVARCHAR(50),
		product_name_lenght INT,
		product_description_lenght INT,
		product_photos_qty INT,
		product_weight_g INT,
		product_length_cm INT,
		product_height_cm INT,
		product_width_cm INT
	);
	PRINT('STAGING.Products creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Products debido a un error');
	PRINT('Mensaje:' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Nínea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Sellers -------------------')
DROP TABLE IF EXISTS  STAGING.Sellers
GO
BEGIN TRY
	CREATE TABLE STAGING.Sellers(
		seller_id NVARCHAR(32),
		seller_zip_code_prefix NVARCHAR(5),
		seller_city NVARCHAR(40),
		seller_state NVARCHAR(2)
	);
	PRINT('STAGING.Sellers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Sellers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO

PRINT('-------------------------------------------------------
------------------- TABLA: Category -------------------')
DROP TABLE IF EXISTS  STAGING.Category
GO
BEGIN TRY
	CREATE TABLE STAGING.Category(
		product_category_name NVARCHAR(46),
		product_category_name_english NVARCHAR(39)
	);
	PRINT('STAGING.Category creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla STAGING.Category debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
FIN DE CREACIÓN DE TABLAS ORIGEN EN LA CAPA STAGING ')

