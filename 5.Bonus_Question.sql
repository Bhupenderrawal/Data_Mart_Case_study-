#														4.(Bonus Questions)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

#region
#platform
#age_band
#demographic
#customer_type -- 




#regioin wise
   use data_mart;
  with 12week_befor_after_sales as
  ( select  Region , 
			sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1 
   order by 1)  
   
	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1
    order by 5;
   
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    # platfrom
    
    with 12week_befor_after_sales as
  ( select  Platform , 
			sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1 
   order by 1) 
    	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1
    order by 5;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    #age_band
    
    with 12week_befor_after_sales as
  ( select  Age_band , 
			sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1 
   order by 1) 
    	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1
    order by 5;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#demographic 

  with 12week_befor_after_sales as
  ( select  Demographic, 
			sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1 
   order by 1) 
    	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1
    order by 5;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    #customer_type
    
    
    with 12week_befor_after_sales as
  ( select  Customer_type , 
			sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1 
   order by 1) 
    	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1
    order by 5;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        #Overall
    
    with 12week_befor_after_sales as
		( 
		select  Calendar_year,
			Region ,
			Platform , 
			age_Band,
            Demographic,
            Customer_type,
            sum(case when week_number between 25 and  37 then sales end)  as  After_Change ,
            sum(case when week_number between 13 and  24 then sales end ) as  Before_Change
   from Sales_data
   group by 1,2,3,4,5,6
   order by 1
			) 
	select * ,  
			after_Change - before_Change as Variance , 
			min(round(((after_Change - before_Change) /before_Change)*100,2)) as Percentage 
    from 12week_befor_after_sales  
    group by 1,2,3,4,5,6
    order by 5;