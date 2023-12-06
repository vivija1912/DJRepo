
DECLARE @customer_data VARCHAR(MAX)

SELECT @customer_data = BulkColumn
FROM OPENROWSET(BULK 'C:\Users\vivij\vivijagithub\DJRepo\CustData_1000Records.json', SINGLE_CLOB) as j;

with cte_custdata as
(
SELECT customer_id, name , email, purchase_amount FROM OPENJSON (@customer_data) j cross apply 
OPENJSON (j.[Value]) 
     WITH (customer_id INT,
           name VARCHAR(50),
           email VARCHAR(100),
           purchase_amount DECIMAL(5,2),
           purchase_date DATE)
)
select customer_id, name, email, purchase_amount,
		case 
			when purchase_amount < 100 then 'Low'
			when purchase_amount between 100 and 500 then 'Medium'
			else 'High' 
		end as segment  from cte_custdata



		

		   
		   
