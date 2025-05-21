-- Database: FInal Project

-- DROP DATABASE IF EXISTS "FInal Project";

CREATE DATABASE "FInal Project"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

DROP VIEW average_ride_stats;
DROP TABLE trail_name_change;
DROP TABLE dirt;
DROP TABLE gravel;
DROP TABLE pavement; 
DROP TABLE trail_surface;
DROP TABLE surface_type;
DROP TABLE bikeride_trail;
DROP TABLE trail;
DROP TABLE area;
DROP TABLE states;
DROP TABLE bikeride;
DROP TABLE rider_badges;
DROP TABLE badges;
DROP TABLE gravel_bike;
DROP TABLE mountain_bike;
DROP TABLE road_bike;
DROP TABLE road_wheel_size;
DROP TABLE gravel_wheel_size;
DROP TABLE mountain_wheel_size;
DROP TABLE bike;
DROP TABLE make;
DROP TABLE rider;
DROP TABLE experience;
	
CREATE TABLE experience (
experience_id DECIMAL (1) NOT NULL PRIMARY KEY,
experience_level VARCHAR (12) NOT NULL);

CREATE TABLE rider (
rider_id DECIMAL (12) NOT NULL PRIMARY KEY,
experience_id DECIMAL (1) NOT NULL,
username VARCHAR (64) NOT NULL,
first_name VARCHAR (32) NOT NULL,
last_name VARCHAR (32) NOT NULL,
creation_date DATE NOT NULL,
height_in DECIMAL (3) NOT NULL,
weight_lbs DECIMAL (3) NOT NULL,
CONSTRAINT experience_id_fk
FOREIGN KEY (experience_id)
REFERENCES experience (experience_id));

CREATE TABLE make (
make_id DECIMAL (12) NOT NULL PRIMARY KEY,
make_name VARCHAR (64) NOT NULL);

CREATE TABLE bike (
bike_id DECIMAL (12) NOT NULL PRIMARY KEY,
rider_id DECIMAL (12) NOT NULL,
make_id DECIMAL (12) NULL,
model VARCHAR (64) NULL, 
year DECIMAL (4) NULL,
material VARCHAR (64) NULL,
type VARCHAR (64) NOT NULL,
CONSTRAINT rider_id_fk
FOREIGN KEY (rider_id)
REFERENCES rider (rider_id),
CONSTRAINT make_id_fk
FOREIGN KEY (make_id)
REFERENCES make (make_id));

CREATE TABLE road_wheel_size (
road_wheel_size_id DECIMAL (12) NOT NULL PRIMARY KEY,
size VARCHAR (4) NOT NULL);

CREATE TABLE gravel_wheel_size (
gravel_wheel_size_id DECIMAL (12) NOT NULL PRIMARY KEY,
size VARCHAR (4) NOT NULL);

CREATE TABLE mountain_wheel_size (
mountain_wheel_size_id DECIMAL (12) NOT NULL PRIMARY KEY,
size DECIMAL (3,1) NOT NULL);

CREATE TABLE road_bike (
bike_id DECIMAL (12) NOT NULL PRIMARY KEY,
road_wheel_size_id DECIMAL (12) NULL,
CONSTRAINT road_bike_fk
FOREIGN KEY (bike_id)
REFERENCES bike (bike_id),
CONSTRAINT road_wheel_size_fk
FOREIGN KEY (road_wheel_size_id)
REFERENCES road_wheel_size (road_wheel_size_id));

CREATE TABLE gravel_bike (
bike_id DECIMAL (12) NOT NULL PRIMARY KEY,
gravel_wheel_size_id DECIMAL (12) NULL,
CONSTRAINT gravel_bike_fk
FOREIGN KEY (bike_id)
REFERENCES bike (bike_id),
CONSTRAINT gravel_wheel_size_fk
FOREIGN KEY (gravel_wheel_size_id)
REFERENCES gravel_wheel_size (gravel_wheel_size_id));

