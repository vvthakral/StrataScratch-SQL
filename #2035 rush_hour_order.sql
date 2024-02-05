-- 2035 Avg Order Cost During Rush Hours


/*
-- Problem Statement
StrataQuest Link: https://platform.stratascratch.com/coding/2035-avg-order-cost-during-rush-hours

The company you work for has asked you to look into the average order value per hour during rush hours in the San Jose area. Rush hour is from 15H - 17H inclusive.

You have also been told that the column order_total represents the gross order total for each order. Therefore, you'll need to calculate the net order total.

The gross order total is the total of the order before adding the tip and deducting the discount and refund.

Use the column customer_placed_order_datetime for your calculations.


-- Solution
Intution: We need to get avg of orders only placed during rush hour from San Jose area

Clarification Questions: Does year need to be filtered
Will columns be null, do we treat null as 0
Can order total be assumed to be not null

Concept tested:
group by
nvl/coalesce
date functions

Method: 
1. get the order value by subtracting refund and adding tip to the order amount, use nvl to handle nulls
2. Extract hour from the data
3. Avg the earnings by hour of day
*/

select 
    extract(hour from customer_placed_order_datetime) as hour
    , avg(order_total + coalesce(tip_amount,0) - coalesce(discount_amount,0)) as order_value
    from delivery_details
    where delivery_region='San Jose'
    and extract(hour from customer_placed_order_datetime) between 15 and 17
group by 1
order by 2 desc
