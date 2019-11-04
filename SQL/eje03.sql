/* https://docplayer.es/58078752-Sql-facil-pere-chardi-garcia.html*/

/*Borrar tablas */
DROP TABLE articulos;
DROP TABLE fabricantes;

/* Crear Tablas */
CREATE TABLE fabricantes (
	codigo int AUTO_INCREMENT,
	nombre varchar(100) NOT NULL,
	PRIMARY KEY (codigo)
);
CREATE TABLE articulos (
	codigo int AUTO_INCREMENT,
	nombre varchar(100) NOT NULL,
	precio decimal(10,2) DEFAULT 0,
	fabricante int,
	PRIMARY KEY (codigo),
	FOREIGN KEY (fabricante) REFERENCES fabricantes(codigo)
);

/* Insertar Datos */

INSERT INTO fabricantes
(nombre)
VALUE
('IKEA'),
('ACME'),
('FAB01'),
('PILMA'),
('VIÇON'),
('KIBUK');

INSERT INTO articulos
(nombre, precio, fabricante)
VALUE
('mesa', 50, 1),
('silla', 350, 5),
('jaulero', 60, 2),
('sofa', 900.50, 6);



ALTER TABLE fabricantes
ADD pedido_min DECIMAL(10,2) DEFAULT 0;

ALTER TABLE fabricantes
ADD columna1 INTEGER;

ALTER TABLE fabricantes
MODIFY COLUMN columna1 DECIMAL(10,2) NOT NULL DEFAULT 0;

ALTER TABLE fabricantes
DROP COLUMN columna1;

UPDATE articulos
SET nombre = 'sillon'
WHERE codigo = 2;

UPDATE articulos
SET precio = precio * 1.05;

DELETE FROM articulos
WHERE codigo = 2;

/*
DELETE FROM fabricantes
WHERE codigo = 3;
*/

UPDATE articulos
SET nombre = UCASE(nombre);

/* Añadir a la tabla articulos 2 columnas nuevas:
- IVA al 21% del valor del precio
- PVP que tendrá el precio + IVA*/

ALTER TABLE articulos
ADD IVA DECIMAL(10,2) DEFAULT 0;

UPDATE articulos
SET IVA = precio * 0.21;

ALTER TABLE articulos
ADD PVP DECIMAL(10,2);

UPDATE articulos
SET PVP = precio + IVA;