CREATE TABLE mountain_bike (
bike_id DECIMAL (12) NOT NULL PRIMARY KEY,
mountain_wheel_size_id DECIMAL (12) NOT NULL,
wheel_width DECIMAL (2,1) NULL,
is_full_sus BOOLEAN NOT NULL,
is_hardtail BOOLEAN NOT NULL,
CONSTRAINT mountain_bike_fk
FOREIGN KEY (bike_id)
REFERENCES bike (bike_id),
CONSTRAINT mountain_wheel_size_fk
FOREIGN KEY (mountain_wheel_size_id)
REFERENCES mountain_wheel_size (mountain_wheel_size_id));

CREATE TABLE badges (
badge_id DECIMAL (12) NOT NULL PRIMARY KEY,
badge_name VARCHAR (64) NOT NULL);

CREATE TABLE rider_badges (
rider_badges_id DECIMAL (12) NOT NULL PRIMARY KEY,
rider_id DECIMAL (12) NOT NULL,
badge_id DECIMAL (12) NOT NULL,
CONSTRAINT rider_badge_fk
FOREIGN KEY (rider_id)
REFERENCES rider (rider_id),
CONSTRAINT badge_badge_fk
FOREIGN KEY (badge_id)
REFERENCES badges (badge_id));

CREATE TABLE bikeride (
bikeride_id DECIMAL (12) NOT NULL PRIMARY KEY,
rider_id DECIMAL (12) NOT NULL,
ride_time TIME NOT NULL,
ride_distance DECIMAL (4) NOT NULL,
average_speed DECIMAL (3) NOT NULL,
max_speed DECIMAL (3) NOT NULL,
elevation_gain DECIMAL (5) NOT NULL,
elevation_lost DECIMAL (5) NOT NULL,
calories_burned DECIMAL (5) NOT NULL,
CONSTRAINT rider_bikeride_fk
FOREIGN KEY (rider_id)
REFERENCES rider (rider_id));

CREATE TABLE states (
state_id DECIMAL (12) PRIMARY KEY NOT NULL, state_code VARCHAR (2) NOT NULL,
state_name VARCHAR (14) NOT NULL);

CREATE TABLE area (
area_id DECIMAL (12) NOT NULL PRIMARY KEY,
state_id DECIMAL (12),
area_name VARCHAR (64) NULL,
number_trails DECIMAL (5) NOT NULL,
total_miles DECIMAL (12,2) NOT NULL,
CONSTRAINT state_id_fk
FOREIGN KEY (state_id)
REFERENCES states (state_id));

CREATE TABLE trail (
trail_id DECIMAL (12) NOT NULL PRIMARY KEY,
area_id DECIMAL (12) NOT NULL,
trail_name VARCHAR (64) NULL,
trail_length DECIMAL (6,2) NOT NULL,
trail_climb DECIMAL (5) NOT NULL,
trail_descent DECIMAL (5) NOT NULL,
CONSTRAINT area_id_fk
FOREIGN KEY (area_id)
REFERENCES area (area_id));

CREATE TABLE bikeride_trail (
bikeride_trail_id DECIMAL (12) NOT NULL PRIMARY KEY,
bikeride_id DECIMAL (12) NOT NULL,
trail_id DECIMAL (12) NOT NULL,
CONSTRAINT bikeride_id_fk
FOREIGN KEY (bikeride_id)
REFERENCES bikeride (bikeride_id),
CONSTRAINT trail_bikeride_fk
FOREIGN KEY (trail_id)
REFERENCES trail (trail_id));

CREATE TABLE surface_type (
surface_type_id DECIMAL (12) NOT NULL PRIMARY KEY,
description VARCHAR (64) NOT NULL);

CREATE TABLE trail_surface (
trail_surface_id DECIMAL (12) NOT NULL PRIMARY KEY,
trail_id DECIMAL (12),
surface_type_id DECIMAL (12),
CONSTRAINT trail_surface_fk
FOREIGN KEY (trail_id)
REFERENCES trail (trail_id),
CONSTRAINT surface_type_fk
FOREIGN KEY (surface_type_id)
REFERENCES surface_type (surface_type_id));

