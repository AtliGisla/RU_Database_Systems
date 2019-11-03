-- Query 7
--/*
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
WITH max_res AS (
	SELECT r.sportID, max(r.result) as max 
	FROM Results r
	GROUP BY r.sportID
)
select distinct P.ID, P.name, P.height, R.result, S.name, case (R.result = S.record) when true then 'Yes' else 'No' end as "record?"
from Results R 
	inner join max_res M on M.sportID = R.sportID AND M.max = R.result
	inner join Sports S on R.sportID = S.ID
	inner join People P on R.peopleID = P.ID

-- */ 
/*
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)

select distinct P.ID, P.name, P.height, R.result, S.name, case (R.result = S.record) when true then 'Yes' else 'No' end as "record?"
from People P, Results R, Sports S
where P.ID = R.peopleID
  and S.ID = R.sportID
  and R.result = (
    select max(R1.result)
          from Results R1
    where R1.sportID = R.sportID
);
*/
