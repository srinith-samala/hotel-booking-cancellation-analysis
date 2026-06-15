CREATE DATABASE HOTEL;
USE HOTEL

CREATE TABLE hotel(
	hotel varchar(100),
	is_canceled varchar(100),
    lead_time varchar(100),
    arrival_date_year varchar(100),
    arrival_date_month varchar(100),
    arrival_date_week_number varchar(100),
    arrival_date_day_of_month varchar(100),
    stays_in_weekend_nights varchar(100),
    stays_in_week_nights varchar(100),
    adults varchar(100),
    children varchar(100),
    babies varchar(100),
    meal varchar(100),
    country varchar(100),
    market_segment varchar(100),
    distribution_channel varchar(100),
    is_repeated_guest varchar(100),
    previous_cancellations varchar(100),
    previous_bookings_not_canceled varchar(100),
    reserved_room_type varchar(100),
    assigned_room_type varchar(100),
    booking_changes varchar(100),
    agent varchar(100),
    deposit_type varchar(100),
    days_in_waiting_list varchar(100),
    company varchar(100),
    customer_type varchar(100),
	adr varchar(100),
    required_car_parking_spaces varchar(100),
    reservation_status varchar(100),
    reservation_status_date varchar(100),
    total_of_special_requests varchar(100)
	);
	
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotel.csv'
INTO TABLE hotel
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from hotel limit 10;

-- Data Clesning
select distinct(count(*)) from hotel; # both are  same 

SELECT 
    hotel, arrival_date_year, arrival_date_month, arrival_date_day_of_month,
    adults, children, adr, COUNT(*) AS duplicate_count
FROM hotel
GROUP BY hotel, arrival_date_year, arrival_date_month, arrival_date_day_of_month,
         adults, children, adr
HAVING COUNT(*) > 1
order by duplicate_count desc;
 -- checking duplicates 
select *
from hotel
where hotel = "City Hotel" and arrival_date_year = "2016" and arrival_date_month = "February" and arrival_date_day_of_month = "17" and 
adults = "2" and children = "0" and adr = "75";

ALTER TABLE hotel
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

-- reviewing  duplicates 
WITH duplicates AS (
    SELECT id,
           ROW_NUMBER() OVER (
               PARTITION BY hotel, is_canceled, lead_time, arrival_date_year,
                            arrival_date_month, arrival_date_week_number,
                            arrival_date_day_of_month, stays_in_weekend_nights,
                            stays_in_week_nights, adults, children, babies,
                            meal, country, market_segment, distribution_channel,
                            is_repeated_guest, previous_cancellations,
                            previous_bookings_not_canceled, reserved_room_type,
                            assigned_room_type, booking_changes, deposit_type,
                            agent, company, days_in_waiting_list, customer_type,
                            adr, required_car_parking_spaces,
                            total_of_special_requests, reservation_status,
                            reservation_status_date
           ORDER BY id
           ) AS rn
    FROM hotel
)
SELECT * FROM duplicates WHERE rn > 1 

# droping duplicates 
WITH duplicates AS (
    SELECT id,
           ROW_NUMBER() OVER (
               PARTITION BY hotel, is_canceled, lead_time, arrival_date_year,
                            arrival_date_month, arrival_date_week_number,
                            arrival_date_day_of_month, stays_in_weekend_nights,
                            stays_in_week_nights, adults, children, babies,
                            meal, country, market_segment, distribution_channel,
                            is_repeated_guest, previous_cancellations,
                            previous_bookings_not_canceled, reserved_room_type,
                            assigned_room_type, booking_changes, deposit_type,
                            agent, company, days_in_waiting_list, customer_type,
                            adr, required_car_parking_spaces,
                            total_of_special_requests, reservation_status,
                            reservation_status_date
           ORDER BY id
           ) AS rn
    FROM hotel
)
DELETE FROM hotel
WHERE id IN (
    SELECT id FROM duplicates WHERE rn > 1
);