CREATE TABLE pavement (
trail_surface_id DECIMAL (12) NOT NULL PRIMARY KEY,
is_bike_path BOOLEAN NOT NULL,
CONSTRAINT pavement_fk
FOREIGN KEY (trail_surface_id)
REFERENCES trail_surface (trail_surface_id));

CREATE TABLE gravel (
trail_surface_id DECIMAL (12) NOT NULL PRIMARY KEY,
allows_cars BOOLEAN NOT NULL,
CONSTRAINT gravel_fk
FOREIGN KEY (trail_surface_id)
REFERENCES trail_surface (trail_surface_id));

CREATE TABLE dirt (
trail_surface_id DECIMAL (12) NOT NULL PRIMARY KEY,
is_singletrack BOOLEAN NOT NULL,
CONSTRAINT dirt_fk
FOREIGN KEY (trail_surface_id)
REFERENCES trail_surface (trail_surface_id));

CREATE TABLE trail_name_change (
trail_name_change_id DECIMAL (12) NOT NULL PRIMARY KEY,
trail_id DECIMAL (12) NOT NULL,
old_name VARCHAR (64) NOT NULL,
new_name VARCHAR (64) NOT NULL,
name_change_date DATE,
FOREIGN KEY (trail_id) REFERENCES trail (trail_id));

DROP SEQUENCE rider_id_seq;
DROP SEQUENCE bike_id_seq;
DROP SEQUENCE badge_id_seq;
DROP SEQUENCE user_badges_id_seq;
DROP SEQUENCE bikeride_id_seq;
DROP SEQUENCE trail_id_seq;
DROP SEQUENCE bikeride_trail_id_seq;
DROP SEQUENCE area_id_seq;
DROP SEQUENCE state_id_seq;
DROP SEQUENCE trail_surface_id_seq;
DROP SEQUENCE make_id_seq;
DROP SEQUENCE name_change_seq;

CREATE SEQUENCE rider_id_seq START WITH 1;
CREATE SEQUENCE bike_id_seq START WITH 1;
CREATE SEQUENCE badge_id_seq START WITH 1;
CREATE SEQUENCE user_badges_id_seq START WITH 1;
CREATE SEQUENCE bikeride_id_seq START WITH 1;
CREATE SEQUENCE trail_id_seq START WITH 1;
CREATE SEQUENCE bikeride_trail_id_seq START WITH 1;
CREATE SEQUENCE area_id_seq START WITH 1;
CREATE SEQUENCE state_id_seq START WITH 1;
CREATE SEQUENCE trail_surface_id_seq START WITH 1;
CREATE SEQUENCE make_id_seq START WITH 1;
CREATE SEQUENCE name_change_seq START WITH 1;

--INDEXES

CREATE INDEX riderIDidx ON bike (rider_id);
CREATE INDEX riderbadgedidx ON rider_badges (rider_id);
CREATE INDEX badgeididx ON rider_badges (badge_id);
CREATE INDEX bikeride_rideridx ON bikeride (rider_id);
CREATE INDEX areaIDidx ON trail (area_id);
CREATE INDEX bikerideIDidx ON bikeride_trail (bikeride_id);
CREATE INDEX trailIDidx ON bikeride_trail (trail_id);
CREATE INDEX trailsurfaceidx ON trail_surface (trail_id);
CREATE INDEX modelidx ON bike (model);
CREATE INDEX materialidx ON bike (material);
CREATE INDEX numbertrailsidx ON area (number_trails);

--Stored Prcedures 

CREATE OR REPLACE FUNCTION add_mountain_bike(bike_id DECIMAL(12), rider_id DECIMAL(12),
											 make_id DECIMAL(12), model VARCHAR(64),
											 year DECIMAL(4), material VARCHAR(64), type VARCHAR(64),
											 mountain_wheel_size_id DECIMAL(12),
											 wheel_width DECIMAL(2,1), is_full_sus BOOLEAN)
