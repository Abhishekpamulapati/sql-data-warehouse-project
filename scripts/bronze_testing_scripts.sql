 USE DataWarehouse;
 GO
 
 /*Testing the customer info table*/

SELECT * FROM bronze.crm_cust_info;

SELECT COUNT(*) FROM bronze.crm_cust_info; 



 /*Testing the product info table*/

 SELECT * FROM bronze.crm_prd_info;

SELECT COUNT(*) FROM bronze.crm_prd_info; 


 /*Testing the sales details table*/

 SELECT * FROM bronze.crm_sales_details;

SELECT COUNT(*) FROM bronze.crm_sales_details; 


 /*Testing the ERP cust az12 table*/

 SELECT * FROM bronze.erp_cust_az12;

SELECT COUNT(*) FROM bronze.erp_cust_az12; 


 /*Testing the ERP location a101 table*/

 SELECT * FROM bronze.erp_loc_a101;

SELECT COUNT(*) FROM bronze.erp_loc_a101; 


 /*Testing the ERP erp_px_cat_g1v2 table*/

 SELECT * FROM bronze.erp_px_cat_g1v2;

SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2; 
