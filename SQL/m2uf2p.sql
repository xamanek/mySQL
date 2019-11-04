DROP TABLE if EXISTS articulos;
DROP TABLE fabricantes;


CREATE TABLE fabricantes (
	id int(10),
	nombre varchar(250),
    PRIMARY KEY(id)
);

create table articulos (
	id int(11),
	nombre varchar(250),
	precio decimal(10,2),
	id_fabricante int(10),
	oferta tinyint(1),
	primary key(id)
);

ALTER TABLE articulos
ADD FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id);

INSERT INTO fabricantes
(id, nombre)
VALUE
(1, 'Kingston'),
(2, 'Adata'),
(3, 'Logitech'),
(4, 'Lexar'),
(5, 'Seagate');

INSERT into articulos
(id, nombre, precio, id_fabricante, oferta)
value
(1, 'Teclado', 100, 3, 0),
(2, 'Disco duro 300 gb', 500, 5, 0),
(3, 'Mouse', 80, 3, 0),
(4, 'Memoria USB', 140, 4, 0),
(5, 'Memoria RAM', 290, 1, 0),
(6, 'Disco duro extraibile 250 gb', 650, 5, 0),
(7, 'Memoria USB', 279, 1, 0),
(8, 'DVD Rom', 450, 2, 0),
(9, 'CD Rom', 200, 2, 0),
(10, 'Tarjeta de Red', 180, 3, 0);

/* 4.1. Obtener un listado con los nombres de los artículos */

select nombre
from articulos;

/* 4.2. Obtener los nombres y los precios de los artículos */

select nombre, precio
from articulos;

/* 4.3. Obtener los nombres de los productos cuyo precio sea menor o igual a 200 € */

select nombre, precio
from articulos
where precio <= 200;

/* 4.4. Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los 120€ */

select *
from articulos
where precio >= 60
and precio <= 120;

/* 4.5. Obtener los artículos que contengan la palabra Rom. */

select *
from articulos
where nombre like '%rom%';

/* 4.6. Obtener un listado de los artículos que empiezan con “M” */

select *
from articulos
where nombre like 'm%';

/* 4.7. Seleccionar el precio medio de todos los productos. */

select avg(precio) as 'Precio Medio'
from articulos;

/* 4.8. Obtener el precio medio de los artículos cuyo código de fabricante sea 2 */

select avg(precio) as 'Precio Medio fabricante 2'	
from articulos
where id_fabricante = 2;

/* 4.9. Obtener el número de artículos cuyo precio sea mayor o igual a 180 € */

select count(id) as 'n. articulos cuyo precio es mayor o igual a 180 €'
from articulos
where precio >= 180;

/* 4.10.Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180€ y ordenarlos
descendentemente por precio y luego ascendentemente por nombre */

select nombre, precio
from articulos
where precio >= 180
order by precio desc, nombre;

/* 4.11.Obtener un listado del nombre del artículo, su precio y el nombre de su fabricante. */

select articulos.nombre, articulos.precio, fabricantes.nombre as 'Fabricante'
from articulos
	join fabricantes on articulos.id_fabricante = fabricantes.id;


/* 4.12.Obtener el precio medio de los productos de cada fabricante mostrando el nombre del fabricante y el valor
del precio medio de los productos */

select fabricantes.nombre, avg(articulos.precio)  as 'Precio_medio_articulos'
from fabricantes
	join articulos on articulos.id_fabricante = fabricantes.id
group by fabricantes.nombre;


/* 4.13.Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150 € */

select fabricantes.nombre, avg(articulos.precio) as 'Precio_medio_articulos'
from fabricantes
	join articulos on articulos.id_fabricante = fabricantes.id
group by fabricantes.nombre
having avg(articulos.precio) >= 150;

/* 4.14.Obtener el nombre y el precio del artículo más barato */

select nombre, precio
from articulos
where precio in
	(select min(precio) from articulos);
	
/* 4.15.Obtener un listado con el nombre del proveedor, el número de artículos que tiene, el precio más bajo de sus
artículos y el precio más alto de sus artículos. */

select fabricantes.nombre as 'Fabricante',
		count(articulos.id) as 'N. articulos',
		min(articulos.precio) as 'Precio mas bajo de sus articulos',
		max(articulos.precio) as 'Precio mas alto de sus articulos'
from fabricantes
	join articulos on articulos.id_fabricante = fabricantes.id
group by fabricantes.nombre;

/* 4.16.Obtener un listado con el nombre del producto y el número de fabricantes diferentes, filtrar la select para que
solo aparezcan aquellos productos que con el mismo nombre tienen más de 1 fabricante diferente. */

select nombre, count(id_fabricante) as 'n. de fabricante que lo producen'
from articulos
group by nombre
having count(id_fabricante) > 1;

/* 4.17.Añadir por SQL un nuevo producto: Altavoces de 70€ del fabricante 2 y que no está en oferta */

select @idart int;
select  max(id)+1 into @idart
from articulos;


INSERT INTO articulos
(id, nombre, precio, id_fabricante, oferta)
VALUE
(max(id)+1, 'Altavoces', 70, 2, 0);

CREATE PROCEDURE AddArticulo(IN NombreArt VARCHAR(250),
								precioart decimal(10,2),
								idfabr int(10),
								ofer tinyint(1))
BEGIN

declare idart int;
select  max(id)+1 into idart
from articulos;

INSERT INTO articulos
(id, nombre, precio, id_fabricante, oferta)
VALUES
(idart, NombreArt, precioart, idfabr, ofer);


END













