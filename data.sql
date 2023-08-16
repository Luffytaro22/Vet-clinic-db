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

vet_clinic=# INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
vet_clinic-# VALUES ('Charmander', TO_DATE('Feb 8, 2020', 'Mon DD YYYY'), 0, false, -11, 'Animal'),
vet_clinic-# ('Plantmon', TO_DATE('Nov 15, 2021', 'Mon DD YYYY'), 2, true, -5.7, 'Animal'),
vet_clinic-# ('Squirtle', TO_DATE('Apr 2, 1993', 'Mon DD YYYY'), 3, false, -12.13, 'Animal'),
vet_clinic-# ('Angemon', TO_DATE('Jun 12, 2005', 'Mon DD YYYY'), 1, true, -45, 'Animal'),
vet_clinic-# ('Boarmon', TO_DATE('Jun 7, 2005', 'Mon DD YYYY'), 7, true, 20.4, 'Animal'),
vet_clinic-# ('Blossom', TO_DATE('Oct 13, 1998', 'Mon DD YYYY'), 3, true, 17, 'Animal'),
vet_clinic-# ('Dito', TO_DATE('May 14, 2022', 'Mon DD YYYY'), 4, true, 22, 'Animal');
INSERT 0 7
