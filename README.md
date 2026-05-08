# 🏗️ Ecommerce Data Warehouse & BI

Solución end-to-end de Data Engineering y Business Intelligence orientada al análisis de datos e-commerce mediante SQL Server, SSIS y Power BI.

---

## 📌 Arquitectura del Proyecto

<p align="center">
  <img src="https://raw.githubusercontent.com/danylo130205/SQLServer-ETL-DataWarehouse/main/assets/SQL-SSIS-ETL.png" width="500"/>
</p>

El proyecto implementa una arquitectura multicapa orientada al procesamiento y análisis de datos:

- **RAW** → almacenamiento inicial de datos
- **STAGING** → tipificación y estandarización
- **PROCESSING** → validaciones y reglas de negocio
- **MART** → modelo analítico para BI
- **POWER BI** → visualización y análisis

---

## ⚙️ Tecnologías Utilizadas

<p align="center">

<img src="https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white">

<img src="https://img.shields.io/badge/SSIS-0078D4?style=for-the-badge&logo=microsoft&logoColor=white">

<img src="https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black">

<img src="https://img.shields.io/badge/Data_Warehouse-0A192F?style=for-the-badge">

<img src="https://img.shields.io/badge/ETL-Pipeline-blue?style=for-the-badge">

</p>

---

## 🔄 Flujo ETL

### 1️⃣ Extracción
- Ingesta de archivos CSV mediante SSIS
- Carga inicial hacia capa RAW

### 2️⃣ Transformación
- Estandarización de datos
- Conversión de tipos de datos
- Validaciones de calidad
- Aplicación de reglas de negocio

### 3️⃣ Consolidación
- Construcción de tablas dimensionales
- Generación de tablas fact
- Consolidación analítica en MART

---

## 🗂️ Estructura del Proyecto

```text
Ecommerce-DataWarehouse-BI/
│
├── assets/
├── database/
├── etl/
├── powerbi/
├── README.md
└── LICENSE
```

---

## 📊 Dashboards Power BI

<table>
<tr>

<td width="50%">

<h3 align="center">📈 Dashboard de Ventas</h3>

<div align="center">

<img src="https://raw.githubusercontent.com/danylo130205/SQLServer-ETL-DataWarehouse/main/assets/Dashboard_Ventas.png" width="400" alt="Dashboard de Ventas">

</div>

<br>

<p align="center">
Visualización de métricas comerciales, ingresos, órdenes y comportamiento de ventas.
</p>

</td>

<td width="50%">

<h3 align="center">💰 Dashboard de Productos</h3>

<div align="center">

<img src="https://raw.githubusercontent.com/danylo130205/SQLServer-ETL-DataWarehouse/main/assets/Dashboard_Productos.png" width="400" alt="Dashboard de Productos">

</div>

<br>

<p align="center">
Análisis de productos, categorías, volumen de ventas y rendimiento comercial.
</p>

</td>

</tr>
</table>

---

<table>
<tr>

<td width="50%">

<h3 align="center">👥 Dashboard de Reviews</h3>

<div align="center">

<img src="https://raw.githubusercontent.com/danylo130205/SQLServer-ETL-DataWarehouse/main/assets/Dashboard_Reviews.png" width="400" alt="Dashboard de Reviews">

</div>

<br>

<p align="center">
Análisis de satisfacción de clientes y comportamiento de reseñas.
</p>

</td>

<td width="50%">

<h3 align="center">🔧 Pipeline SSIS</h3>

<div align="center">

<img src="https://raw.githubusercontent.com/danylo130205/SQLServer-ETL-DataWarehouse/main/assets/ssis_pipeline.png" width="400" alt="Pipeline SSIS">

</div>

<br>

<p align="center">
Pipeline ETL desarrollado con SSIS para proceso de carga de datos a la capa RAW.
</p>

</td>

</tr>
</table>

---

## 🚀 Cómo ejecutar el proyecto

### 1️⃣ Descargar el Dataset

El proyecto utiliza el dataset público de Olist E-Commerce disponible en Kaggle.

<p align="center">
  <a href="https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce">
    <img src="https://img.shields.io/badge/Descargar_Dataset-Kaggle-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white">
  </a>
</p>

---

### 2️⃣ Configurar SQL Server

Ejecutar los scripts ubicados en la carpeta `database/` respetando el siguiente orden:

```text
01_Crear_BD_Schemas.sql
02_Crear_Tablas_RAW.sql
03_Crear_Tablas_STAGING.sql
04_Crear_Tablas_PROCESSING.sql
05_Crear_Tablas_MART.sql
```
Esto creará la estructura completa del Data Warehouse multicapa.

## 3️⃣ Ejecutar proceso de carga SSIS

Abrir el proyecto SSIS ubicado en:
```text
etl/ssis/
```
y ejecutar el pipeline de carga para realizar la ingesta inicial de archivos CSV hacia la capa RAW.

## 4️⃣ Ejecutar transformaciones SQL

Ejecutar los scripts correspondientes a cada capa del Data Warehouse:

```text
📂 STAGING
├──Determinar_Longitud_Tipo.sql (Query para identificar longitudes máximas y tipos de datos.)
├──Llenando datos en las tablas de STAGING.sql
📂 PROCESSING
├──Llenando datos en las tablas PROCESSING.sql
📂 MART
├──Llenando datos en las tablas MART.sql
```
## 5️⃣ Abrir Power BI

Abrir el archivo:
```text
powerbi/PB OLIST.pbix
```
y actualizar las conexiones hacia SQL Server si es necesario.

---

## 📄 Documentación

📘 La documentación técnica completa del proyecto se encuentra disponible aquí:

<p align="center">
  <a href="https://github.com/danylo130205/SQLServer-ETL-DataWarehouse/blob/main/assets/AN%C3%81LISIS%20DE%20DATOS%20INTEGRAL.pdf">
    <img src="https://img.shields.io/badge/Ver_Documentación-PDF-red?style=for-the-badge&logo=adobeacrobatreader&logoColor=white">
  </a>
</p>

---

