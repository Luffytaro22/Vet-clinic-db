/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

vet_clinic=# SELECT * FROM animals WHERE name LIKE '%mon';
vet_clinic=# SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
vet_clinic=# SELECT name fROM animals WHERE neutered = true AND escape_attempts < 3;
vet_clinic=# SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
vet_clinic=# SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
vet_clinic=# SELECT * FROM animals WHERE neutered = true;
vet_clinic=# SELECT * FROM animals WHERE NOT name = 'Gabumon';
vet_clinic=# SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

* Update species column with unspecified and roll back to the previous state:
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals
vet_clinic-*# SET species = 'unspecified';
UPDATE 11
vet_clinic=*# ROLLBACK;
ROLLBACK