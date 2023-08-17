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

* Insert data in owners table:
vet_clinic=# INSERT INTO owners(full_name, age)
vet_clinic-# VALUES('Sam Smith', 34),
vet_clinic-# ('Jennifer Orwell', 19),
vet_clinic-# ('Bob', 45),
vet_clinic-# ('Melody Pond', 77),
vet_clinic-# ('Dean Winchester', 14),
vet_clinic-# ('Jodie Whittaker', 38);
INSERT 0 6

* Insert data in species table:
vet_clinic=# INSERT INTO species(name)
vet_clinic-# VALUES('Pokemon'),
vet_clinic-# ('Digimon');
INSERT 0 2

* Modify your inserted animals so it includes the species_id:
vet_clinic=# UPDATE animals
vet_clinic-# SET species_id = CASE
vet_clinic-# WHEN name LIKE '%mon' THEN 2
vet_clinic-# ELSE 1
vet_clinic-# END;

* Modify your inserted animals to include owner information (owner_id):
vet_clinic=# UPDATE animals
vet_clinic-# SET owner_id = CASE
vet_clinic-# WHEN name = 'Agumon' THEN 1
vet_clinic-# WHEN name = 'Gabumon' OR name = 'Pikachu' THEN 2
vet_clinic-# WHEN name = 'Devimon' OR name = 'Plantmon' THEN 3
vet_clinic-# WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN 4
vet_clinic-# WHEN name = 'Angemon' OR name = 'Boarmon' THEN 5
vet_clinic-# END;

* Insert data in vets:
vet_clinic=# INSERT INTO vets(name, age, date_of_graduation)
vet_clinic-# VALUES('William Tatcher', 45, TO_DATE('Apr 23, 2000', 'Mon DD YYYY')),
vet_clinic-# ('Maisy Smith', 26, TO_DATE('Jan 17, 2019', 'Mon DD YYYY')),
vet_clinic-# ('Stephanie Mendez', 64, TO_DATE('May 4, 1981', 'Mon DD YYYY')),
vet_clinic-# ('Jack Harkness', 38, TO_DATE('Jun 8, 2008', 'Mon DD YYYY'));
INSERT 0 4

* Insert data in specializations:
vet_clinic=# INSERT INTO specializations(species_id, vets_id)
vet_clinic-# VALUES(1, 1),
vet_clinic-# (1, 3), (2, 3),
vet_clinic-# (2, 4);
INSERT 0 4