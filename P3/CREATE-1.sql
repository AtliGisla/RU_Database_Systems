
----------------------------------------------------
-- Reykjavík University
-- Course: Databases 1 (T-202-GAG1) 2018
-- Project: 3, PL/PGSQL programming
-- CREATE script
----------------------------------------------------


-- Drop for recreation of db
DROP TABLE IF EXISTS Bookings CASCADE;
DROP TABLE IF EXISTS EventSchedules CASCADE;
DROP TABLE IF EXISTS Events CASCADE;
DROP TABLE IF EXISTS EventTypes CASCADE;
DROP TABLE IF EXISTS Venues CASCADE;
DROP TABLE IF EXISTS People CASCADE;


CREATE TABLE People(
	ssn CHAR(10)					-- SSN of person
	, name VARCHAR(255)				-- Name of person
	, email VARCHAR(255)				-- Email of person
	, address VARCHAR(255)				-- Address of person
	, zipcode CHAR(3)				-- Zipcode of person (3 chars for Iceland)
	, userType CHAR(1)				-- Type of user (C) Customer (S) Staff
	, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP	-- When user was created
	, UNIQUE(ssn)
	, PRIMARY KEY (ssn)
);

CREATE TABLE Venues(
	id SERIAL					-- ID of Venue, for reference
	, name VARCHAR(255)				-- Name of Venue
	, address VARCHAR(255)				-- Address of Venue
	, zipcode VARCHAR(10)				-- Zip code of Venue
	, number_of_seats INT				-- How many seats does the venue hold
	, PRIMARY KEY (id)
);

CREATE TABLE EventTypes(
	id SERIAL					-- ID of eventType, for reference
	, name VARCHAR(50)				-- Name like Movie, Concerts... etc.
    , PRIMARY KEY (id)
);

CREATE TABLE Events(
	id SERIAL					-- ID of event, to reference it from other tables/functions
	, name VARCHAR(255)				-- Name of event, do be shown as event title
	, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP	-- When the event was creataed
	, event_description TEXT			-- Description of event to be shown on website
	, event_listPrice INT				-- List price of event. Note: there is also a price in the schedule if there is a discount for example.
	, event_type INT				-- Type of event, references EventTypes
	, FOREIGN KEY (event_type) REFERENCES EventTypes(id)
	, PRIMARY KEY(id)
);

CREATE TABLE EventSchedules(
	id SERIAL					-- ID of Schedule, for reference
	, event_id INT					-- Reference to Event
	, venue_id INT					-- Reference to Venue
	, event_time TIMESTAMP				-- When the event should start
	, event_price INT NOT NULL			-- Price for seat
	, number_of_bookedSeats INT DEFAULT 0		-- How many seats have been booked
	, FOREIGN KEY(event_id) REFERENCES Events(id)
	, FOREIGN KEY(venue_id) REFERENCES Venues(id)
	, PRIMARY KEY(id)
	, UNIQUE(event_id, venue_id, event_time)
);

CREATE TABLE Bookings(
	schedule_id INT					-- Reference to schedule
	, seat_id INT					-- Seat booked
	, people_ssn CHAR(10)				-- SSN of people that booked the seat. NOTE: Single person can book many seats
	, FOREIGN KEY (schedule_id) REFERENCES EventSchedules(id)
	, FOREIGN KEY (people_ssn) REFERENCES People(ssn)
	, PRIMARY KEY (schedule_id, seat_id)
);