RETURNS VOID 
AS $proc$
DECLARE
    is_hardtail BOOLEAN;
BEGIN
    IF is_full_sus THEN
       is_hardtail := FALSE;
    ELSE
        is_hardtail := TRUE;
    END IF;

    INSERT INTO bike (bike_id, rider_id, make_id, model, year, material, type)
    VALUES (bike_id, rider_id, make_id, model, year, material, type);

    INSERT INTO mountain_bike (bike_id, mountain_wheel_size_id, wheel_width, is_full_sus, is_hardtail)
    VALUES (bike_id, mountain_wheel_size_id, wheel_width, is_full_sus, is_hardtail);
END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_bikeride (bikeride_id DECIMAL(12), rider_id DECIMAL(12),ride_time VARCHAR(8),
											ride_distance DECIMAL(4),max_speed DECIMAL(3),
											elevation_gain DECIMAL(5),elevation_lost DECIMAL(5),
											calories_burned DECIMAL(5))
RETURNS VOID AS $$
DECLARE
    ride_time_seconds DECIMAL(10, 2);
    ride_time_hours DECIMAL(10, 2);
    average_speed DECIMAL(10, 1);
BEGIN
    ride_time_seconds := EXTRACT(EPOCH FROM ride_time::TIME);
    ride_time_hours := ride_time_seconds / 3600;
    IF ride_time_hours > 0 THEN
        average_speed := ROUND(ride_distance / ride_time_hours, 2);
    ELSE
        average_speed := 0.0;
    END IF;

    INSERT INTO bikeride (bikeride_id, rider_id, ride_time, ride_distance, 
						  average_speed, max_speed, elevation_gain, 
						  elevation_lost, calories_burned)
    VALUES (bikeride_id, rider_id, ride_time::TIME, ride_distance, 
			average_speed, max_speed, elevation_gain, 
			elevation_lost, calories_burned);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION NameChangeFunction ()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$ 
	BEGIN
		INSERT INTO trail_name_change (trail_name_change_id, trail_id, old_name,
									  new_name, name_change_date)
		VALUES (nextval ('name_change_seq'), NEW.trail_id, OLD.trail_name, NEW.trail_name,
			   current_date);
	RETURN NEW;
	END;
$trigfunc$ ;

CREATE TRIGGER NameChangeTrigger
BEFORE UPDATE OF trail_name ON trail
FOR EACH ROW
EXECUTE PROCEDURE NameChangeFunction ();

--Data Inserts

INSERT INTO mountain_wheel_size (mountain_wheel_size_id, size)
VALUES (1, 29);
INSERT INTO mountain_wheel_size (mountain_wheel_size_id, size)
VALUES (2, 27.5);
INSERT INTO mountain_wheel_size (mountain_wheel_size_id, size)
VALUES (3, 26);

Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'), 'Trek');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'), 'Specialized');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'),'Santa Cruz');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'),'Cannondale');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'),'Yeti');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'),'Giant');
Insert INTO make (make_id, make_name)
VALUES (nextval('make_id_seq'),'Scott');

INSERT INTO experience (experience_id, experience_level)
VALUES (1, 'Beginner');
INSERT INTO experience (experience_id, experience_level)
VALUES (2, 'Intermediate');
INSERT INTO experience (experience_id, experience_level)
VALUES (3, 'Advanced');
INSERT INTO experience (experience_id, experience_level)
VALUES (4, 'Expert');

INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 4, 'jjames32', 'James', 'James', '03-MAR-2022',
	   72, 180);
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 1, 'bikerchris', 'Chris', 'Christopher', 
		'15-JUN-2022', 70, 195);
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 3, 'rebeccarides', 'Rebecca', 'Johnson', 
		'23-May-2023', 67, 135);
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 2, 'bigmatty', 'Matthew', 'Drury', '30-JUL-2023',
		75, 230);
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 4, 'jimborips', 'Jim', 'Bradley', '09-AUG-2021',
			   73, 170);
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 2, 'bballgirl4', 'Maggie', 'Ryan', '13-MAR-2024',
		66, 140);
		
