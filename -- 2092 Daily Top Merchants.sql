-- 2092 Daily Top Merchants


-- Problem Statement
/*
StrataQuest Link: https://platform.stratascratch.com/coding/2092-daily-top-merchants

You have been asked to find the top 3 merchants for each day with the highest number of orders on that day.

In the event of a tie, multiple merchants may share the same spot, but each day at least one merchant must be in first, second, and third place.

Your output should include the date in the format YYYY-MM-DD, the name of the merchant, and their place in the daily ranking.
*/

-- Solution
/*
Intution: We need to get avg of orders only placed during rush hour from San Jose area

Clarification Questions: Does each row represent an order
are we looking for any time frame
do we have any order quantity or value criteria 

Concept tested:
group by
dense rank vs rank function
date functions

Method: 
1. get the total number of orders per merchant on daily basis
2. rank merchants - since we want atleast one per rank we will do dense rank
3. get the top 3 ranks from the table, can have more than 3 rows per day
*/


with cte as(
    select 
        order_timestamp::date as date
        , md.name as merchant
        , count(1) as order_count
        from order_details as od 
        join merchant_details as md
            on od.merchant_id = md.id
        group by 1,2
)
, ranking as (
    select 
        *
        , dense_rank() over(partition by date order by order_count desc) as rnk 
    from cte 
)
select to_char(date,'YYYY-MM-DD') as date, merchant, rnk from ranking where rnk<=3 order by 1,3;