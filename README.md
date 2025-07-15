# sql-data-warehouse-project
Modern Data Warehouse on MS SQL server, includes ETL process, data modelling, and analytics
...

#🚀 ** Overview**
This project demonstrates the design and implementation of a modern data warehouse using Microsoft SQL Server. It follows the Medallion Architecture pattern—an industry-standard approach for organizing data across different layers of refinement: Bronze, Silver, and Gold. The solution is engineered for scalability, maintainability, and ease of analytics, making it ideal for enterprise-level data environments.

#🏗️ **Architecture**
- Bronze Layer: Raw data ingestion from diverse sources. Stored with minimal transformation to preserve original fidelity.
- Silver Layer: Cleaned and conformed data with key joins, deduplication, and normalization applied for usability.
- Gold Layer: Curated business-level tables optimized for reporting, analytics, and insights.
  
#🔧** Technologies Used**
- Microsoft SQL Server (T-SQL)
- SQL Agent for ETL Scheduling
- Stored Procedures & Views
- SSMS for development and monitoring

  
#📈 ** Features**
- Robust ETL pipelines mimicking real-world data flow
- Modular data layer structure with incremental loading
- Use of best practices like SCD management and audit logging
- Sample use cases and reporting queries
#🎯 ** Objectives**
- Simulate a real-world enterprise data warehousing scenario
- Showcase proficiency in data modeling, transformation logic, and SQL development
- Enable easy extension into BI tools like Power BI or Tableau