INSERT INTO rider (rider_id, experience_id, username, first_name, last_name,
				  creation_date, height_in, weight_lbs)
VALUES (nextval('rider_id_seq'), 3, 'jjames32', 'Robert', 'California', '03-JUL-2023',
	   70, 185);
	   

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 5, 5, 'SB150', 2022,
							  'Carbon', 'Mountain', 1, 2.5, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 2, 4, 'Epic', 2020,
							  'Alluminum', 'Mountain', 1, 2.3, 'False');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 3, 4, 'Habit', 2019,
							  'Alloy', 'Mountain', 1, 2.4, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 1, 1, 'Remedy', 2020,
							  'Carbon', 'Mountain', 2, 2.6, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 6, 6, 'Trance', 2021,
							  'Alloy', 'Mountain', 1, 2.4, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 7, 2, 'Stumpjumper', 2021,
							  'Alloy', 'Mountain', 1, 2.4, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 1, 3, 'Hightower', 2022,
							  'Carbon', 'Mountain', 1, 2.5, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 3, 3, 'Megatower', 2019,
							  'Alloy', 'Mountain', 2, 2.6, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 5, 1, 'Fuel EX', 2019,
							  'Carbon', 'Mountain', 1, 2.5, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 7, 5, 'SB 160', 2023,
							  'Carbon', 'Mountain', 2, 2.6, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE add_mountain_bike (nextval('bike_id_seq'), 2, 4, 'Trigger', 2019,
							  'Alloy', 'Mountain', 2, 2.4, 'True');
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 5, '03:12:44', 24, 27,
							2031,2031,1417);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 2, '00:42:32', 7, 15,
							1001,1001,816);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 1, '00:15:22', 6.3, 27,
							12,1254,516);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 3, '02:10:31', 17, 21,
							416,416,1522);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 4, '00:31:44', 5, 17,
							812,812,1200);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 6, '01:47:22', 12, 20,
							1455,1400,1187);
END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
$$BEGIN
	EXECUTE create_bikeride (nextval('bikeride_id_seq'), 3, '00:35:12', 7, 20,
							1001,1001,512);
END$$;
COMMIT TRANSACTION;

