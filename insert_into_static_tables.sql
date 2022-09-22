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

  INSERT INTO tags (tag_name) VALUES
('React'), ('Node.js'), 
('Typescript'), ('Javascript'),
('Python'), ('Frontend'), ('Backend'),
('CSS'), ('Bootstrap'), ('Tailwind'),
('Sass'), ('SQL'), ('Postgress'),
('Data structure'), ('HTML'), ('AI');

 INSERT INTO  buildweeks VALUES
 ('WEEK-1'), ('WEEK2'), ('WEEK-3'),('WEEK-4'), ('WEEK-5'), ('WEEK-6'), ('WEEK-7'), ('WEEK-8');

     
-- adding recs into recommendations table
INSERT INTO recommendations VALUES
('I recommend this resource after having used it'),
('I do not recommend this resource, having used it'),
('I have not used this resource but it looks promising');
  
    INSERT INTO contenttypes (content_type) VALUES
  ('Article'), ('Video'), ('Podcast'),
  ('Diagram/Image'), ('E-book'), ('Exercise'),
  ('Software-tool'), ('Course'), ('Cheat-sheet'), 
  ('Reference'), ('Resource list'), ('Youtube channel'), 
  ('Organisation'), ('Github repo');