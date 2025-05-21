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
state_id DECIMAL (12) PRIMARY KEY NOT NULL,
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
CREATE SEQUENCE make_id START WITH 1;





