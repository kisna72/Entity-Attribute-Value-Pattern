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
    entity_type_pk integer REFERENCES entity_type (id) ON DELETE CASCADE ON UPDATE CASCADE,
    label text NOT NULL
);
-- Add  Values to the Table for testing
INSERT INTO entity (entity_type_pk, label) VALUES (2, 'Iphone  Camera Design Project');
INSERT INTO entity (entity_type_pk, label) VALUES (2, 'MacBok Costdown Project');
-- Print
SELECT * FROM entity;

-- Create  Table to add the attribute for each entity type.
DROP TABLE IF EXISTS attribute CASCADE;
CREATE TABLE attribute 
(
    id SERIAL PRIMARY KEY,
    entity_type INTEGER REFERENCES entity_type (id) on DELETE CASCADE On UPDATE  CASCADE,
    name TEXT NOT NULL
);
-- Simulating User adding columns to their tables. (lets say for project table)
INSERT INTO  attribute (entity_type, name) VALUES (2, 'Project Engineer');
INSERT INTO  attribute (entity_type, name) VALUES (2, 'Project Manager' );

select * from attribute;

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
