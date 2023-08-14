/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

vet_clinic=# INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
vet_clinic-# VALUES ('Agumon', TO_DATE('Feb 3, 2020', 'Mon DD, YYYY'), 0, true, 10.23),
vet_clinic-# ('Gabumon', TO_DATE('Nov 15, 2018', 'Mon DD, YYYY'), 2, true, 8),
vet_clinic-# ('Pikachu', TO_DATE('Jan 7, 2021', 'Mon DD, YYYY'), 1, false, 12.04),
vet_clinic-# ('Devimon', TO_DATE('May 12, 2017', 'Mon DD, YYYY'), 5, true, 11);
INSERT 0 4