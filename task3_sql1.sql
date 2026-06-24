select * from sales1_data;
select * from sales2_data;

select
	year(str_to_date(`Order Date`,'%d-%m-%Y')) as Year,
	month(str_to_date(`Order Date`, '%d-%m-%Y')) AS Month,
    Sum(Sales) as Monthly_sales,
    sum(Profit) as Monthly_profit 
from sales1_data
group by Year , Month
order by Year , Month;

select 
		s1.Month,
        s1.Monthly_sales,
        (s1.Monthly_sales - s2.Monthly_sales) / s2.Monthly_sales * 100 as Growth_percentage
from 
	(select 
			month(str_to_date(`Order Date`, '%d-%m-%Y')) AS Month,
				sum(Sales) as Monthly_sales
			from sales1_data
            group by Month) s1
            
join 
(select 
		month(str_to_date(`Order Date`, '%d-%m-%Y')) AS Month,
			sum(Sales) as Monthly_sales
		from sales1_data
		group by Month) s2
on s1.Month=s2.Month + 1;

select `Order ID`, Sales,
	case
		when Sales > 1000 then 'High Value'
        when Sales between 500 and 100 then 'Medium Value'
        else 'Low Value'
	end as Order_type
from sales1_data;
    
select s2.Region, sum(s1.Profit) as 'Total_profit'
from sales1_data s1
join sales2_data s2
on s1.`Customer ID` = s2.`Customer ID`
group by s2.Region
having Total_profit < 300000;

