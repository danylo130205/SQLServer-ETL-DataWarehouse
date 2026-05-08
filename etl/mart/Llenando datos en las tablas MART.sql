USE DB_OLIST;
GO
---- Llenando tablas de mart
PRINT('#---------------------------------#')
PRINT('Llenando datos en Customers')
BEGIN TRY
BEGIN TRANSACTION

	BEGIN TRY
		INSERT INTO MART.DIM_Customers(
			customer_unique_id,
			customer_city,
			customer_state,
			customer_lat,
			customer_lng
		)
			SELECT
				C.customer_unique_id,
				MAX(C.customer_city) AS customer_city,
				MAX(C.customer_state) AS  customer_state,
				MAX(G.geolocation_lat) AS customer_lat,
				MAX(G.geolocation_lng) AS customer_lng
			FROM PROCESSING.Customers AS C
			LEFT JOIN PROCESSING.Geolocation AS G
			ON C.customer_zip_code_prefix=G.geolocation_zip_code_prefix
			 WHERE C.customer_unique_id IS NOT NULL
			GROUP BY C.customer_unique_id
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
		INSERT INTO MART.DIM_Products(
			product_id,
			product_category_name,
			product_category_name_english,
			product_name_lenght,
			product_description_lenght,
			product_photos_qty,
			product_weight_g,
			product_length_cm,
			product_height_cm,
			product_width_cm
		)
			SELECT
				P.product_id,
				P.product_category_name,
				C.product_category_name_english,
				P.product_name_lenght,
				P.product_description_lenght,
				P.product_photos_qty,
				P.product_weight_g,
				P.product_length_cm,
				P.product_height_cm,
				P.product_width_cm
			FROM PROCESSING.Products AS P
			LEFT JOIN PROCESSING.Category AS C
			ON P.product_category_name=C.product_category_name
			WHERE P.product_id IS NOT NULL
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
		INSERT INTO MART.DIM_Sellers(
			seller_id,
			seller_city,
			seller_state,
			seller_lat,
			seller_lng
		)
			SELECT DISTINCT
				S.seller_id,
				MAX(S.seller_city),
				MAX(S.seller_state),
				MAX(G.geolocation_lat),
				MAX(G.geolocation_lng)
			FROM PROCESSING.Sellers AS S
			LEFT JOIN PROCESSING.Geolocation AS G
			ON S.seller_zip_code_prefix=G.geolocation_zip_code_prefix
			WHERE seller_id IS NOT NULL
			GROUP BY S.seller_id

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en DATE')
	BEGIN TRY
	DECLARE @StartDate DATE = (SELECT MIN(order_purchase_timestamp) FROM PROCESSING.Orders)
	DECLARE @EndDate   DATE = GETDATE()
	WHILE @StartDate <= @EndDate
				BEGIN
		INSERT INTO MART.DIM_DATE(
			DateKey, -- Formato YYYYMMDD
			FullDate,
			Year,
			Quarter,
			Month,
			MonthName,
			DayOfMonth,
			DayOfWeek,
			DayOfWeekName,
			WeekOfYear,
			IsWeekend 
		)
					SELECT
						CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT) AS DateKey,
						@StartDate AS FullDate,
						YEAR(@StartDate) AS Year,
						DATEPART(QUARTER, @StartDate) AS Quarter,
						MONTH(@StartDate) AS Month,
						DATENAME(MONTH, @StartDate) AS MonthName,
						DAY(@StartDate) AS DayOfMonth,
						DATEPART(WEEKDAY, @StartDate) AS DayOfWeek,
						DATENAME(WEEKDAY, @StartDate) AS DayOfWeekName,
						DATEPART(WEEK, @StartDate) AS WeekOfYear,
						CASE WHEN DATEPART(WEEKDAY, @StartDate) IN (1, 7) THEN 1 ELSE 0 END AS IsWeekend;

					SET @StartDate = DATEADD(DAY, 1, @StartDate);
				END;

		PRINT('Carga completa')
		
	END TRY
	BEGIN CATCH
		Print('Error al cargar los datos')
		Print('Mensaje: ' + ERROR_MESSAGE())
		PRINT('Número: ' + CAST(ERROR_NUMBER() AS VARCHAR) )
		PRINT('Línea: ' + CAST(ERROR_LINE() AS VARCHAR) )
	END CATCH
	PRINT('#---------------------------------#')
	PRINT('Llenando datos en SALES')
	BEGIN TRY
		INSERT INTO MART.FACT_Sales(
			order_id,
			order_item_id,
			product_id,
			seller_id,
			customer_unique_id,
			DateKey,
			order_status,
			order_purchase_timestamp ,
			shipping_limit_date ,
			price,
			freight_value
		)
			SELECT
			I.order_id,
			I.order_item_id,
			I.product_id,
			I.seller_id,
			C.customer_unique_id,
			D.DateKey,
			O.order_status,
			O.order_purchase_timestamp ,
			I.shipping_limit_date ,
			I.price,
			I.freight_value
		
			FROM PROCESSING.Items AS I
			INNER JOIN PROCESSING.Orders AS O
			ON I.order_id=O.order_id
			INNER JOIN PROCESSING.Customers AS C
			ON O.customer_id=C.customer_id
			INNER JOIN MART.DIM_DATE AS D
			ON CAST(O.order_purchase_timestamp AS DATE)=D.FullDate
		

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
		INSERT INTO MART.DIM_Payments(
			order_id,
			payment_types,
			payment_installments
		)
			SELECT
				order_id,
				STRING_AGG(payment_type,',') AS payment_types,
				MAX(payment_installments)
			FROM PROCESSING.Payments
			GROUP BY order_id
			
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
		INSERT INTO MART.DIM_Reviews(
			order_id,
			review_count,
			avg_review_score,
			max_review_score,
			min_review_score
		)
			SELECT
				order_id,
				COUNT(*) ,
				AVG(review_score),
				MAX(review_score),
				MIN(review_score)
			FROM PROCESSING.Reviews
			GROUP BY order_id
			

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