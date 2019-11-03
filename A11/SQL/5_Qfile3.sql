-- Query 6
-- /*
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)

select P.ID, P.name
from People P
    join Results R on R.peopleID = P.ID
where R.result = (
    select min(R1.result)
    from Results R1
    where R1.sportID = R.sportID
)
intersect
select P.ID, P.name
from People P
    join Results R on R.peopleID = P.ID
group by P.ID, P.name
having count(distinct sportID) = 1;
-- */

--/*
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)

WITH min_res AS (
	SELECT r.sportID, min(r.result) as min
	FROM Results r
	GROUP BY r.sportID
)
select P.ID, P.name
from People P
    inner join Results R on R.peopleID = P.ID
    inner join min_res m on R.sportID = m.sportID and r.result = m.min
INTERSECT 
select P.ID, P.name
from People P
    inner join Results R on R.peopleID = P.ID
group by P.ID, P.name
having count(distinct sportID) = 1;
-- */

