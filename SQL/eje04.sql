/* cancellare tutto per poter importare */
DROP TABLE if EXISTS empleados;
DROP TABLE departamentos;

/* creare tablas*/
CREATE TABLE departamentos (
	codigo int AUTO_INCREMENT,
	Nombre varchar(100) NOT NULL,
	Presupuesto decimal(10,2),
	PRIMARY KEY (codigo)
);

CREATE TABLE empleados (
	DNI varchar(8) NOT NULL,
	Nombre varchar(100) NOT NULL,
	Apellidos varchar(255),
	Departamento int,
	PRIMARY KEY (DNI),
	FOREIGN KEY (departamento) REFERENCES departamentos(codigo)
);

/* inserire dati nelle tablas*/
INSERT INTO departamentos
(Nombre, Presupuesto)
VALUE
('Contabilidad', 2000),
('Desarrollo', 5000),
('Análisis', 3500),
('Comercial', 10000),
('Recursos Humanos', 1500);

INSERT INTO empleados
(DNI, Nombre, Apellidos, Departamento)
VALUE
('34242436', 'Cesar', 'Rivas', 1),
('34242437','Alessandro', 'Ronchi', 2),
('34242438','Patricia', 'Padilla', 3),
('34242431','Gabriel', 'Munteanu', 4),
('34242432','Consuelo', 'Sanabria', 5),
('34242433','Patricia', 'Basedas', 1),
('34242434','Andrea', 'Arnaiz', 2),
('34242435','Manuel', 'Dominguez', 3),
('34246436','Imma', 'Ibáñez', 4),
('34243436','Irene', 'Toro', 5),
('34249436','Laura', 'Nigro', 3);


/* ESERCIZI

1. Mostrar apellidos de los empleados
*/SELECT apellidos
FROM empleados
/*
2. Obtener los nombres de los empleados sin repeticion
SELECT DISTINCT Nombre
FROM empleados

3. Obtener los datos de los empleados que trabajan por el departamento 3
SELECT *
FROM empleados
WHERE Departamento = 3

4. los del departamento 4 y 5
SELECT *
FROM empleados
WHERE Departamento IN (4,5)

ma anche 

SELECT *
FROM empleados
WHERE Departamento = 4
OR Departamento = 5

5. obt. todos los datos de los empleados cuyo nombre empiece por A
SELECT *
FROM empleados
WHERE Nombre LIKE 'A%'


6. obtenr el presupuesto total de todos los departamentos
SELECT SUM(Presupuesto)
FROM departamentos

7. Obt el numero de empleados de cada departamento
SELECT departamentos.Nombre, COUNT(empleados.DNI)
FROM departamentos
	LEFT JOIN empleados on departamentos.codigo = empleados.Departamento
GROUP BY departamentos.Nombre
ORDER BY departamentos.Nombre 


8. obt un listado completo de empleados incluyendo por cada empleados los datos del empleados y de su departamento
SELECT *
FROM empleados
	JOIN departamentos on departamentos.codigo = empleados.Departamento

9. obt los nombres y apellidos de los empleados que trabajan  en dep cuyo presupuesto es mayor de 2000 
SELECT empleados.Nombre, empleados.Apellidos, departamentos.Presupuesto
FROM departamentos
	JOIN empleados on departamentos.codigo = empleados.Departamento
WHERE departamentos.Presupuesto > 2000

!!!! si puó mettere nel FROM anche empleados tanto é =

10. Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de
todos los departamentos

SELECT *
FROM departamentos
WHERE Presupuesto > (
    SELECT AVG(Presupuesto)
    FROM departamentos)

11. Obtener los nombres de los departamentos que tienen más de 2 empleados
Se si deve ottenere un COUNT si deve sempre raggruppare e quindi avere un GROUP BY. E se bisogna filtrare qualcosa dopo il GROUP BY allora si deve mettere un HAVING anziché il WHERE (where va solo prima del Group by)

SELECT departamentos.Nombre, COUNT(empleados.DNI)
FROM departamentos
	JOIN empleados on departamentos.codigo = empleados.Departamento
GROUP BY departamentos.Nombre
HAVING COUNT(empleados.DNI) > 2

12. Añadir un nuevo departamento: "Calidad" con presupuesto 5000. Añadir un empleado
vinculado al departamento recién creado: Esther Vázquez, Dni: 00100

INSERT INTO departamentos
(Nombre, Presupuesto)
VALUE
('Calidad', 5000);

INSERT INTO empleados
(DNI, Nombre, Apellidos, Departamento)
VALUE
('00100', 'Esther', 'Vázquez', (SELECT MAX(codigo) FROM departamentos))

13. Aplicar un recorte presupuestario del 10% a todos los departamentos

UPDATE departamentos
SET Presupuesto = Presupuesto - (Presupuesto * 0.10)
WHERE Presupuesto


14. Reasignar a los empleados del departamento de código 3 al departamento 5

UPDATE empleados
SET Departamento = 5
WHERE Departamento = 3

/*15. Despedir a todos los empleados que trabajan para el departamento 5

DELETE FROM empleados
WHERE departamento = 5


16. Despedir a todos los empleados que trabajan para departamento cuyo presupuesto es superior
a los 6000

DELETE FROM empleados
WHERE departamento IN (SELECT codigo
                       FROM departamentos
                       WHERE presupuesto > 6000)

17. Despedir a todos los empleados.

TRUNCATE empleados

Si fa col TRUNCATE (anziché delete from) in modo che cancella tutto il contenuto dellla tabla di colpo (ma non la tabla) e non linea per linea,
e non lascia spazio vuoto, liberando completamente la memoria

19. Borrar la restricción de clave primaria en el campo dni de la tabla de empleados

ALTER TABLE empleados
DROP PRIMARY KEY;

20. Añadir una nueva columna a la tabla de empleados que se llame id sea de tipo integer, not null,
que sea autoincremental y primary key.

ALTER TABLE empleados
ADD id int NOT NULL AUTO_INCREMENT PRIMARY KEY

21. Crear un nuevo campo en la tabla de empleados que se llame sexo

ALTER TABLE empleados
ADD sexo VARCHAR(1)

/* 22. Añadir una restricción para que solo pueda contener una H de Hombre y una M de mujer */

ALTER TABLE empleados
ADD CONSTRAINT sexo CHECK (sexo in ('H', 'M'))

/* 23. Modificar el valor null de sexo por una H a los empleados Hombre (hacerlo todos de una vez,
especificando los ids)*/

UPDATE empleados
SET sexo = 'H'
WHERE id in (1, 5, 6, 7)

/* 24. Modificar el valor null de sexo por una M a los empleados Mujeres (hacerlo todos de una vez,
especificando los ids) */

UPDATE empleados
SET sexo = 'M'
WHERE sexo IS NULL
/* e poi se voglio cambiare
		   != 'H'
		   <> 'H'
      NOT sexo = 'H'
      */


*/









