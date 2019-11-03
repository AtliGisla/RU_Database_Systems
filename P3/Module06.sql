--TASK 1
BEGIN TRANSACTION;
--the given seat number does not exist in the corresponding venue.
INSERT INTO Bookings(schedule_id, seat_id, people_ssn)
VALUES(1, 0, '1207169649');
INSERT INTO Bookings(schedule_id, seat_id, people_ssn)
VALUES(1, 10, '1207169649');

 --TASK 2 
--each venue can only be booked once a day.
INSERT INTO EventSchedules (event_id, venue_id, event_time, event_price)
VALUES((SELECT max(id) FROM Events WHERE name LIKE 'Nýdönsk')
		, (SELECT max(id) FROM Venues WHERE name LIKE 'Harpa Silfurberg')
		, (timestamp '2017-11-17 20:00')
		, 8000)
--each event can only be scheduled once a day.
INSERT INTO EventSchedules (event_id, venue_id, event_time, event_price)
VALUES((SELECT max(id) FROM Events WHERE name LIKE 'Dimma')
		, (SELECT max(id) FROM Venues WHERE name LIKE 'Austurbakka 2')
		, '2017-11-18 20:00'
		, 8000)
--This should work
INSERT INTO EventSchedules (event_id, venue_id, event_time, event_price) --ADDED
VALUES((SELECT max(id) FROM Events WHERE name LIKE 'Dimma')
		, (SELECT max(id) FROM Venues WHERE name LIKE 'Austurbakka 2')
		, '2017-11-20 20:00'
		, 8000)

--TASK 3
--this should return 1
BEGIN TRANSACTION;
SELECT fGetNextSeatAvailable(1) = 4;
SELECT fGetNextSeatAvailable(1) = 1;
ROLLBACK;

--TASK 4
--this should return 11
BEGIN TRANSACTION;
SELECT fGetNumberOfFreeSeats(1) = 13
SELECT fGetNumberOfFreeSeats(1) = 11
ROLLBACK;

--TASK 5
BEGIN TRANSACTION;       
INSERT INTO Bookings(schedule_id, seat_id, people_ssn)
VALUES(2, 2, '1111748499'), (2, 7, '1111748499');
--skilar 2 
SELECT number_of_bookedSeats FROM EventSchedules where id = 2;
ROLLBACK;
--ætti að skila 0
SELECT number_of_bookedSeats FROM EventSchedules where id = 2;

--TASK 6
BEGIN TRANSACTION; 
--Á að skila 4
SELECT fFindConsecutiveSeats(1, 3);
--Ætti að gefa error
SELECT fFindConsecutiveSeats(1, 11);
ROLLBACK;

--TASK 7
BEGIN TRANSACTION; 
--Ætti að gefa error 
SELECT fBookManySeats(1, '0202122689', 1, 3);
BEGIN TRANSACTION; 
SELECT fBookManySeats(1, '0202122689', 4, 30);
--Ætti að virka
BEGIN TRANSACTION; 
SELECT fBookManySeats(2, '0202122689', 5, 3);
ROLLBACK;

SELECT * FROM Bookings;

--TASK 8
BEGIN TRANSACTION; 
--Ætti að virka
SELECT fFindAndBookSeats(5, 1, '1111748499')
--Ekki til - Error
SELECT fFindAndBookSeats(21, 1, '1111748499')
ROLLBACK;

SELECT * FROM Bookings;

--TASK 9
SELECT * FROM vGetShowList

--TASK 10
SELECT * FROM vListOfVipPeople



