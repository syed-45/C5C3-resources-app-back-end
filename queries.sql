--  create users table 
CREATE TABLE users(
	user_id serial primary key,
 	user_name text,
  	is_faculty boolean
)

-- create tags table
CREATE TABLE tags (
  tag_name text primary key
  )
-- create build_weeks table
CREATE TABLE build_weeks(
   build_week_name text primary key
   )
-- adding weeks into build_weeks table 
 INSERT INTO  build_weeks VALUES
 ('WEEK-1')('WEEK2'), ('WEEK-3'),('WEEK-4'), ('WEEK-5'), ('WEEK-6'), ('WEEK-7'), ('WEEK-8')

 -- create recommendations table
  CREATE TABLE recommendations (
    frecommendation_option text primary key)
    
-- adding recs into recommendations table
INSERT INTO recommendations VALUES
('I recommend this resource after having used it'),
('I do not recommend this resource, having used it'),
('I have not used this resource but it looks promising')