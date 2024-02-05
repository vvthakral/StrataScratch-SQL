-- Bikes Last Used

/*
Find the last time each bike was in use. Output both the bike number and the date-timestamp of the bike's last use (i.e., the date-time the bike was returned). Order the results by bikes that were most recently used.
*/

--Column Definition
/*
duration: varchar
duration_seconds: int
start_time: datetime
start_station: varchar
start_terminal: int
end_time: datetime
end_station: varchar
end_terminal: int
bike_number: varchar
rider_type: varchar
id: int
*/
with cte as (
    select 
        bike_number
        , end_time
        , row_number() over(partition by bike_number order by end_time desc) as rnum
    from dc_bikeshare_q1_2012
)
select 
	bike_number
	, end_time 
from cte 
where rnum=1
order by end_time desc;