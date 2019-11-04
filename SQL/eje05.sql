/* cancellare tutto per poter importare */
DROP TABLE if EXISTS cajas;
DROP TABLE almacenes;


CREATE TABLE almacenes (
	id int(11) not null AUTO_INCREMENT,
	Lugar varchar(100),
	capacidad int(11),
    PRIMARY KEY(id)
);

CREATE TABLE cajas (
	id int(11) not null AUTO_INCREMENT,
	referencia varchar(10),
	contenido varchar(100),
	valor decimal(10,2),
    id_almacen int(11),
	primary key(id)
);

/* Se la tabla esiste e vogliamo aggiungere la FOREIGN KEY*/

ALTER TABLE cajas
ADD FOREIGN KEY (id_almacen) REFERENCES almacenes(id);

/* inserire dati nelle tablas*/
INSERT INTO almacenes
(lugar, capacidad)
VALUE
('Barcelona', 1000),
('Madrid', 1500),
('Bilbao', 900);

INSERT INTO cajas
(referencia, contenido, valor, id_almacen)
VALUE
('H3BT', 'Boligrafos', 50, 1),
('H3MT','Carpetas', 120, 2),
('H5BL','Grapas', 200, 3),
('C6BR','Folios con logo corporativo', 600, 1),
('C1MH','Sobres con ventana', 150, 2),
('L8BL','Sellos de goma', 560, 3),
('Y4BT','Libretas A4', 800, 1),
('F3M4','Lápices y gomas de borrar', 230, 2);

/*1. Mostrar todos los almacenes.*/

SELECT *
FROM almacenes

/*2. Mostrar el almacén con mayor capacidad*/
/*opt1*/
SELECT lugar, capacidad
FROM almacenes
ORDER BY capacidad desc
limit 1

/*opt2 la migliore*/
SELECT *
FROM almacenes
WHERE capacidad = (select max(capacidad) from almacenes)


/* 3. Mostrar el promedio de capacidad de todos los almacenes*/
SELECT avg(capacidad)
FROM almacenes

/* 4. Mostrar la capacidad total de todos los almacenes*/
SELECT SUM(capacidad)
FROM almacenes

/* 5. Mostrar todos los almacenes ordenados por capacidad de mayor a menor*/
SELECT *
FROM almacenes
ORDER BY capacidad desc

/* 6. Mostrar los almacenes que contienen la letra “i” ordenados por orden alfabético de
nombre de lugar*/
SELECT *
from almacenes
where lugar like '%i%'
order by lugar

/* 7. Sabiendo que un palé tiene una capacidad de 4 mq, mostrar todos los almacenes con la
siguiente información: lugar, capacidad, nº de palés*/
select lugar, capacidad, capacidad/4 as 'Nº de palès'
from almacenes

/* 8. Mostrar el número total de almacenes que hay, el mínimo de capacidad, el máximo de
capacidad y el mínimo de palés y el máximo de pales que cabrían.*/
select count(id),
	   min(capacidad),
	   max(capacidad),
	   min(capacidad)/4 as 'Minimo de pales',
	   max(capacidad)/4 as 'Maximo de pales'
from almacenes

/* 9. Mostrar una sola columna donde aparezca solo una columna que ponga por cada
almacén: “El almacén con código ____ está locacalizado en _____ y tiene una
capacidad de ____ m2. En él caben alrededor de ____ palés”. Utilizad la función
CONCAT*/

