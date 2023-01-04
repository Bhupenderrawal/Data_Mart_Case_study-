#						             Part A ( Clenaing  data )
# Created new table weekly_sales_
create table Sales_data (
   select
      Week_date,
      week(week_date) as week_number,
      -- Added a week_number afor each week_date value
      month(week_date) as month_number,
      -- Added  a month_number for each week_date value 
      year(week_date) as calendar_year,
      -- Added  a calendar_year column 
      Age_band,
      Demographic,
      Region,
      Platform,
      Customer_type,
      Sales,
      Transactions,
      Avg_transaction
   from
      (
         select
            str_to_date(week_date, '%d/%m/%Y') as week_date,
            -- Convert the week_date to a DATE format
            case
               -- Added  a new column called Age_band
               when right(segment, 1) = "1" then "Young Adults"
               when right(segment, 1) = "2" then "Middle Aged"
               when right(segment, 1) in ("3", "4") then "Retirees"
               else "unknown" -- Updated null values as Unknown
            End as Age_band,
            case
               -- Add a new demographic column
               when left(segment, 1) = 'C' then "Couple"
               when left (segment, 1) = 'F' then "Families"
               else "Unknown" -- Updated null values as Unknown
            End as Demographic,
            round(sales / transactions, 2) as Avg_transaction,
            Region,
            Platform,
            Customer_type,
            Sales,
            Transactions
         from
            weekly_sales
      ) a
);

select
   *
from
   sales_data;