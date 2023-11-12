CREATE DATABASE db_zoo;

USE db_zoo;

CREATE TABLE tbl_animalia (
    animalia_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    animalia_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_animalia (animalia_type)
VALUES
    ('vertebrate'),
    ('invertebrate')
;

SELECT * FROM tbl_animalia;

CREATE TABLE tbl_class (
    class_id INT PRIMARY KEY NOT NULL IDENTITY(100,1),
    class_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_class (class_type)
VALUES
    ('bird'),
    ('reptilian'),
    ('mammal'),
    ('arthropod'),
    ('fish'),
    ('worm'),
    ('cnidaria'),
    ('echinoderm');

SELECT * FROM tbl_class;


UPDATE tbl_class SET class_type = 'birds' WHERE class_type = 'bird';

SELECT REPLACE(class_type, 'bird', 'birds') FROM tbl_class;

SELECT class_type FROM tbl_class WHERE class_type = 'bird';

SELECT UPPER(class_type) FROM tbl_class WHERE class_type LIKE '%bird%';

SELECT COUNT(class_type) FROM tbl_class WHERE class_type LIKE '%bird%';

CREATE TABLE tbl_order (
    order_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    order_type VARCHAR(50) NOT NULL
);

select * from tbl_order;

CREATE TABLE tbl_care (
    care_id VARCHAR(50) PRIMARY KEY NOT NULL,
    care_type VARCHAR(50) NOT NULL,
    care_specialist INT NOT NULL
);

select * from tbl_care;

CREATE TABLE tbl_nutrition (
    nutrition_id INT PRIMARY KEY NOT NULL IDENTITY(2200,1),
    nutrition_type VARCHAR(50) NOT NULL,
    nutrition_cost MONEY NOT NULL
);

select * from tbl_nutrition;

CREATE TABLE tbl_habitat (
   habitat_id INT PRIMARY KEY NOT NULL IDENTITY(5000,1),
   habitat_type VARCHAR(50) NOT NULL,
   habitat_cost MONEY NOT NULL
);

select * from tbl_habitat;

CREATE TABLE tbl_specialist (
    specialist_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    specialist_fname VARCHAR(50) NOT NULL,
    specialist_lname VARCHAR(50) NOT NULL,
    specialist_contact VARCHAR(50) NOT NULL
);

select * from tbl_specialist;

INSERT INTO tbl_order (order_type) 
VALUES ('carnivore'),
		('herbivore'),
		('omnivore');

SELECT * FROM tbl_order;

INSERT INTO tbl_care (care_id, care_type, care_specialist)
VALUES
('care_0', 'replace the straw', 1),
('care_1', 'repair or replace broken toys', 4),
('care_2', 'bottle feed vitamins', 1),
('care_3', 'human contact_pet subject', 2),
('care_4', 'clean up animal waste', 1),
('care_5', 'move subject to exercise pen', 3),
('care_6', 'drain and refill aquarium', 1),
('care_7', 'extensive dental work', 3);

SELECT * FROM tbl_care;

INSERT INTO tbl_nutrition
(nutrition_type, nutrition_cost)
VALUES
('raw fish', 1500),
('living rodents', 600),
('mixture of fruit and rice', 800),
('warm bottle of milk', 600),
('syringe fed broth', 600),
('lard and seed mix', 300),
('aphids', 150),
('vitamins and marrow', 3500);

SELECT * FROM tbl_nutrition;

INSERT INTO tbl_habitat (habitat_type, habitat_cost)
VALUES ('tundra', 40000),
       ('grassy knoll with trees', 12000),
       ('10 ft pond and rocks ', 30000),
       ('icy aquarium with snowy facade', 50000),
       ('short grass, shade and moat', 50000),
       ('netted forest atrium ', 10000),
       ('jungle vines and winding branches', 15000),
       ('cliff with shaded cave', 15000);

SELECT * FROM tbl_habitat;

INSERT INTO tbl_specialist
(specialist_fname, specialist_lname, specialist_contact)
VALUES
('margaret', 'nguyen', '384-576-2899'),
('mary', 'fischer', '384-784-4856'),
('arnold', 'holden', '385-475-3944'),
('kai', 'byzant', '384-485-4855'),
('delmonte', 'fyedo', '768-288-3749');

SELECT * FROM tbl_specialist;

CREATE TABLE tbl_species (
    species_id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
    species_name VARCHAR(50) NOT NULL,
    species_animalia INT NOT NULL CONSTRAINT fk_animalia_id FOREIGN KEY REFERENCES tbl_animalia(animalia_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_class INT NOT NULL CONSTRAINT fk_class_id FOREIGN KEY REFERENCES tbl_class(class_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_order INT NOT NULL CONSTRAINT fk_order_id FOREIGN KEY REFERENCES tbl_order(order_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_habitat INT NOT NULL CONSTRAINT fk_habitat_id FOREIGN KEY REFERENCES tbl_habitat(habitat_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_nutrition INT NOT NULL CONSTRAINT fk_nutrition_id FOREIGN KEY REFERENCES tbl_nutrition(nutrition_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_care VARCHAR(50) NOT NULL CONSTRAINT fk_care_id FOREIGN KEY REFERENCES tbl_care(care_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO tbl_species
(species_name, species_animalia, species_class, species_order, species_habitat, species_nutrition, species_care)
VALUES
('brown bear', 1, 102, 3, 5007, 2200, 'care_1'),
('jaguar', 1, 102, 1, 5007, 2200, 'care_4'),
('penguin', 1, 100, 1, 5003, 2200, 'care_6'),
('ghost bat', 1, 102, 1, 5007, 2204, 'care_2'),
('chicken', 1, 100, 3, 5001, 2205, 'care_0'),
('panda', 1, 102, 3, 5006, 2202, 'care_4'),
('bobcat', 1, 102, 1, 5001, 2204, 'care_5'),
('grey wolf', 1, 102, 1, 5000, 2201, 'care_4');

select * from tbl_species;

SELECT
    a1.species_name,
    a2.animalia_type,
    a3.class_type,
    a4.order_type,
    a5.habitat_type,
    a6.nutrition_type,
    a7.care_type
FROM tbl_species a1
INNER JOIN tbl_animalia a2 ON a2.animalia_id = a1.species_animalia
INNER JOIN tbl_class a3 ON a3.class_id = a1.species_class
INNER JOIN tbl_order a4 ON a4.order_id = a1.species_order
INNER JOIN tbl_habitat a5 ON a5.habitat_id = a1.species_habitat
INNER JOIN tbl_nutrition a6 ON a6.nutrition_id = a1.species_nutrition
INNER JOIN tbl_care a7 ON a7.care_id = a1.species_care
WHERE a1.species_name = 'penguin';

SELECT 
a1.species_name, a2.habitat_type, a2.habitat_cost, a3.nutrition_type, a3.nutrition_cost 
FROM tbl_species a1
INNER JOIN tbl_habitat a2 ON a2.habitat_id = a1.species_habitat
INNER JOIN tbl_nutrition a3 ON a3.nutrition_id = a1.species_nutrition
WHERE species_name = 'grey wolf'
;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'VIEW';

use db_zoo;

drop table tbl_species;

CREATE TABLE tbl_species (
    species_id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
    species_name VARCHAR(50) NOT NULL,
    species_animalia INT NOT NULL CONSTRAINT fk_animalia_id FOREIGN KEY REFERENCES tbl_animalia(animalia_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_class INT NOT NULL CONSTRAINT fk_class_id FOREIGN KEY REFERENCES tbl_class(class_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_order INT NOT NULL CONSTRAINT fk_order_id FOREIGN KEY REFERENCES tbl_order(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_habitat INT NOT NULL CONSTRAINT fk_habitat_id FOREIGN KEY REFERENCES tbl_habitat(habitat_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_nutrition INT NOT NULL CONSTRAINT fk_nutrition_id FOREIGN KEY REFERENCES tbl_nutrition(nutrition_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_care VARCHAR(50) NOT NULL CONSTRAINT fk_care_id FOREIGN KEY REFERENCES tbl_care(care_id) ON UPDATE CASCADE ON DELETE CASCADE
);
--This will return information about all the indexes on the tbl_species table, including their type (primary key, unique, etc.)
EXEC sp_helpindex 'tbl_species';


INSERT INTO tbl_species
(species_name, species_animalia, species_class, species_order, species_habitat, species_nutrition, species_care)
VALUES
('brown bear', 1, 102, 3, 5007, 2200, 'care_1'),
('jaguar', 1, 102, 1, 5007, 2200, 'care_4'),
('penguin', 1, 100, 1, 5003, 2200, 'care_6'),
('ghost bat', 1, 102, 1, 5007, 2204, 'care_2'),
('chicken', 1, 100, 3, 5001, 2205, 'care_0'),
('panda', 1, 102, 3, 5006, 2202, 'care_4'),
('bobcat', 1, 102, 1, 5001, 2204, 'care_5'),
('grey wolf', 1, 102, 1, 5000, 2201, 'care_4');

select * from tbl_species;

create table tbl_lead (
	lead_id int primary key not null identity(1,1),
	lead_petname varchar(50) not null,
	lead_vetname int not null constraint fk_specialist_id foreign key references tbl_specialist(specialist_id) on update cascade on delete cascade,
	lead_habitat int not null constraint fk_habitat_id_ foreign key references tbl_habitat(habitat_id) on update cascade on delete cascade,
	lead_species int not null constraint fk_species_id foreign key references tbl_species(species_id)
);

select * from tbl_lead;

insert into tbl_lead
(lead_petname, lead_vetname, lead_habitat, lead_species)
VALUES
('bobby', 2, 5001, 1),
('alex', 3, 5002, 2),
('gloria', 4, 5003, 3),
('julian', 5, 5004, 4),
('duo', 1, 5005, 5)
;

insert into tbl_lead
(lead_petname, lead_vetname, lead_habitat, lead_species)
VALUES
('coby', 5, 5000, 6),
('smalec', 1, 5006, 7),
('ana', 2, 5007, 8)
;

select * from tbl_lead;

truncate table tbl_lead;

insert into tbl_lead
(lead_petname, lead_vetname, lead_habitat, lead_species)
VALUES
('bobby', 2, 5001, 1),
('alex', 3, 5002, 2),
('gloria', 4, 5003, 3),
('julian', 5, 5004, 4),
('duo', 1, 5005, 5),
('coby', 5, 5000, 1),
('smalec', 1, 5006, 2),
('ana', 2, 5007, 3)
;

select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
full outer join
tbl_species a2 
on a1.lead_id = a2.species_id
full outer join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
full outer join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;


select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
inner join
tbl_species a2 
on a1.lead_id = a2.species_id
inner join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
inner join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;

select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
left join
tbl_species a2 
on a1.lead_id = a2.species_id
left join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
left join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;



---------------------------------------------------------------------
DROP TABLE IF EXISTS tbl_species, tbl_animalia, tbl_care, tbl_class, tbl_habitat, tbl_nutrition, tbl_order, tbl_specialist;

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES tbl_species)
DROP TABLE IF EXISTS tbl_species, tbl_animalia, tbl_care, tbl_class, tbl_habitat, tbl_nutrition, tbl_order, tbl_specialist;
---------------------------------------------------------------------

--STORED PROCEDURE



CREATE DATABASE db_zooTest3;

USE db_zooTest3;

CREATE TABLE tbl_animalia (
    animalia_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    animalia_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_animalia (animalia_type)
VALUES
    ('vertebrate'),
    ('invertebrate')
;

SELECT * FROM tbl_animalia;

CREATE TABLE tbl_class (
    class_id INT PRIMARY KEY NOT NULL IDENTITY(100,1),
    class_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_class (class_type)
VALUES
    ('bird'),
    ('reptilian'),
    ('mammal'),
    ('arthropod'),
    ('fish'),
    ('worm'),
    ('cnidaria'),
    ('echinoderm');

SELECT * FROM tbl_class;

CREATE TABLE tbl_order (
    order_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    order_type VARCHAR(50) NOT NULL
);

select * from tbl_order;

CREATE TABLE tbl_care (
    care_id VARCHAR(50) PRIMARY KEY NOT NULL,
    care_type VARCHAR(50) NOT NULL,
    care_specialist INT NOT NULL
);

select * from tbl_care;

CREATE TABLE tbl_nutrition (
    nutrition_id INT PRIMARY KEY NOT NULL IDENTITY(2200,1),
    nutrition_type VARCHAR(50) NOT NULL,
    nutrition_cost MONEY NOT NULL
);

select * from tbl_nutrition;

CREATE TABLE tbl_habitat (
   habitat_id INT PRIMARY KEY NOT NULL IDENTITY(5000,1),
   habitat_type VARCHAR(50) NOT NULL,
   habitat_cost MONEY NOT NULL
);

select * from tbl_habitat;

CREATE TABLE tbl_specialist (
    specialist_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    specialist_fname VARCHAR(50) NOT NULL,
    specialist_lname VARCHAR(50) NOT NULL,
    specialist_contact VARCHAR(50) NOT NULL
);

select * from tbl_specialist;

INSERT INTO tbl_order (order_type) 
VALUES ('carnivore'),
		('herbivore'),
		('omnivore');

SELECT * FROM tbl_order;

INSERT INTO tbl_care (care_id, care_type, care_specialist)
VALUES
('care_0', 'replace the straw', 1),
('care_1', 'repair or replace broken toys', 4),
('care_2', 'bottle feed vitamins', 1),
('care_3', 'human contact_pet subject', 2),
('care_4', 'clean up animal waste', 1),
('care_5', 'move subject to exercise pen', 3),
('care_6', 'drain and refill aquarium', 1),
('care_7', 'extensive dental work', 3);

SELECT * FROM tbl_care;

INSERT INTO tbl_nutrition
(nutrition_type, nutrition_cost)
VALUES
('raw fish', 1500),
('living rodents', 600),
('mixture of fruit and rice', 800),
('warm bottle of milk', 600),
('syringe fed broth', 600),
('lard and seed mix', 300),
('aphids', 150),
('vitamins and marrow', 3500);

SELECT * FROM tbl_nutrition;

INSERT INTO tbl_habitat (habitat_type, habitat_cost)
VALUES ('tundra', 40000),
       ('grassy knoll with trees', 12000),
       ('10 ft pond and rocks ', 30000),
       ('icy aquarium with snowy facade', 50000),
       ('short grass, shade and moat', 50000),
       ('netted forest atrium ', 10000),
       ('jungle vines and winding branches', 15000),
       ('cliff with shaded cave', 15000);

SELECT * FROM tbl_habitat;

INSERT INTO tbl_specialist
(specialist_fname, specialist_lname, specialist_contact)
VALUES
('margaret', 'nguyen', '384-576-2899'),
('mary', 'fischer', '384-784-4856'),
('arnold', 'holden', '385-475-3944'),
('kai', 'byzant', '384-485-4855'),
('delmonte', 'fyedo', '768-288-3749');

SELECT * FROM tbl_specialist;

CREATE TABLE tbl_species (
    species_id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
    species_name VARCHAR(50) NOT NULL,
    species_animalia INT NOT NULL CONSTRAINT fk_animalia_id FOREIGN KEY REFERENCES tbl_animalia(animalia_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_class INT NOT NULL CONSTRAINT fk_class_id FOREIGN KEY REFERENCES tbl_class(class_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_order INT NOT NULL CONSTRAINT fk_order_id FOREIGN KEY REFERENCES tbl_order(order_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_habitat INT NOT NULL CONSTRAINT fk_habitat_id FOREIGN KEY REFERENCES tbl_habitat(habitat_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_nutrition INT NOT NULL CONSTRAINT fk_nutrition_id FOREIGN KEY REFERENCES tbl_nutrition(nutrition_id) ON UPDATE CASCADE ON DELETE CASCADE,

    species_care VARCHAR(50) NOT NULL CONSTRAINT fk_care_id FOREIGN KEY REFERENCES tbl_care(care_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO tbl_species
(species_name, species_animalia, species_class, species_order, species_habitat, species_nutrition, species_care)
VALUES
('brown bear', 1, 102, 3, 5007, 2200, 'care_1'),
('jaguar', 1, 102, 1, 5007, 2200, 'care_4'),
('penguin', 1, 100, 1, 5003, 2200, 'care_6'),
('ghost bat', 1, 102, 1, 5007, 2204, 'care_2'),
('chicken', 1, 100, 3, 5001, 2205, 'care_0'),
('panda', 1, 102, 3, 5006, 2202, 'care_4'),
('bobcat', 1, 102, 1, 5001, 2204, 'care_5'),
('grey wolf', 1, 102, 1, 5000, 2201, 'care_4');

select * from tbl_species;

SELECT
    a1.species_name,
    a2.animalia_type,
    a3.class_type,
    a4.order_type,
    a5.habitat_type,
    a6.nutrition_type,
    a7.care_type
FROM tbl_species a1
INNER JOIN tbl_animalia a2 ON a2.animalia_id = a1.species_animalia
INNER JOIN tbl_class a3 ON a3.class_id = a1.species_class
INNER JOIN tbl_order a4 ON a4.order_id = a1.species_order
INNER JOIN tbl_habitat a5 ON a5.habitat_id = a1.species_habitat
INNER JOIN tbl_nutrition a6 ON a6.nutrition_id = a1.species_nutrition
INNER JOIN tbl_care a7 ON a7.care_id = a1.species_care
WHERE a1.species_name = 'penguin';

SELECT 
a1.species_name, a2.habitat_type, a2.habitat_cost, a3.nutrition_type, a3.nutrition_cost 
FROM tbl_species a1
INNER JOIN tbl_habitat a2 ON a2.habitat_id = a1.species_habitat
INNER JOIN tbl_nutrition a3 ON a3.nutrition_id = a1.species_nutrition
WHERE species_name = 'grey wolf'
;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'VIEW';

--This will return information about all the indexes on the tbl_species table, including their type (primary key, unique, etc.)
EXEC sp_helpindex 'tbl_species';


create table tbl_lead (
	lead_id int primary key not null identity(1,1),
	lead_petname varchar(50) not null,
	lead_vetname int not null constraint fk_specialist_id foreign key references tbl_specialist(specialist_id) on update cascade on delete cascade,
	lead_habitat int not null constraint fk_habitat_id_ foreign key references tbl_habitat(habitat_id) on update cascade on delete cascade,
	lead_species int not null constraint fk_species_id foreign key references tbl_species(species_id)
);

insert into tbl_lead
(lead_petname, lead_vetname, lead_habitat, lead_species)
VALUES
('bobby', 2, 5001, 1),
('alex', 3, 5002, 2),
('gloria', 4, 5003, 3),
('julian', 5, 5004, 4),
('duo', 1, 5005, 5),
('coby', 5, 5000, 1),
('smalec', 1, 5006, 2),
('ana', 2, 5007, 3)
;

select * from tbl_lead;

select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
full outer join
tbl_species a2 
on a1.lead_id = a2.species_id
full outer join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
full outer join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;


select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
inner join
tbl_species a2 
on a1.lead_id = a2.species_id
inner join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
inner join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;


select 
a1.lead_petname,
a2.species_name, a3.habitat_type, 
a4.specialist_fname + ' ' + specialist_lname AS vet_name
from
tbl_lead a1
left join
tbl_species a2 
on a1.lead_id = a2.species_id
left join
tbl_habitat a3 
on a1.lead_id = a3.habitat_id
left join
tbl_specialist a4 
on a1.lead_id = a4.specialist_id
;


