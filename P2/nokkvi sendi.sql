
--Question 1

--Question 2

--Question 3
SELECT DISTINCT C.place
FROM competitions C
WHERE C.place NOT IN (
	SELECT C.place
	FROM competitions C
	JOIN Results R ON C.id = R.competitionid
	JOIN sports S ON R.sportid = S.id
	WHERE S.name = 'Discus'
)

--Question 4
SELECT SQ.peopleID, SQ.peoplename 
FROM ( SELECT P.id as peopleID, P.name as peoplename, S.id as sportID
	    FROM People P JOIN Results R ON P.ID = R.peopleID 
	    JOIN Sports S ON R.sportID = S.ID and R.result = S.record 
	    JOIN Competitions C ON R.competitionID = C.ID 
	    GROUP BY P.id, S.ID HAVING COUNT(DISTINCT C.ID) > 1) 
AS SQ GROUP BY SQ.peopleID, SQ.peoplename HAVING COUNT(DISTINCT SQ.sportID) > 1;

--Question 5
SELECT P.ID, P.name
FROM People P
WHERE NOT EXISTS (SELECT * FROM Sports S
                    WHERE NOT EXISTS (SELECT * 
                                        FROM Results R
                                        WHERE P.ID = R.peopleID
                                        AND S.ID = R.sportID));


--Question 6

--Question 7
-- Select all females that have a record
SELECT P.id, P.name
FROM people P
	JOIN gender G ON G.gender = P.gender
	JOIN results R ON R.peopleid = P.id
	JOIN sports S ON R.sportid = S.id
WHERE G.description = 'Female' AND R.result = S.record
GROUP BY P.id
-- Make sure only females with a record in every sport that any female
-- has a record in is selected
HAVING COUNT(DISTINCT R.sportid) = (
	SELECT COUNT(DISTINCT R2.sportid)
	FROM results R2
		JOIN people P2 ON P2.id = R2.peopleid
		JOIN gender G2 ON G2.gender = P2.gender
		JOIN sports S2 ON S2.id = R2.sportid
	WHERE G2.description = 'Female' AND R2.result = S2.record);

--Question 8

--Question 9


--Question 10