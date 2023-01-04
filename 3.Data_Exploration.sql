------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#																	Part B (Data Exploration)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from Sales_data;

# 1. What day of the week is used for each week_date value?


select  distinct dayname(  week_date) as Day
from Sales_data;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# 2. What range of week numbers are missing from the dataset?


with recursive cte as(
	(
		select 1 as week_name
	)
		union all 
	(
		select 
		week_name + 1 from cte
		where week_name < 52 )
	)
select week_name as Missing_weeks  
	from cte
	group by week_name
	having week_name not in  (	
								select distinct extract(week from week_date) as week_date
									from sales_data
									order by week_number ) ;
                                                        
                                                        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 3. How many total transactions were there for each year in the dataset

select  Calendar_year as Years ,
		sum(transactions) as Total_transactions 
from sales_data
group by calendar_year
order by  1; 


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 4. What is the total sales for each region for each month?

 
select  Region  , 
		monthname(week_date) as Month  , 
        Month_number , 
		sum(sales) as Total_sales
from Sales_data
group by 1 , 2
order by 3 asc;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 5. What is the total count of transactions for each platform


select Platform , sum(transactions)  as Transactions
from weekly_sales_data
group by platform;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 6. What is the percentage of sales for Retail vs Shopify for each month? (with CTE) 


with platform_sales as 
	(
		select Month_number , 
		sum(case when platform =  "shopify" then  sales end) as shopify_sales ,
		sum(case when platform =  "Retail" then  sales end) as retail_sales 
		from Sales_data
		group by month_number
        order by 1 
		) 
select Month_number ,
		 round ((shopify_sales/(shopify_sales + retail_sales )) *100,2) as Shopify_percentage ,
         round((retail_sales/(shopify_sales + retail_sales )) *100,2) as Retail_percentage 
 from  platform_sales ;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#					 Alternative
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 6. What is the percentage of sales for Retail vs Shopify for each month? (Sub - Query)


select month_number ,
		round ((shopify_sales/(shopify_sales + retail_sales )) *100,2) as Shopify_percentage ,
         round((retail_sales/(shopify_sales + retail_sales )) *100,2) as Retail_percentage 
	 from (       
			select Month_number , 
			sum(case when platform =  "shopify" then  sales end) as shopify_sales ,
			sum(case when platform =  "Retail" then  sales end) as retail_sales 
			from Sales_data
			group by month_number
			order by 1) table1 ;
        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 7. What is the percentage of sales by demographic for each year in the dataset?


select calendar_year , 
	   Demographic ,
	case 
		when demographic =  "Couple" then   round((sum(sales) / (select sum(sales) from Sales_data))*100 , 2)
		when demographic =  "unknown" then  round((sum(sales)/(select sum(sales) from Sales_data))*100,2)
		when demographic =  "Families" then round(( sum(sales)/(select sum(sales) from Sales_data))*100 , 2)
 end as Percentage
	from Sales_data
    group by 1,2;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#									Alternative 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 7. What is the percentage of sales by demographic for each year in the dataset? 

select Calendar_year ,
		round ((couple_sales/(families_sales +unknown_sales +couple_sales )) *100,2) as couple_percentage ,
		round((families_sales/(families_sales +unknown_sales +couple_sales )) *100,2) as families_percentage ,
        round((unknown_sales/(families_sales +unknown_sales +couple_sales )) *100,2) as unknown_percentage
 from (       
		select calendar_year , 
		sum(case when demographic =  "Couple" then  sales end) as couple_sales ,
		sum(case when demographic =  "families" then  sales end) as families_sales ,
		sum(case when demographic =  "unknown" then  sales end) as unknown_sales 
		from sales_data
		group by calendar_year
        order by 1) tab ;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 8. Which age_band and demographic values contribute the most to Retail sales?


with Demographic as 
(
	select Age_Band , 
				Demographic , 
				sum(Sales) as sales
	from sales_data
	where platform= "retail"
	group by 1,2
	order by 3 desc)

select  Age_Band , 
		Demographic ,
        max(sales) as Total_sales ,
        round((max(sales)/sum(sales))*100,2)  as percentage
from Demographic;
		
        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?


select   Calendar_year,  Platform ,
		round(avg(avg_transaction),2) as Avg_transaction ,
		round(sum(sales)/sum(transactions) ,2) as Correct_avg_transaction
from Sales_data
group by  calendar_year ,
		  platform ;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
