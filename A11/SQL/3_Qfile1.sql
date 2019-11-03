-- Query 1

explain (analyze,verbose,buffers)
SELECT COUNT(*)
FROM Results R INNER JOIN Sports S 
        ON R.sportID = S.ID
WHERE S.ID = 4;

-- Query 2

explain (analyze,verbose,buffers)
SELECT COUNT(*)
FROM Results R 
INNER JOIN People P 
        ON R.peopleID = p.ID
 WHERE P.ID = 1299;
