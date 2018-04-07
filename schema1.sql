-- Create  Entity Type  Table.
-- Used to create New Custom  Table essentially.
DROP TABLE IF EXISTS entity_type CASCADE;
CREATE TABLE entity_type
( id SERIAL PRIMARY KEY,
  name text NOT NULL,
);

DROP TABLE IF EXISTS entity CASCADE;
CREATE TABLE entity
(
    id SERIAL PRIMARY KEY,
    constraint entity_type_pk PRIMARY KEY (entity_type),
);

DROP TABLE IF EXISTS attribute CASCADE;
CREATE TABLE attribute 
(
    id SERIAL PRIMARY KEY,
    label TEXT NOT NULL,
);

DROP TABLE IF EXISTS attribute_value CASCADE;
CREATE TABLE attribute_value
(
    id SERIAL PRIMARY KEY,
    CONSTRAINT attribute_id PRIMARY KEY (attribute),
    CONSTRAINT entity_id PRIMARY KEY (entity),
    value TEXT NULL
);
