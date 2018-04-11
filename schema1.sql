-- Create  Entity Type  Table.
-- Used to create New Custom  Table essentially.
-- Two Examples are  Project  and  product
DROP TABLE IF EXISTS entity_type CASCADE;
CREATE TABLE entity_type
( 
    id SERIAL PRIMARY KEY,
    name text NOT NULL
);
-- Add Values to the Table.
INSERT INTO entity_type (name) VALUES ( 'Product' );
INSERT INTO entity_type (name) VALUES ( 'Project' );
-- Get all  the added values for testing purpose
SELECT * FROM entity_type;

-- Add Rows here for the Entity Type that was created. 
-- Multiple Projects or multiple products. Makes the code generic.
DROP TABLE IF EXISTS entity CASCADE;
CREATE TABLE entity
(
    id SERIAL PRIMARY KEY,
    entity_type_id integer REFERENCES entity_type (id) ON DELETE CASCADE ON UPDATE CASCADE,
    label text NOT NULL
);
-- Add  Values to the Table for testing
INSERT INTO entity (entity_type_id, label) VALUES (2, 'Iphone  Camera Design Project');
INSERT INTO entity (entity_type_id, label) VALUES (2, 'MacBook Costdown Project');
-- Print
SELECT * FROM entity;


-- Create  Table to add the attribute for each entity type.
DROP TABLE IF EXISTS attribute CASCADE;
CREATE TABLE attribute 
(
    id SERIAL PRIMARY KEY,
    entity_type_id INTEGER REFERENCES entity_type (id) on DELETE CASCADE On UPDATE  CASCADE,
    name TEXT NOT NULL
);
-- Simulating User adding columns to their tables. (lets say for project table)
INSERT INTO  attribute (entity_type_id, name) VALUES (2, 'Project Engineer');
INSERT INTO  attribute (entity_type_id, name) VALUES (2, 'Project Manager' );

select * from attribute;
/*

*/

-- Create attribute_value table. attribute value is added for each.
DROP TABLE IF EXISTS attribute_value CASCADE;
CREATE TABLE attribute_value
(
    id SERIAL PRIMARY KEY,
    attribute_id INTEGER REFERENCES attribute (id) on DELETE CASCADE On UPDATE  CASCADE,
    entity_id INTEGER REFERENCES entity (id) on DELETE CASCADE On UPDATE  CASCADE,
    value TEXT NULL
);

INSERT INTO attribute_value (attribute_id, entity_id, value) VALUES (1,1,'John Smith');
INSERT INTO attribute_value (attribute_id, entity_id, value) VALUES (1,2,'Jacques Moser');
INSERT INTO attribute_value (attribute_id, entity_id, value) VALUES (2,1,'John Doe');


SELECT * FROM entity
LEFT JOIN attribute_value on entity.id = attribute_value.entity_id
LEFT JOIN attribute ON attribute_value.attribute_id = attribute.id
WHERE entity.entity_type_id = 2;
/*

Entity
+----+------------------------------+-------------+--+--+
| id | label                        | Entity Type |  |  |
+----+------------------------------+-------------+--+--+
| 1  | Iphone Camera Design project | 1 (project) |  |  |
+----+------------------------------+-------------+--+--+
| 2  | Mac book CostDown            | 1 (project) |  |  |
+----+------------------------------+-------------+--+--+
|  3 | Test                         | 1 (project) |  |  |
+----+------------------------------+-------------+--+--+


Attribute
+----+-------------+------------------+--+--+
| id | Entity Type | Name             |  |  |
+----+-------------+------------------+--+--+
| 1  | 1           | Project Engineer |  |  |
+----+-------------+------------------+--+--+
| 2  | 1           | Project  Manager |  |  |
+----+-------------+------------------+--+--+
| 3  | 1           | Project Cost     |  |  |
+----+-------------+------------------+--+--+


Attribute Value
+----+--------------+-----------+-------------+--+
| id | attribute id | entity id | value       |  |
+----+--------------+-----------+-------------+--+
| 1  | 2            | 1         | John Doe    |  |
+----+--------------+-----------+-------------+--+
| 2  | 2            | 1         | John Smith  |  |
+----+--------------+-----------+-------------+--+
| 3  | 2            | 1         | John Carry  |  |
+----+--------------+-----------+-------------+--+

First - pivot attribute.
We want:

id  Project Engineer    Project Manager   Project  Cost

Then,


We want to get...

+----+------------------------------+-------------+-------------------+------------------+---------------+
| id | label                        | entity type | Project Enginener | Project  Manager | Project Cost  |
+----+------------------------------+-------------+-------------------+------------------+---------------+
| 1  | Iphone Camera Design project | 1           | John Doe          | John Smith       | john Carry    |
+----+------------------------------+-------------+-------------------+------------------+---------------+
| 2  | Mac book CostDown            | 1           |                   |                  |
+----+------------------------------+-------------+-------------------+------------------+
| 3  | test                         | 1           |                   |                  |
+----+------------------------------+-------------+-------------------+------------------+

*/


-- How to  make queries? 
-- 1. Filter entity by the entity type you want. 
-- 2. Get attributes from this entity type. and turn them into columns.
-- 3. For each column, get the value from the Values table, and use that to fill  in for each row.
