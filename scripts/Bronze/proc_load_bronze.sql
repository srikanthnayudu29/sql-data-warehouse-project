/*
======================================
Store_proc : bronze.load_bronze (source-> Bronze)
======================================
Script Purpose :
  This Sp load the data from csv files to bronze schema tables
  This sp first truncate the tables after that it will do bulk insert into tables
  --uses BULK INSERT Command to load data from external csv files to bronze tables
Parameters :
  This SP not accepts any parameter and not returns any value
Example :
  EXEC bronze.load_bronze
*/

CREATE OR ALTER  PROC bronze.load_bronze
AS
BEGIN
	BEGIN TRY
		DECLARE @start_time DATETIME,@end_time DATETIME
		DECLARE @Batch_start_date DATETIME,@batch_end_date DATETIME
		PRINT '=============================================';
		PRINT 'Loading Bronze layer';
		PRINT '=============================================';

		PRINT '---------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '---------------------------------------------';
	
		PRINT '>> Truncating table :crm_cust_info';
		PRINT '>>Loading data into table :crm_cust_info';
		set @Batch_start_date = getdate()
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_cust_info
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '===================================' 
		PRINT 'Duration in sec to load '+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='


		PRINT '>> Truncating table :crm_prd_info';
		PRINT '>>Loading data into table :crm_prd_info';
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '==================================='
		PRINT 'Duration in sec to load'+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='


		PRINT '>> Truncating table :crm_sales_details';
		PRINT '>>Loading data into table :crm_sales_details';
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '==================================='
		PRINT 'Duration in sec to load'+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='


		PRINT '---------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '---------------------------------------------';

		PRINT '>> Truncating table :erp_cust_az12';
		PRINT '>>Loading data into table :erp_cust_az12';
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_cust_az12
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '==================================='
		PRINT 'Duration in sec to load'+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='


		PRINT '>> Truncating table :erp_loc_a101';
		PRINT '>>Loading data into table :erp_loc_a101';
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_loc_a101
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '==================================='
		PRINT 'Duration in sec to load'+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='


		PRINT '>> Truncating table :erp_px_cat_g1v2';
		PRINT '>>Loading data into table :erp_px_cat_g1v2';
		set @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\srikanth\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow =2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE()
		PRINT '==================================='
		PRINT 'Duration in sec to load'+ CAST(DATEDIFF(second,@end_time,@start_time) AS NVARCHAR)
		PRINT '==================================='

		set @Batch_end_date = getdate()
		PRINT '==================================='
		PRINT 'Bronze layer is completed'
		PRINT 'Duration in sec to load bronze layer '+ CAST(DATEDIFF(second,@batch_start_date,@Batch_end_date) AS NVARCHAR)
		PRINT '==================================='


	END TRY
	BEGIN CATCH
		PRINT '====================================='
		PRINT 'Error occured while loading data into bronze layer'
		PRINT '====================================='
		PRINT 'Error_message' +ERROR_MESSAGE()
	END CATCH
END
