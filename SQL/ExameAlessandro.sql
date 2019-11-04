/* 1 */

select genero, descripcion
from generos;

/* 2 */

select *
from autores;

/* 3 */

select *
from autores
where apellidos != '';

/* 4 */

select sexo
from autores
group by sexo;

/* 5 */

select count(id) as 'Numero total de colecciones'
from colecciones;

/* 6 */

select count(id) as 'Numero de colecciones que empiecen con N'
from colecciones
where nombre like 'N%';

/* 7 */

select colecciones.nombre, generos.genero
from colecciones
	join generos on colecciones.id_genero=generos.id
where colecciones.nombre like 'Z%';

/* 8 */

select colecciones.nombre, generos.genero, colecciones.n_tomos
from colecciones
	join generos on colecciones.id_genero=generos.id
where colecciones.n_tomos >=20
	and colecciones.n_tomos <= 30;

/* 9 */

select 	max(pvp) as 'Precio más alto',
		min(pvp) as 'Precio más bajo',
		count(id_articulo) as 'Número total de artículos'
from articulos

/* 11 */

select 	colecciones.nombre,
		max(articulos.pvp) as 'Precio más alto',
		min(articulos.pvp) as 'Precio más bajo',
		count(articulos.id_articulo) as 'Número total de artículos'
from articulos
	join colecciones on articulos.id_col = colecciones.id
group by colecciones.nombre;

/* 12 */

select 	colecciones.nombre,
		max(articulos.pvp) as 'Precio más alto',
		min(articulos.pvp) as 'Precio más bajo',
		count(articulos.id_articulo) as 'Número total de artículos'
from articulos
	join colecciones on articulos.id_col = colecciones.id
group by colecciones.nombre
having min(articulos.pvp)<> max(articulos.pvp)

/* 13 */

select 	colecciones.nombre as 'Nombre de la coleccione',
		count(articulos.id_articulo) as 'Numero de articulos de la coleccione'
from articulos
	join colecciones on articulos.id_col = colecciones.id
group by articulos.id_col
order by count(articulos.id_articulo) desc
limit 3

/* 14 */

select autores.nombre,
		autores.apellidos,
		count(colecciones.id_autor) as 'Numero de coleciones'
from colecciones
	join autores on autores.id = colecciones.id_autor
group by colecciones.id_autor
having count(colecciones.id_autor)>3;

/* 15 */

update colecciones
set finalizada = 1;

/*select *
from colecciones*/
where ult_tomo = n_tomos
	and tipo = 'Cerrada'
	and finalizada = 0;
		



/* 16 */

create view v_colecciones as 

(select colecciones.*,
		generos.genero,
		editoriales.nombre as nombre_edit,
		autores.nombre as nombre_aut,
		autores.apellidos as apellido_aut
from colecciones
	join generos on generos.id = colecciones.id_genero
	join editoriales on editoriales.id = colecciones.id_editorial
	join autores on autores.id = colecciones.id_autor

);

/* 17 */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE muestra_los_datos(IN `p_id` INT(10))
select colecciones.*,
		generos.genero,
		editoriales.nombre as nombre_edit,
		autores.nombre as nombre_aut,
		autores.apellidos as apellido_aut
from colecciones
	join generos on generos.id = colecciones.id_genero
	join editoriales on editoriales.id = colecciones.id_editorial
	join autores on autores.id = colecciones.id_autor
    where colecciones.id = p_id$$
DELIMITER ;

/* 18 */

call muestra_los_datos(1)

/* 19 */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `F_dto5`(`precio` DECIMAL(10,2)) RETURNS decimal(10,2)
    NO SQL
RETURN precio-(precio*0.05)$$
DELIMITER ;

/* or */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `F_dto5`(`precio` DECIMAL(10,2)) RETURNS decimal(10,2)
    NO SQL
RETURN precio*0.95$$
DELIMITER ;

/* 20 */

select nombre, pvp, F_dto5(pvp)
from articulos
where id_col = 1;