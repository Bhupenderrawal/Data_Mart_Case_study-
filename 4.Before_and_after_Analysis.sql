#																				Part C
# Before and after Analysis  2020-06-15
 #date_add ( date , interval __ ____)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?


select * ,
		after_change - before_change as variance  ,  
		round(((after_change - before_change)/ before_change)*100,2) as percentage
	from  
			(select 
			(select sum(sales)
			from weekly_sales_data
			where week_date >= '2020/06/15'   and  week_date <= date_add('2020/06/15',interval 4 week)) as after_change , 
			(select sum(sales)
			from weekly_sales_data
			where week_date >=  date_add('2020/06/15',interval -4 week)   and  week_date  < '2020/06/15') as before_change ) a;
            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
            
 
            
            
             
    select * , after_sales - before_sales , round(((after_sales - before_sales) /before_sales)*100,2) 
    from
    (        
     select
			sum(case when week_date >= '2020/06/15'   and  week_date < date_add('2020/06/15',interval 4 week) then sales end)  as  after_sales ,
            sum(case when week_date >= date_add('2020/06/15',interval -4 week) and week_date  < ('2020/06/15')  then sales end ) as  before_sales
   from weekly_sales_data
   ) tab1
   ;
            
            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#What about the entire 12 weeks before and after?


select * ,
		after_change - before_change as variance  ,  
		round(((after_change - before_change)/ before_change)*100,2) as percentage
	from  
			(select 
					(select sum(sales)
							from weekly_sales_data
							where week_date >= '2020/06/15'   and  week_date <= date_add('2020/06/15',interval 12 week)) as After_change , 
					(select sum(sales)
							from weekly_sales_data
							where week_date >=  date_add('2020/06/15',interval -12 week)   and  week_date  < '2020/06/15') as Before_change ) a;
            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     
     select week_number 
    use data_mart ;
    
    
    from weekly_sales_data
     where week_date = '2020/06/15';
            
            
             
    select * , after_sales - before_sales , round(((after_sales - before_sales) /before_sales)*100,2) 
    from
    (        
     select
			sum(case when week_date >= '2020/06/15'   and  week_date < date_add('2020/06/15',interval 12 week) then sales end)  as  after_sales ,
            sum(case when week_date >= date_add('2020/06/15',interval -12 week) and week_date  < ('2020/06/15')  then sales end ) as  before_sales
   from weekly_sales_data
   ) tab1
   ;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
	#How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?
    
    
     select week_number 
     from weekly_sales_data
     where week_date = '2020/06/15';
     
	# 4 weeks
    
   select * , after_sales - before_sales as variance , round(((after_sales - before_sales) /before_sales)*100,2)  as Percentage
    from 
    (        
     select Calendar_year ,
			sum(case when week_number between 25 and  28 then sales end)  as  After_sales ,
            sum(case when week_number between 21 and  24 then sales end ) as  Before_sales
   from weekly_sales_data
   group by calendar_year
   order by 1) tab;
            
            
            
 # 8weeks
            
     select * ,  after_sales - before_sales as Variance , round(((after_sales - before_sales) /before_sales)*100,2) as Percentage 
    from
    (        
     select Calendar_year ,
			sum(case when week_number between 25 and  37 then sales end)  as  after_sales ,
            sum(case when week_number between 13 and  24 then sales end ) as  before_sales
   from weekly_sales_data
   group by calendar_year
   order by 1) tab;       
   
   
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
