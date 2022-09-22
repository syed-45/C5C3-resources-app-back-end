--  create users table 
CREATE TABLE users(
	user_id serial primary key,
 	user_name text,
  	is_faculty boolean
);

INSERT INTO users (user_name, is_faculty) 
values ('Amelia',false),('Bhawick',false),
	   ('Ciaran', true),('Jennifer',false),
       ('Katie', true),('Keadeish',false),
       ('Laura', false),('Lauren', true),
       ('Leo', false),('Lui',false),
       ('Mae', false),('Melissa',false),
       ('Mistura', false),('Neill',true),
       ('Niamh', false),('Salman',false),
       ('Sevgi', false),('Will',false),
       ('Yara', false)
       ;

-- create tags table
CREATE TABLE tags (
  tag_name text primary key
  );

  INSERT INTO tags (tag_name) VALUES
('React'), ('Node.js'), 
('Typescript'), ('Javascript'),
('Python'), ('Frontend'), ('Backend'),
('CSS'), ('Bootstrap'), ('Tailwind'),
('Sass'), ('SQL'), ('Postgress'),
('Data structure'), ('HTML'), ('AI');

-- create build_weeks table
CREATE TABLE buildweeks(
   build_week_name text primary key
   );
-- adding weeks into build_weeks table 
 INSERT INTO  buildweeks VALUES
 ('WEEK-1'), ('WEEK2'), ('WEEK-3'),('WEEK-4'), ('WEEK-5'), ('WEEK-6'), ('WEEK-7'), ('WEEK-8');

 -- create recommendations table
  CREATE TABLE recommendations (
    recommendation_option text primary key);
    
-- adding recs into recommendations table
INSERT INTO recommendations VALUES
('I recommend this resource after having used it'),
('I do not recommend this resource, having used it'),
('I have not used this resource but it looks promising');

CREATE TABLE resources (
  resource_id SERIAL PRIMARY KEY,
  submitter integer REFERENCES users(user_id),
  title text,
  author text,
  url text,
  time_stamp timestamp default NOW(),
  summary text,
  recommendation_option text references recommendations(recommendation_option),
  recommendation_text text
  );
  
CREATE TABLE tag_resource (
  tag_name text references tags(tag_name),
  resource_id integer references resources(resource_id),
  PRIMARY KEY(tag_name, resource_id)
  );
  
  CREATE TABLE buildweek_resource (
    buildweek_id text references buildweeks(build_week_name),
    resource_id integer references resources(resource_id),
    PRIMARY KEY (buildweek_id, resource_id)
  );
  
  CREATE TABLE comment_inputs (
    comment_id SERIAL PRIMARY KEY,
    user_id integer references users(user_id),
    message text,
    time_stamp timestamp default NOW()
   );
   
   CREATE TABLE favourites (
     user_id integer references users(user_id),
     resource_id integer references resources(resource_id),
     PRIMARY KEY (user_id, resource_id)
     );     
     
  CREATE TABLE likes (
    user_id integer references users(user_id),
    resource_id integer references resources(resource_id),
    preferences text,
    PRIMARY KEY (user_id, resource_id)
   );

     CREATE TABLE contenttypes (
    content_type text primary key
    );
    
    INSERT INTO contenttypes (content_type) VALUES
  ('Article'), ('Video'), ('Podcast'),
  ('Diagram/Image'), ('E-book'), ('Exercise'),
  ('Software-tool'), ('Course'), ('Cheat-sheet'), 
  ('Reference'), ('Resource list'), ('Youtube channel'), 
  ('Organisation'), ('Github repo');
    
    CREATE TABLE content_types_resource (
      content_type text references contenttypes(content_type),
      resource_id integer references resources(resource_id),
      PRIMARY KEY (content_type, resource_id)
    );
      
    