select CONCAT('El almacén con código ', id, ' está locacalizado en ', lugar, ' y tiene una
capacidad de ', capacidad, ' m2. En él caben alrededor de ',capacidad/4, ' palés.')
from almacenes

select CONCAT_WS(' ','El almacén con código', id, 'está locacalizado en', lugar, 'y tiene una
capacidad de', capacidad, 'm2. En él caben alrededor de',capacidad/4, 'palés.')
from almacenes


/* 10. Mostrar todos los almacenes y añadir una columna más donde se especifique el idioma
en el que se ha enviar la documentación, sabiendo que en Barcelona es Catalán, Bilbao
es Vasco y Madrid es Castellano. Utilizad la función CASE*/

select *, case
			when lugar = 'Barcelona' then 'Catalán'
			when lugar = 'Bilbao' then 'Vasco'
			when lugar = 'Madrid' then 'Castellano'
		end as 'Idioma'
from almacenes 

/* 11. Mostrar todas las cajas cuyo contenido tenga un valor superior a 250 €.*/

select *
from cajas
where valor > 250

/* 12. Mostrar los tipos de contenidos de las cajas ordenados alfabéticamente.*/
select contenido
from cajas
order by contenido

/* 13. Mostrar el valor medio de todas las cajas*/
select avg(valor)
from cajas

/* 14. Mostrar todas las cajas con el lugar del almacén al que pertenece ordenadas por
almacén y valor

ACCION		select
Campo		cajas.*, almacenes.lugar
tablas		cajas, almacenes .... join 	-- cajas.id_almacen
										-- almacenes.id

filtro		xxx
agrupacion	xxx
order		lugar, valor

*/

select cajas.*, almacenes.lugar
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
order by almacenes.lugar, cajas.valor

/* 15. Mostrar el número de cajas y el valor medio de las cajas de cada almacén*/

select almacenes.lugar, count(cajas.id), avg(cajas.valor)
from almacenes
	join cajas on cajas.id_almacen = almacenes.id
group by almacenes.lugar

/* 16. Mostrar los almacenes en los cuales el valor medio de las cajas sea superior a 200.*/
select almacenes.lugar, avg(cajas.valor)
from almacenes
	join cajas on cajas.id_almacen = almacenes.id
group by almacenes.lugar
having avg(cajas.valor)>200

select almacenes.lugar, avg(cajas.valor)
from almacenes
	join cajas on cajas.id_almacen = almacenes.id
where cajas.valor = (select avg(cajas.valor) <200)
group by almacenes.lugar
avg(cajas.valor)>200


/* 17. Mostrar la referencia de cada caja junto con el nombre de la ciudad en el que se
encuentra ordenadas por valor
*/
select cajas.referencia, almacenes.lugar
from cajas
	join alamcenes on cajas.id_almacen = alamcenes.id
order by cajas.valor

/* 18. Mostrar cada almacén y el valor acumulado de todas las cajas que se encuentran en él.
*/
select almacenes.lugar, sum(cajas.valor)
from almacenes
	join cajas on cajas.id_almacen = almacenes.id
group by almacenes.lugar

/* 19. Mostrar las referencias de las cajas que están en Bilbao.*/

select cajas.referencia
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
where almacenes.lugar = 'Bilbao'


/* 20. Rebajar el valor de todas las cajas un 15% (accion=UPDATE).*/

update cajas
set valor=valor*0.85

/* 21. Rebajar un 20 % el valor de todas las cajas cuyo valor sea superior al valor medio de
todas las cajas. !!!!! en phpMyAdmin non funziona peró in ORACLE si*/

set @valormedio = 287;
/*select avg(valor) into @valormedio
from cajas;

select @valormedio = avg(valor)
from cajas;*/

update cajas
set valor=valor*0.80
where valor > @valormedio;
 

/* 22. Insertar un nuevo almacén de Sevilla con una capacidad de 300*/

INSERT INTO almacenes
(lugar, capacidad)
VALUE
('Sevilla', 300)

/* 23. Mostrar todos los almacenes y las referencias de las cajas (tiene que aparecer también el
de Sevilla) ordenados por almacén.*/

select almacenes.*, cajas.referencia
from almacenes
	left join cajas on cajas.id_almacen = almacenes.id
group by almacenes.lugar

/*24. Mostrar todos los almacenes y el número de cajas que tiene cada uno de ellos. (Incluído
el de Sevilla)*/
select *, count(cajas.id)
from almacenes
	left join cajas on cajas.id_almacen = almacenes.id
group by almacenes.lugar

/* 25. Eliminar todas las cajas cuyo valor sea inferior a 150 €*/

delete from cajas
where valor < 150;

/* 26. Trasladar las cajas de valor mayor a 500€ al almacén de Sevilla.*/

update cajas
set id_almacen = 4
where valor > 500;


/* 27. Añadir una nueva columna (n_pales) a la tabla CAJAS que corresponderá a las cantidad
de cajas que caben en un palé. */

alter table cajas
add n_pales int(11);


/* 28. fatto direttamente da myphpadmin*/

/* 29. Calcular cuanto valor tendría cada almacén si se llenara con cada tipo de caja.*/

select 	lugar,
		referencia,
		capacidad,
		capacidad/4 as pales,
		capacidad/4*n_pales*valor as 'Valor lleno'
from v_cajas_almacenes
order by lugar
/* order by 5 desc*/


/* 30. Vaciar el almacén de Barcelona*/

update cajas
set id_almacen = null
where id_almacen = 1; 

/*______________________________________________________*/

create or replace view v_cajas_almacenes as
(select cajas.*,
		almacenes.lugar,
		almacenes.capacidad
from cajas
	join almacenes on cajas.id_almacen = almacenes.id)
	
	
/* por cada almacen che se vea el numero de cajas y la suma del valor de las cajas*/

select lugar, count(id), sum(valor)
from v_cajas_almacenes
group by lugar
	
/* creare una vista con quello sopra*/

create or replace view v_estadisticas_ almacen as
(select lugar,
		count(id) as n_cajas,
		sum(valor) as sum_valor
from v_cajas_almacenes
group by lugar);
	

/* crear una vista por cada lugar donde aparesca los datos de cajas y almacenes*/

create or replace view v_cajas_barcelona as
(select cajas.*,
		almacenes.lugar,
		almacenes.capacidad
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
where almacenes.id = 1);

create or replace view v_cajas_madrid as
(select cajas.*,
		almacenes.lugar,
		almacenes.capacidad
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
where almacenes.id = 2);

create or replace view v_cajas_bilbao as
(select cajas.*,
		almacenes.lugar,
		almacenes.capacidad
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
where almacenes.id = 3);

create or replace view v_cajas_sevilla as
(select cajas.*,
		almacenes.lugar,
		almacenes.capacidad
from cajas
	join almacenes on cajas.id_almacen = almacenes.id
where almacenes.id = 4);