INSERT INTO states(state_id, state_code, state_name)
VALUES
(nextval('state_id_seq'),'AL','Alabama'),
(nextval('state_id_seq'),'AK','Alaska'),
(nextval('state_id_seq'),'AZ','Arizona'),
(nextval('state_id_seq'),'AR','Arkansas'),
(nextval('state_id_seq'),'CA','California'),
(nextval('state_id_seq'),'CO','Colorado'),
(nextval('state_id_seq'),'CT','Connecticut'),
(nextval('state_id_seq'),'DE','Delaware'),
(nextval('state_id_seq'),'FL','Florida'),
(nextval('state_id_seq'),'GA','Georgia'),
(nextval('state_id_seq'),'HI','Hawaii'),
(nextval('state_id_seq'),'ID','Idaho'),
(nextval('state_id_seq'),'IL','Illinois'),
(nextval('state_id_seq'),'IN','Indiana'),
(nextval('state_id_seq'),'IA','Iowa'),
(nextval('state_id_seq'),'KS','Kansas'),
(nextval('state_id_seq'),'KY','Kentucky'),
(nextval('state_id_seq'),'LA','Louisiana'),
(nextval('state_id_seq'),'ME','Maine'),
(nextval('state_id_seq'),'MD','Maryland'),
(nextval('state_id_seq'),'MA','Massachusetts'),
(nextval('state_id_seq'),'MI','Michigan'),
(nextval('state_id_seq'),'MN','Minnesota'),
(nextval('state_id_seq'),'MS','Mississippi'),
(nextval('state_id_seq'),'MO','Missouri'),
(nextval('state_id_seq'),'MT','Montana'),
(nextval('state_id_seq'),'NE','Nebraska'),
(nextval('state_id_seq'),'NV','Nevada'),
(nextval('state_id_seq'),'NH','New Hampshire'),
(nextval('state_id_seq'),'NJ','New Jersey'),
(nextval('state_id_seq'),'NM','New Mexico'),
(nextval('state_id_seq'),'NY','New York'),
(nextval('state_id_seq'),'NC','North Carolina'),
(nextval('state_id_seq'),'ND','North Dakota'),
(nextval('state_id_seq'),'OH','Ohio'),
(nextval('state_id_seq'),'OK','Oklahoma'),
(nextval('state_id_seq'),'OR','Oregon'),
(nextval('state_id_seq'),'PA','Pennsylvania'),
(nextval('state_id_seq'),'RI','Rhode Island'),
(nextval('state_id_seq'),'SC','South Carolina'),
(nextval('state_id_seq'),'SD','South Dakota'),
(nextval('state_id_seq'),'TN','Tennessee'),
(nextval('state_id_seq'),'TX','Texas'),
(nextval('state_id_seq'),'UT','Utah'),
(nextval('state_id_seq'),'VT','Vermont'),
(nextval('state_id_seq'),'VA','Virginia'),
(nextval('state_id_seq'),'WA','Washington'),
(nextval('state_id_seq'),'WV','West Virginia'),
(nextval('state_id_seq'),'WI','Wisconsin'),
(nextval('state_id_seq'),'WY','Wyoming');


INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES (nextval('area_id_seq'), 12, 'Mountain Valley', 10, 50.5);

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES (nextval('area_id_seq'), 22, 'Lakeside Trails', 8, 40.2);

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES (nextval('area_id_seq'), 21, 'Forest Ridge', 12, 60.8);

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES (nextval('area_id_seq'), 44, 'Big Mesa Plateau', 6, 30.1);

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES (nextval('area_id_seq'), 5, 'Coastal Plains', 7, 35.7);

INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 1, 'Advanced Loop', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 1), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 1), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 1));

INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 2, 'Lakeside Singletrack', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 2), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 2), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 2));

INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 3, 'Forest Plummit', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 3), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 3), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 3));

INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 2, 'Lakeview Ridge', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 4), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 4), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 4));
		
INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 5, 'Oceanview Ride', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 5), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 5), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 5));

INSERT INTO trail (trail_id, area_id, trail_name, trail_length, trail_climb, trail_descent)
VALUES (nextval('trail_id_seq'), 4, 'Big Desert Loop', (SELECT ride_distance FROM bikeride WHERE bikeride_id = 6), 
		(SELECT elevation_gain FROM bikeride WHERE bikeride_id = 6), 
		(SELECT elevation_lost FROM bikeride WHERE bikeride_id = 6));

		
INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 1, (SELECT trail_id FROM trail WHERE trail_name = 'Advanced Loop'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 2, (SELECT trail_id FROM trail WHERE trail_name = 'Lakeside Singletrack'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 3, (SELECT trail_id FROM trail WHERE trail_name = 'Forest Plummit'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 4, (SELECT trail_id FROM trail WHERE trail_name = 'Lakeview Ridge'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 5, (SELECT trail_id FROM trail WHERE trail_name = 'Oceanview Ride'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 5, (SELECT trail_id FROM trail WHERE trail_name = 'Big Desert Loop'));

INSERT INTO bikeride_trail (bikeride_trail_id, bikeride_id, trail_id)
VALUES (nextval('bikeride_trail_id_seq'), 7, (SELECT trail_id FROM trail WHERE trail_name = 'Lakeside Singletrack'));

UPDATE trail
SET trail_name = 'Big Mesa Loop'
WHERE trail_id = 6;

UPDATE trail
SET trail_name = 'Experts Only'
WHERE trail_id = 1;

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES 
	(nextval('area_id_seq'), 6, 'Green Mountain', 7, 32),
	(nextval('area_id_seq'), 6, 'North Table', 4, 17),
	(nextval('area_id_seq'), 6, 'Bear Creek', 4, 21),
	(nextval('area_id_seq'), 6, 'FLoyd Hill', 5, 19),
	(nextval('area_id_seq'), 6, 'Sentenial Cone', 3, 29);
	

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES 
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Mountain Ridge', 20, 50.5),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Valley Trails', 15, 40.2),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Riverbank Rides', 10, 30.8),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Highland Haven', 25, 60.3),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Coastal Paths', 18, 45.7),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Desert Trails', 12, 35.6),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Forest Tracks', 22, 55.1),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Lake Trails', 17, 42.9),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Prairie Pathways', 14, 38.0),
    (nextval('area_id_seq'), (SELECT state_id FROM states ORDER BY random() LIMIT 1), 'Urban Explorations', 8, 25.5);

INSERT INTO area (area_id, state_id, area_name, number_trails, total_miles)
VALUES 
	(nextval('area_id_seq'), 5, 'Redwood Trails', 15, 127),
	(nextval('area_id_seq'), 5, 'Yosemite Valley', 38, 244),
	(nextval('area_id_seq'), 5, 'Mammoth Mountain', 62, 130),
	(nextval('area_id_seq'), 44, 'Moab', 75, 210),
	(nextval('area_id_seq'), 44, 'La Salle Muountains', 13, 89);
	
--QUERIES

-- How many mountain bikes are there of each wheel size?
SELECT mountain_wheel_size.size AS mountain_bike_wheel_size, 
COUNT(*) AS num_bikes
FROM bike
JOIN mountain_bike ON bike.bike_id = mountain_bike.bike_id
JOIN mountain_wheel_size ON 
mountain_bike.mountain_wheel_size_id = mountain_wheel_size.mountain_wheel_size_id
GROUP BY mountain_wheel_size.size;

--Most Popular Trails and their respective areas
SELECT trail.trail_name, area.area_name, states.state_code, COUNT(*) AS num_rides
FROM bikeride
JOIN bikeride_trail ON bikeride.bikeride_id = bikeride_trail.bikeride_id
JOIN trail ON bikeride_trail.trail_id = trail.trail_id
JOIN area ON trail.area_id = area.area_id
JOIN states ON area.state_id = states.state_id
GROUP BY trail.trail_name, area.area_name, states.state_code
ORDER BY num_rides DESC;

--Average Ride Stats
CREATE OR REPLACE VIEW average_ride_stats AS
SELECT rider.rider_id, rider.username, rider.first_name, rider.last_name,
       ROUND(AVG(ride_distance),2) AS avg_ride_distance,
       ROUND(AVG(average_speed),2) AS avg_average_speed,
       ROUND(AVG(elevation_gain),2) AS avg_elevation_gain,
       ROUND(AVG(calories_burned),2) AS avg_calories_burned,
       (SELECT COUNT(*) FROM bikeride WHERE rider_id = rider.rider_id) AS total_rides
FROM bikeride
JOIN rider ON bikeride.rider_id = rider.rider_id
GROUP BY rider.rider_id, rider.username, rider.first_name, rider.last_name;

SELECT * from average_ride_stats
WHERE rider_id = 5

-- Number of bikes by brand 
SELECT make.make_name AS brand, COUNT(bike.bike_id) AS num_bikes
FROM make
JOIN bike ON make.make_id = bike.make_id
GROUP BY make.make_name
HAVING COUNT(bike.bike_id) > 0
ORDER BY num_bikes DESC;

-- Areas by state

SELECT states.state_name AS state_name, COUNT(area.area_id) AS num_areas
FROM states
LEFT JOIN area ON states.state_id = area.state_id
GROUP BY states.state_name
ORDER BY num_areas DESC;









							  
