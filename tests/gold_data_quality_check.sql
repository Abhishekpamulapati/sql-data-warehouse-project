

SELECT 
	
	ci.cst_gndr,
	ca.gen,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE (ca.gen, 'n/a')
	END AS new_gen
	FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
ORDER BY 1,2 

-------------

SELECT DISTINCT gender FROM gold.dim_customers

------Products quality check for duplicates
SELECT prd_key, COUNT(*) FROM
(SELECT
    pn.prd_id,       
    pn.prd_key,
    pn.prd_name,
    pn.cat_id,
    pc.cat,
    pc.subcat,
    pc.maintenance,
    pn.prd_cost,
    pn.prd_line,
    pn.prd_start_dt
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL)t GROUP BY prd_key
HAVING COUNT(*) >1


-------

SELECT * FROM gold.dim_products

-----Foreign Key Integrity (Dimensions)

SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p 
ON p.product_key =f.product_key
WHERE c.customer_key IS NULL