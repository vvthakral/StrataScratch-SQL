-- Avg Earnings per Weekday and Hour


/*
StrataQuest Link: https://platform.stratascratch.com/coding/2034-avg-earnings-per-weekday-and-hour

You have been asked to calculate the average earnings per order segmented by a combination of weekday (all 7 days) and hour using the column customer_placed_order_datetime.


You have also been told that the column order_total represents the gross order total for each order. Therefore, you'll need to calculate the net order total.


The gross order total is the total of the order before adding the tip and deducting the discount and refund.


Note: In your output, the day of the week should be represented in text format (i.e., Monday). Also, round earnings to 2 decimals

Intution: We need to get avg by day and hour
Clarification Questions: Does year need to be filtered
Will columns be null, do we treat null as 0
Can order total be assumed to be not null

Concept tested:
group by
nvl/coalesce
date functions

Method: 
1. get the earning per order by subtracting refund and adding tip to the order amount, use nvl to handle nulls
2. Extract day of week and hour from the data
3. Avg the earnings by hour and day
*/
with cte as (
    select 
        to_char(customer_placed_order_datetime,'Day') as day
        , extract(hour from customer_placed_order_datetime) as hour
        , order_total + nvl(tip_amount,0) - nvl(refunded_amount,0) - nvl(discount_amount,0) as earning
    from doordash_delivery
)
select day, hour, round(avg(earning),2) as avg_earning
from cte
group by 1,2
order by avg_earning desc