-- nulls val;ues 
SELECT
    SUM(CASE WHEN hotel IS NULL THEN 1 ELSE 0 END) AS hotel_nulls,
    SUM(CASE WHEN is_canceled IS NULL THEN 1 ELSE 0 END) AS is_canceled_nulls,
    SUM(CASE WHEN lead_time IS NULL THEN 1 ELSE 0 END) AS lead_time_nulls,
    SUM(CASE WHEN arrival_date_year IS NULL THEN 1 ELSE 0 END) AS arrival_date_year_nulls,
    SUM(CASE WHEN arrival_date_month IS NULL THEN 1 ELSE 0 END) AS arrival_date_month_nulls,
    SUM(CASE WHEN arrival_date_week_number IS NULL THEN 1 ELSE 0 END) AS arrival_date_week_number_nulls,
    SUM(CASE WHEN arrival_date_day_of_month IS NULL THEN 1 ELSE 0 END) AS arrival_date_day_of_month_nulls,
    SUM(CASE WHEN stays_in_weekend_nights IS NULL THEN 1 ELSE 0 END) AS weekend_nights_nulls,
    SUM(CASE WHEN stays_in_week_nights IS NULL THEN 1 ELSE 0 END) AS week_nights_nulls,
    SUM(CASE WHEN adults IS NULL THEN 1 ELSE 0 END) AS adults_nulls,
    SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) AS children_nulls,
    SUM(CASE WHEN babies IS NULL THEN 1 ELSE 0 END) AS babies_nulls,
    SUM(CASE WHEN meal IS NULL THEN 1 ELSE 0 END) AS meal_nulls,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN market_segment IS NULL THEN 1 ELSE 0 END) AS market_segment_nulls,
    SUM(CASE WHEN distribution_channel IS NULL THEN 1 ELSE 0 END) AS distribution_channel_nulls,
    SUM(CASE WHEN is_repeated_guest IS NULL THEN 1 ELSE 0 END) AS repeated_guest_nulls,
    SUM(CASE WHEN previous_cancellations IS NULL THEN 1 ELSE 0 END) AS previous_cancellations_nulls,
    SUM(CASE WHEN previous_bookings_not_canceled IS NULL THEN 1 ELSE 0 END) AS previous_bookings_not_canceled_nulls,
    SUM(CASE WHEN reserved_room_type IS NULL THEN 1 ELSE 0 END) AS reserved_room_type_nulls,
    SUM(CASE WHEN assigned_room_type IS NULL THEN 1 ELSE 0 END) AS assigned_room_type_nulls,
    SUM(CASE WHEN booking_changes IS NULL THEN 1 ELSE 0 END) AS booking_changes_nulls,
    SUM(CASE WHEN deposit_type IS NULL THEN 1 ELSE 0 END) AS deposit_type_nulls,
    SUM(CASE WHEN agent IS NULL THEN 1 ELSE 0 END) AS agent_nulls,
    SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END) AS company_nulls,
    SUM(CASE WHEN days_in_waiting_list IS NULL THEN 1 ELSE 0 END) AS waiting_list_nulls,
    SUM(CASE WHEN customer_type IS NULL THEN 1 ELSE 0 END) AS customer_type_nulls,
    SUM(CASE WHEN adr IS NULL THEN 1 ELSE 0 END) AS adr_nulls,
    SUM(CASE WHEN required_car_parking_spaces IS NULL THEN 1 ELSE 0 END) AS parking_nulls,
    SUM(CASE WHEN total_of_special_requests IS NULL THEN 1 ELSE 0 END) AS special_requests_nulls,
    SUM(CASE WHEN reservation_status IS NULL THEN 1 ELSE 0 END) AS reservation_status_nulls,
    SUM(CASE WHEN reservation_status_date IS NULL THEN 1 ELSE 0 END) AS reservation_status_date_nulls
FROM hotel;

select deposit_type,count(*) as county_tpe from hotel
group by deposit_type;
-- droping days_in_waiting_list
alter table hotel
drop  column days_in_waiting_list;

-- updateing county 
update hotel 
set country = "Unknown"
where country is null;
 
-- updating deposit 
ALTER TABLE hotel RENAME COLUMN deposit_type TO agent_id;
ALTER TABLE hotel RENAME COLUMN agent TO deposit_type;

-- deleting agent_id 
alter table hotel 
drop agent_id;

-- customer type cleanig 
select distinct(customer_type) from hotel;
UPDATE hotel
SET customer_type = 'Transient'
WHERE customer_type = 'Transient-Party';

select * from hotel limit 5;
select distinct reserved_room_type from hotel;
select distinct assigned_room_type from hotel;
select (lead_time) ,length (lead_time) as lenght_lead 
from hotel
group by lead_time
order by lenght_lead;

select distinct adr from hotel;
select distinct(previous_cancellations) ,length(previous_cancellations) as llr from hotel;
select distinct reservation_status_date from hotel;

-- Quries
select * from hotel limit 5;
-- 1) Do Customer who recive a differnt room type than requested have a higher cancellation rate ?
SELECT count(*) as customers,
	CASE 
		WHEN assigned_room_type = reserved_room_type THEN "Same"
        ELSE "Different"
	END AS room_match_status, 
	ROUND(AVG(is_canceled) * 100,2)as cancellation_rate 
FROM hotel 
GROUP BY room_match_status;
-- 2) Does a lead time affect cancellation probability 
SELECT count(*) as customer, 
    CASE 
        WHEN lead_time BETWEEN 0 AND 30 THEN '0-30 days'
        WHEN lead_time BETWEEN 31 AND 90 THEN '31-90 days'
        WHEN lead_time BETWEEN 91 AND 180 THEN '91-180 days'
        ELSE '181+ days'
    END AS lead_time_bucket,
    ROUND(AVG(is_canceled) * 100,2) AS cancellation_rate
FROM hotel
GROUP BY lead_time_bucket
ORDER BY CANCELLATION_RATE DESC ;

-- 3) Which Customer type has a highest Probability  Cancellation rate 
SELECT CUSTOMER_TYPE ,  count(*) as customer,
	ROUND(AVG(IS_CANCELED)*100,2) AS CANCELLED_RATE
    FROM HOTEL 
GROUP BY CUSTOMER_TYPE
ORDER BY CANCELLED_RATE DESC; 
-- 4) Does ADR level Influence cancellation Probabaility
SELECT count(*) as customers,
	CASE 	
		WHEN ADR < 80 THEN "LOW"
        WHEN ADR BETWEEN 80 AND 150 THEN "MEDIUM"
        ELSE "HIGH"
        END AS adr_segment, 
	ROUND(AVG(IS_CANCELED)*100,2) AS CANCELLED_RATE
    FROM HOTEL 
GROUP BY adr_segment
ORDER BY CANCELLED_RATE DESC; 
-- 5) Does a guest previous cancellation significantly  influence likelyhood of cancellation?
select count(*) as total_customer, 
	CASE 	
		WHEN previous_cancellations = 0 THEN "Reliable"
        WHEN previous_cancellations BETWEEN 1 and 3  THEN "Moderate"
        ELSE "High"
        END AS Previous_cancellation_category, 
	ROUND(AVG(IS_CANCELED)*100,2) AS CANCELLED_RATE
    FROM HOTEL 
GROUP BY Previous_cancellation_category
ORDER BY CANCELLED_RATE DESC;  




