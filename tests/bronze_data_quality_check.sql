USE DataWarehouse;
GO
---Checking for NULLs 
---Expectation to have only the latest copy of the record

SELECT cst_id,
	   cst_key,
	   TRIM(cst_firstname) AS cst_firstname ,
	   TRIM(cst_lastname) AS cst_lastname ,
	   cst_material_status AS cst_marital_status,
	   cst_gndr,
	   cst_create_date
FROM 
(SELECT *,ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL)t
WHERE flag_last=1

----Checking for unwanted spaces
----Expectation: No records
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

---Data Standardization & consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

---Checking for NULLs 
---Expectation to have only the latest copy of the record
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 or prd_cost IS NULL 

---Data Standardization & consistency
SELECT DISTINCT prd_line 
FROM bronze.crm_prd_info


----Check start and end dates of the column
-- End start should be after the start date

SELECT * FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt


------bronze.crm_sales_details
SELECT * FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

----checking the sls_prd_key column to see any columns which are not in silver crm_prd_info table

SELECT * FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)

---Checking for invalid dates

SELECT NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0 or LEN(sls_order_dt) != 8 or sls_order_dt > 20500101 OR sls_order_dt < 19000101

------------
SELECT NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <=0 or LEN(sls_ship_dt) != 8 or sls_ship_dt > 20500101 OR sls_ship_dt < 19000101

-----Checking for Invalid order dates
SELECT * FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-----check data consistency : between sales, quantity, and price
-->> Sales = Quantity * Price
-->> Values must not be NULL, Zero, or Negative

--RULES: if Sales is negative, zero, or NULL derive it using quantity and price
---if price is zero or NULL, calculate it using sales and  quantity
--if price is negative, convert it to a postive value

SELECT DISTINCT sls_sales, sls_quantity, sls_price
	FROM bronze.crm_sales_details

WHERE sls_sales != sls_quantity* sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales<= 0  OR sls_quantity <= 0 OR sls_price <= 0

ORDER BY sls_sales, sls_quantity, sls_price

----------

--ITENDITY Out-of_Range Dates

SELECT DISTINCT bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

---data standardization and consistency
 
 SELECT DISTINCT gen from bronze.erp_cust_az12

 ------------- replace cid with no dash
 SELECT cid,cntry FROM bronze.erp_loc_a101

 SELECT cst_key FROM silver.crm_cust_info

 ---data standardization and consistency for cntry

 SELECT DISTINCT cntry
 FROM bronze.erp_loc_a101
 ORDER BY cntry


 ----------Check for unwanted spaces

 SELECT * FROM bronze.erp_px_cat_g1v2
 WHERE cat != TRIM(cat) OR Subcat != TRIM(Subcat) OR maintenance != TRIM(maintenance)

 ----Data standardization and consistency

 SELECT DISTINCT cat FROM bronze.erp_px_cat_g1v2

 SELECT DISTINCT Subcat FROM bronze.erp_px_cat_g1v2

  SELECT DISTINCT maintenance FROM bronze.erp_px_cat_g1v2