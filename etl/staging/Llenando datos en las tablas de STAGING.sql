USE DB_OLIST;
GO
--Llenando datos en la capa STAGING
PRINT('#---------------------------------#')
PRINT('Llenando datos en Customers')
BEGIN TRY
BEGIN TRANSACTION

	BEGIN TRY
		INSERT INTO STAGING.Customers(
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state
		)
			SELECT
			NULLIF(TRIM(customer_id),''),
			NULLIF(TRIM(customer_unique_id),''),
			NULLIF(TRIM(customer_zip_code_prefix),''),
			UPPER(NULLIF(TRIM(customer_city),'')),
			UPPER(NULLIF(TRIM(customer_state),''))
		FROM RAW.Customers

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Geolocation')
	BEGIN TRY
		INSERT INTO STAGING.Geolocation(
			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		)
			SELECT
			NULLIF(TRIM(geolocation_zip_code_prefix),''),
			TRY_CAST(NULLIF(TRIM(geolocation_lat),'') AS DECIMAL (21,19)),
			TRY_CAST(NULLIF(TRIM(geolocation_lng),'') AS DECIMAL (17,15)),
			UPPER(NULLIF(TRIM(geolocation_city),'')),
			UPPER(NULLIF(TRIM(geolocation_state),''))
		FROM RAW.Geolocation
		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Items')
	BEGIN TRY
		INSERT INTO STAGING.Items(
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_value
		)
			SELECT
			NULLIF(TRIM(order_id),''),
			TRY_CAST(NULLIF(TRIM(order_item_id),'') AS INT),
			NULLIF(TRIM(product_id),''),
			NULLIF(TRIM(seller_id),''),
			TRY_CONVERT(DATETIME2, NULLIF(TRIM(shipping_limit_date),''), 120) ,
			TRY_CAST(NULLIF(TRIM(price),'') AS DECIMAL (6,2) ),
			TRY_CAST(NULLIF(TRIM(freight_value),'') AS DECIMAL (5,2) )
		
		FROM RAW.Items

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Payments')
	BEGIN TRY
		INSERT INTO STAGING.Payments(
			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
			SELECT
			NULLIF(TRIM(order_id),''),
			TRY_CAST(NULLIF(TRIM(payment_sequential),'') AS INT),
			UPPER(NULLIF(TRIM(payment_type),'')),
			TRY_CAST(NULLIF(TRIM(payment_installments),'') AS INT),
			TRY_CAST(NULLIF(TRIM(payment_value),'') AS DECIMAL(7,2))
		FROM RAW.Payments
		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Reviews')
	BEGIN TRY
		INSERT INTO STAGING.Reviews(
			review_id,
			order_id,
			review_score,
			review_comment_title,
			review_comment_message,
			review_creation_date,
			review_answer_timestamp
		)
			SELECT
			NULLIF(TRIM(review_id),''),
			NULLIF(TRIM(order_id),''),
			TRY_CAST(NULLIF(TRIM(review_score),'') AS INT),
			NULLIF(TRIM(review_comment_title),''),
			NULLIF(TRIM(review_comment_message),''),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(review_creation_date),''),120),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(review_answer_timestamp),''),120)
		FROM RAW.Reviews

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Orders')
	BEGIN TRY
		INSERT INTO STAGING.Orders(
			order_id,
			customer_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		)
			SELECT
			NULLIF(TRIM(order_id),''),
			NULLIF(TRIM(customer_id),''),
			UPPER(NULLIF(TRIM(order_status),'')),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(order_purchase_timestamp),''),120),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(order_approved_at),''),120),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(order_delivered_carrier_date),''),120),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(order_delivered_customer_date),''),120),
			TRY_CONVERT( DATETIME2,NULLIF(TRIM(order_estimated_delivery_date),''),120)
		FROM RAW.Orders
		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Products')
	BEGIN TRY
		INSERT INTO STAGING.Products(
			product_id,
			product_category_name,
			product_name_lenght,
			product_description_lenght,
			product_photos_qty,
			product_weight_g,
			product_length_cm,
			product_height_cm,
			product_width_cm
		)
			SELECT
			NULLIF(TRIM(product_id),''),
			NULLIF(TRIM(product_category_name),''),
			TRY_CAST(NULLIF(TRIM(product_name_lenght),'') AS INT),
			TRY_CAST(NULLIF(TRIM(product_description_lenght),'')AS INT),
			TRY_CAST(NULLIF(TRIM(product_photos_qty),'') AS INT),
			TRY_CAST(NULLIF(TRIM(product_weight_g),'') AS INT),
			TRY_CAST(NULLIF(TRIM(product_length_cm),'') AS INT),
			TRY_CAST(NULLIF(TRIM(product_height_cm),'') AS INT),
			TRY_CAST(NULLIF(TRIM(product_width_cm),'') AS INT)
		FROM RAW.Products

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Sellers')
	BEGIN TRY
		INSERT INTO STAGING.Sellers(
			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state
		)
			SELECT
			NULLIF(TRIM(seller_id),''),
			NULLIF(TRIM(seller_zip_code_prefix),''),
			NULLIF(TRIM(seller_city),''),
			NULLIF(TRIM(seller_state),'')

		FROM RAW.Sellers

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en Category')
	BEGIN TRY
		INSERT INTO STAGING.Category(
			product_category_name,
			product_category_name_english
		)
			SELECT
			NULLIF(TRIM(product_category_name),''),
			NULLIF(TRIM(product_category_name_english),'')
		FROM RAW.Category

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	
	COMMIT

END TRY

BEGIN CATCH
	PRINT('ERROR GENERAL EN LA CARGA')
    PRINT(ERROR_MESSAGE())
	ROLLBACK

END CATCH

