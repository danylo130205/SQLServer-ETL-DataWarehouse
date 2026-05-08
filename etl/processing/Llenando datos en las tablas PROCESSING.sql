USE DB_OLIST;
GO
--Llenando datos en la capa PROCESSING
PRINT('#---------------------------------#')
PRINT('Llenando datos en Customers')
BEGIN TRY
BEGIN TRANSACTION

	BEGIN TRY
		INSERT INTO PROCESSING.Customers(
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state
		)
			SELECT DISTINCT
				customer_id,
				customer_unique_id,
				customer_zip_code_prefix,
				customer_city,
				customer_state

			FROM STAGING.Customers
			WHERE customer_id IS NOT NULL AND customer_unique_id IS NOT NULL
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
		INSERT INTO PROCESSING.Geolocation(
			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		)
		SELECT
			geolocation_zip_code_prefix,
			AVG(geolocation_lat),
			AVG(geolocation_lng),
			MAX(geolocation_city) AS geolocation_city,
			MAX(geolocation_state) AS geolocation_state
		FROM STAGING.Geolocation
		WHERE geolocation_zip_code_prefix IS NOT NULL
		AND geolocation_city IS NOT NULL
		AND geolocation_state IS NOT NULL
		GROUP BY geolocation_zip_code_prefix
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
		INSERT INTO PROCESSING.Items(
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_value
		)
			SELECT
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_value 
		
			FROM STAGING.Items
			WHERE order_id IS NOT NULL AND
			order_item_id > 0 AND
			product_id IS NOT NULL AND
			seller_id IS NOT NULL AND
			shipping_limit_date IS NOT NULL AND
			price >= 0 AND
			freight_value >= 0

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
		INSERT INTO PROCESSING.Payments(
			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
			SELECT
				order_id,
				payment_sequential,
				payment_type,
				payment_installments,
				payment_value
			FROM STAGING.Payments
			WHERE order_id IS NOT NULL
			AND payment_sequential IS NOT NULL
			AND payment_type IN ('CREDIT_CARD','NOT_DEFINED','DEBIT_CARD','BOLETO','VOUCHER')
			AND payment_installments >= 0
			AND payment_value >= 0
			AND payment_sequential > 0
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
		INSERT INTO PROCESSING.Reviews(
			review_id,
			order_id,
			review_score,
			review_comment_title,
			review_comment_message,
			review_creation_date,
			review_answer_timestamp
		)
			SELECT
				review_id,
				order_id,
				review_score,
				review_comment_title,
				review_comment_message,
				review_creation_date,
				review_answer_timestamp
			FROM (
			SELECT
				review_id,
				order_id,
				review_score,
				review_comment_title,
				review_comment_message,
				review_creation_date,
				review_answer_timestamp,
				ROW_NUMBER() OVER(PARTITION BY review_id ORDER BY review_creation_date DESC) AS review_ultimate
			FROM STAGING.Reviews
			WHERE review_id IS NOT NULL
			AND order_id IS NOT NULL
			AND review_score BETWEEN 1 AND 5
			AND review_creation_date IS NOT NULL
			AND (review_answer_timestamp IS NULL OR review_answer_timestamp >= review_creation_date)
			) AS REV
			WHERE review_ultimate = 1

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
		INSERT INTO PROCESSING.Orders(
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
			order_id,
			customer_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		FROM STAGING.Orders
		WHERE order_id IS NOT NULL
		AND customer_id IS NOT NULL
		AND order_status IN ('APPROVED','DELIVERED','CREATED','INVOICED','PROCESSING','UNAVAILABLE','CANCELED','SHIPPED')
		AND order_purchase_timestamp IS NOT NULL
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
		INSERT INTO PROCESSING.Products(
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
				product_id,
				product_category_name,
				product_name_lenght,
				product_description_lenght,
				product_photos_qty,
				product_weight_g,
				product_length_cm,
				product_height_cm,
				product_width_cm
			FROM STAGING.Products
			WHERE product_id IS NOT NULL
			AND (product_name_lenght IS NULL OR product_name_lenght >= 0)
			AND (product_description_lenght IS NULL OR product_description_lenght >= 0)
			AND (product_photos_qty IS NULL OR product_photos_qty >= 0)
			AND (product_weight_g IS NULL OR product_weight_g >= 0)
			AND (product_length_cm IS NULL OR product_length_cm >= 0)
			AND (product_height_cm IS NULL OR product_height_cm >= 0)
			AND (product_width_cm IS NULL OR product_width_cm >= 0)
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
		INSERT INTO PROCESSING.Sellers(
			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state
		)
			SELECT DISTINCT
				seller_id,
				seller_zip_code_prefix,
				seller_city,
				seller_state
			FROM STAGING.Sellers
			WHERE seller_id IS NOT NULL

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
		INSERT INTO PROCESSING.Category(
			product_category_name,
			product_category_name_english
		)
			SELECT DISTINCT
				product_category_name,
				product_category_name_english
			FROM STAGING.Category
			WHERE product_category_name IS NOT NULL

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

