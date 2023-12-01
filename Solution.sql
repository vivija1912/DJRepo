DECLARE @JSON_data VARCHAR(MAX)
FROM OPENROWSET (BULK 'C:\Users\vivija\Desktop\sql\CustData_Viv1000.json', SINGLE_CLOB) import


SELECT * FROM OPENJSON (@JSON_data)

with cte_custdata as
(SELECT * 
FROM OPENJSON (@JSON_data, '$.header.columns') 
     WITH (customer_id INT,
           name VARCHAR(50),
           email VARCHAR(100),
           purchase_price DECIMAL(5,2),
           purchase_date DATE)
)
select customer_id, name, email, purchase_price,
		case 
			when purchase_price < 100 then "Low"
			when purchase_price between 100 and 500 then "Medium"
			else "High" 
		end as segment into CusSeg from cte_custdata
		
--Export CusSeg data into csv format via SQL management Studio . Right Click on table -> tasks -> Export
--else
-- RC on the resultset ->Copy with Headers
--else
---Using the SQLCMD Utility
--sqlcmd -S DESKTOP-INGEKE8\MSSQLSERVER,1433
--Q "select * from CusSeg"
-- –s "," –o "C:\Users\Vivija\Desktop\sql\CusSeg.csv" -E


		

		   
		   
