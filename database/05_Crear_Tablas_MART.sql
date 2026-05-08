USE DB_OLIST;
GO
---- Creando lsa tablas de mart
PRINT(' CREACIÓN DE TABLAS ORIGEN EN LA CAPA MART ')
PRINT('-------------------------------------------------------
------------------- TABLA: Customers -------------------')
DROP TABLE IF EXISTS MART.DIM_Customers;
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Customers(
		customer_unique_id NVARCHAR(32) NOT NULL,
		customer_city NVARCHAR(32) NULL,
		customer_state NVARCHAR(2) NULL,
		customer_lat DECIMAL(21,19) NULL,
		customer_lng DECIMAL (17,15) NULL,
		CONSTRAINT PK_Customers PRIMARY KEY (customer_unique_id)
		--- OJO: al llenar la tabla ahcer un join con customer_zip_code_prefix con la tabla geo, apra sacar los datos de geolocation de los customers.
		--- OJO: aqui no hay customer_id, la cual esta en orders y payments. para unir la dim y la fact se debe sacar el unique_id mediante un join entre la pocresing.customers y la fact
	);
	PRINT('MART.Customers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Customers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE());
    PRINT('Número: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Línea: ' + CAST(ERROR_LINE() AS NVARCHAR));
END CATCH;
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Products -------------------')
DROP TABLE IF EXISTS MART.DIM_Products
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Products(
		product_id NVARCHAR(32) NOT NULL,
		product_category_name NVARCHAR(50) NULL,
		product_category_name_english NVARCHAR(39) NULL,
		product_name_lenght INT NULL,
		product_description_lenght INT NULL,
		product_photos_qty INT NULL,
		product_weight_g INT NULL,
		product_length_cm INT NULL,
		product_height_cm INT NULL,
		product_width_cm INT NULL,
		CONSTRAINT PK_Products PRIMARY KEY (product_id)
	);
	PRINT('MART.Products creado correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Products debido a un error');
	PRINT('Mensaje:' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Nínea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO
PRINT('-------------------------------------------------------
------------------- TABLA: Sellers -------------------')
DROP TABLE IF EXISTS  MART.DIM_Sellers
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Sellers(
		seller_id NVARCHAR(32) NOT NULL,
		seller_city NVARCHAR(40) NULL,
		seller_state NVARCHAR(2) NULL,
		seller_lat DECIMAL(21,19) NULL,
		seller_lng DECIMAL (17,15) NULL,
		CONSTRAINT PK_Sellers PRIMARY KEY (seller_id)
	);
	PRINT('MART.Sellers creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Sellers debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO 
PRINT('-------------------------------------------------------
------------------- TABLA: DATE  -------------------')
DROP TABLE IF EXISTS  MART.DIM_Date
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Date(
		DateKey INT NOT NULL PRIMARY KEY, 
		FullDate DATE NOT NULL,
		Year INT NOT NULL,
		Quarter INT NOT NULL,
		Month INT NOT NULL,
		MonthName VARCHAR(15) NOT NULL,
		DayOfMonth INT NOT NULL,
		DayOfWeek INT NOT NULL,
		DayOfWeekName VARCHAR(15) NOT NULL,
		WeekOfYear INT NOT NULL,
		IsWeekend BIT
	);
	PRINT('MART.Date creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Date debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO 
PRINT('-------------------------------------------------------
------------------- TABLA: SALES  -------------------')
DROP TABLE IF EXISTS  MART.FACT_Sales
GO
BEGIN TRY
	CREATE TABLE MART.FACT_Sales(
		order_id NVARCHAR(32) NOT NULL,
		order_item_id INT NOT NULL,
		product_id NVARCHAR(32) NOT NULL,
		seller_id NVARCHAR(32) NOT NULL,
		customer_unique_id NVARCHAR(32) NOT NULL,
		DateKey INT NOT NULL,
		order_status NVARCHAR(11) NOT NULL,
		order_purchase_timestamp DATETIME2 NOT NULL,
		shipping_limit_date DATETIME2 NULL,
		price DECIMAL(6,2) NOT NULL,
		freight_value DECIMAL(5,2) NOT NULL,
		CONSTRAINT PK_Items PRIMARY KEY (order_id,order_item_id)
	);
	PRINT('MART.Sales creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.SALES debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO 
PRINT('-------------------------------------------------------
------------------- TABLA: PAYMENTS  -------------------')
DROP TABLE IF EXISTS  MART.DIM_Payments
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Payments(
		order_id NVARCHAR(32) NOT NULL,
		payment_types NVARCHAR(255) NULL,
		payment_installments INT NULL,
		CONSTRAINT PK_Payments PRIMARY KEY (order_id)
	);
	PRINT('MART.Date creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Date debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número: ' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ));
END CATCH
GO 
PRINT('-------------------------------------------------------
------------------- TABLA: REVIEWS -------------------')
DROP TABLE IF EXISTS MART.DIM_Reviews
GO
BEGIN TRY
	CREATE TABLE MART.DIM_Reviews(
		order_id NVARCHAR(32) NOT NULL,
		review_count INT NULL,
		avg_review_score DECIMAL(3,2) NULL,
		max_review_score INT NULL,
		min_review_score INT NULL,

    CONSTRAINT PK_Reviews PRIMARY KEY(order_id)
	);
	PRINT('MART.Reviews creada correctamente');
END TRY
BEGIN CATCH
	PRINT('No se creó la tabla MART.Reviews debido a un error');
	PRINT('Mensaje: ' + ERROR_MESSAGE() );
	PRINT('Número' + CAST( ERROR_NUMBER() AS NVARCHAR ) );
	PRINT('Línea: ' + CAST( ERROR_LINE() AS NVARCHAR ) );
END CATCH
GO