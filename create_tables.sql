--  create users table 
CREATE TABLE users(
	user_id serial primary key,
 	user_name text,
  	is_faculty boolean
);
-- create tags table
CREATE TABLE tags (
  tag_name text primary key
  );

-- create build_weeks table
CREATE TABLE buildweeks(
   build_week_name text primary key
   );

 -- create recommendations table
  CREATE TABLE recommendations (
    recommendation_option text primary key);


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
    build_week_name text references buildweeks(build_week_name),
    resource_id integer references resources(resource_id),
    PRIMARY KEY (build_week_name, resource_id)
  );
  
  CREATE TABLE comment_inputs (
    comment_id SERIAL PRIMARY KEY,
    user_id integer references users(user_id),
    message text,
    time_stamp timestamp default NOW()
    resource_id integer references resources(resource_id),
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
    
    CREATE TABLE content_types_resource (
      content_type text references contenttypes(content_type),
      resource_id integer references resources(resource_id),
      PRIMARY KEY (content_type, resource_id)
    );
      
    
