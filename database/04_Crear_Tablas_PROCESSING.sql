USE DB_OLIST;
GO
/* Creacion de tablas en la capa PROCESSING
usando de guia las longitudes y tipos
definidos en el anterior Query*/

PRINT(' CREACIÓN DE TABLAS ORIGEN EN LA CAPA PROCESSING ')
PRINT('-------------------------------------------------------
------------------- TABLA: Customers -------------------')
DROP TABLE IF EXISTS PROCESSING.Customers;
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Customers(
		customer_id NVARCHAR(32) NOT NULL,
		customer_unique_id NVARCHAR(32) NOT NULL ,
		customer_zip_code_prefix NVARCHAR(5) NULL,
		customer_city NVARCHAR(32) NULL,
		customer_state NVARCHAR(2) NULL,
		CONSTRAINT PK_Customers PRIMARY KEY (customer_id)
	);
	PRINT('PROCESSING.Customers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Customers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
    PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH;
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Geolocation ------------------')
DROP TABLE IF EXISTS PROCESSING.Geolocation
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Geolocation(
		geolocation_zip_code_prefix NVARCHAR(5) NOT NULL ,
		geolocation_lat DECIMAL(21,19) NULL,
		geolocation_lng DECIMAL(17,15) NULL,
		geolocation_city NVARCHAR(38) NOT NULL,
		geolocation_state NVARCHAR(2) NOT NULL
	);
	PRINT('PROCESSING.Geolocation creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Geolocation debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Items -------------------')
DROP TABLE IF EXISTS PROCESSING.Items
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Items(
		order_id NVARCHAR(32) NOT NULL,
		order_item_id INT NOT NULL,
		product_id NVARCHAR(32) NOT NULL,
		seller_id NVARCHAR(32) NOT NULL,
		shipping_limit_date DATETIME2 NULL,
		price DECIMAL(6,2) NOT NULL,
		freight_value DECIMAL(5,2) NOT NULL,
		CONSTRAINT PK_Items PRIMARY KEY (order_id,order_item_id)
	);
	PRINT('PROCESSING.Items creado correctamente')
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Items debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: PAYMENTS -------------------')
DROP TABLE IF EXISTS PROCESSING.Payments
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Payments(
		order_id NVARCHAR(32) NOT NULL,
		payment_sequential INT NOT NULL,
		payment_type NVARCHAR(11) NULL,
		payment_installments INT NULL,
		payment_value DECIMAL(7,2) NOT NULL,
		CONSTRAINT PK_Payments PRIMARY KEY (order_id,payment_sequential)
	);
	PRINT('PROCESSING.Payments creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Payments debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ));
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: REVIEWS -------------------')
DROP TABLE IF EXISTS PROCESSING.Reviews
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Reviews(
		review_id NVARCHAR(32) NOT NULL,
		order_id NVARCHAR(32) NOT NULL,
		review_score INT NOT NULL,
		review_comment_title NVARCHAR(26) NULL,
		review_comment_message NVARCHAR(MAX) NULL,
		review_creation_date DATETIME2 NOT NULL,
		review_answer_timestamp DATETIME2 NULL,
		CONSTRAINT PK_Reviews PRIMARY KEY (review_id)
	);
	PRINT('PROCESSING.Reviews creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Reviews debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Orders -------------------')
DROP TABLE IF EXISTS  PROCESSING.Orders
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Orders(
		order_id NVARCHAR(32) NOT NULL,
		customer_id NVARCHAR(32) NOT NULL,
		order_status NVARCHAR(11) NOT NULL,
		order_purchase_timestamp DATETIME2 NOT NULL,
		order_approved_at DATETIME2 NULL,
		order_delivered_carrier_date DATETIME2 NULL,
		order_delivered_customer_date DATETIME2 NULL,
		order_estimated_delivery_date DATETIME2 NULL,
		CONSTRAINT PK_Orders PRIMARY KEY (order_id)
	);
	PRINT('PROCESSING.Orders creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Orders debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Products -------------------')
DROP TABLE IF EXISTS PROCESSING.Products
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Products(
		product_id NVARCHAR(32) NOT NULL,
		product_category_name NVARCHAR(50) NULL,
		product_name_lenght INT NULL,
		product_description_lenght INT NULL,
		product_photos_qty INT NULL,
		product_weight_g INT NULL,
		product_length_cm INT NULL,
		product_height_cm INT NULL,
		product_width_cm INT NULL,
		CONSTRAINT PK_Products PRIMARY KEY (product_id)
	);
	PRINT('PROCESSING.Products creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Products debido a un error');
	PRINT('Mensaje:' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Nínea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Sellers -------------------')
DROP TABLE IF EXISTS  PROCESSING.Sellers
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Sellers(
		seller_id NVARCHAR(32) NOT NULL,
		seller_zip_code_prefix NVARCHAR(5) NULL,
		seller_city NVARCHAR(40) NULL,
		seller_state NVARCHAR(2) NULL,
		CONSTRAINT PK_Sellers PRIMARY KEY (seller_id)
	);
	PRINT('PROCESSING.Sellers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Sellers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO

PRINT('-------------------------------------------------------
------------------- TABLA: Category -------------------')
DROP TABLE IF EXISTS  PROCESSING.Category
GO
BEGIN TRY
	CREATE TABLE PROCESSING.Category(
		product_category_name NVARCHAR(46) NOT NULL,
		product_category_name_english NVARCHAR(39) NULL
	);
	PRINT('PROCESSING.Category creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla PROCESSING.Category debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO
PRINT('-------------------------------------------------------
FIN DE CREACIÓN DE TABLAS ORIGEN EN LA CAPA PROCESSING ')
