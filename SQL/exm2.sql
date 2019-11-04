/* cancellare tutto per poter importare tutto*/
DROP TABLE if EXISTS personajes;
DROP TABLE universos;



/* 2. creare la structura de la tablas*/
CREATE TABLE universos (
	id int(11) AUTO_INCREMENT,
	universo varchar(100),
	editorial varchar(100),
	PRIMARY KEY (id)
);

CREATE TABLE personajes (
	id int(11) AUTO_INCREMENT,
	personaje varchar(200),
	id_universo int(11),
	nombre varchar(200),
	PRIMARY KEY (id),
	FOREIGN KEY (id_universo) REFERENCES universos(id)
);

/* 3. insertar valores en las tablas*/

INSERT INTO universos
(universo, editorial)
VALUE
('Marvel', 'Panini'),
('DC Comics', 'ECC');

INSERT INTO personajes
(personaje, id_universo, nombre)
VALUE
('Batman', 2, 'Bruce Wayne'),
('Acquaman', 2, 'Arthur Curry'),
('Cyborg', 2, 'Victor Stone'),
('Superman', 2, 'Clark Kent'),
('Wonder Woman', 2, 'Diana'),
('Capitan América', 1, 'Steven Grant Rogers'),
('Iron Man', 1, 'Tony Stark'),
('Spiderman', 1, 'Peter Parker'),
('Thor', 1,' '),
('Viuda Negra', 1, 'Natasha Romanoff');


/* ACT. 2

2. sentencias que muestre dato de tabla personajes y universos*/

select *
from universos
	join personajes on personajes.id_universo = universos.id;


























