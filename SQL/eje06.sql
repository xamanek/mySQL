DROP TABLE if EXISTS reservas;
DROP TABLE if EXISTS investigadores;
DROP TABLE if EXISTS equipos;
DROP TABLE if EXISTS facultad;

CREATE TABLE equipos (
	idEquipo varchar(4),
	idFacultad int(11),
	descripcion varchar(50),
    PRIMARY KEY(idEquipo)
);

create table facultad (
	idFacultad int(11),
	NomFacultad varchar(50),
	PRIMARY KEY(idFacultad)
);

ALTER TABLE equipos
ADD FOREIGN KEY (idFacultad) REFERENCES facultad(idFacultad);

create table investigadores (
	idInvestigador int(11),
	DNI varchar(10),
	NomInvestigador varchar(35),
	ApellInvestigador varchar(50),
	idFacultad int(11),
	PRIMARY KEY(idInvestigador)
);

ALTER TABLE investigadores
ADD FOREIGN KEY (idFacultad) REFERENCES facultad(idFacultad);
	
create table reservas (
	idReserva bigint not null AUTO_INCREMENT,
	idInvestigador int(11),
	idEquipo varchar(4),
	FechaInicio datetime,
	FechaFin datetime,
	PRIMARY KEY(idReserva)
);	
	
ALTER TABLE reservas
ADD FOREIGN KEY (idInvestigador) REFERENCES investigadores(idInvestigador);

ALTER TABLE reservas
ADD FOREIGN KEY (idEquipo) REFERENCES equipos(idEquipo);
	
INSERT INTO facultad
(idFacultad, NomFacultad)
VALUE
(1, 'Ciencias Exactas'),
(2, 'Ciencias Naturales'),
(3, 'Ciencias y Tecnologia'),
(4, 'Bioquimica y Ciencias Biológicas');

INSERT into investigadores
(idInvestigador, DNI, NomInvestigador, ApellInvestigador, idFacultad)
value
(1, '38486831X', 'Estefania', 'López de Pablo Garcia Uceda', 1),
(2, '56234233K', 'Queralt', 'Anguera Vilafranca', 1),
(3, '23435343P', 'Joan', 'Bastardes Soto', 2),
(4, 'X3543098R', 'Raquel', 'Raya Gavilan', 3),
(5, '32544333I', 'Eliot', 'Bidault Cullerés', 4),
(6, '37879998D', 'Lluís', 'Viso Gilabert', 4);

insert into equipos
(idEquipo, idFacultad, descripcion)
value
('H503', 2, 'Telemetro Laser SICK'),
('H235', 3, 'Multimetro digital FLUKE'),
('M342', 4, 'Fuente de Voltaje TEKTRONIX'),
('M234', 3, 'Cámara digital SONY'),
('K231', 3, 'Lente para camara FUJINON-TV'),
('K456', 2, 'Anemómetro JORSEK');

insert into reservas
(idInvestigador, idEquipo, FechaInicio, FechaFin)
value
(6, 'H503', '2018-09-09', '2018-09-23'),
(1, 'H235', '2018-09-09', '2018-12-14'),
(5, 'M342', '2018-09-13', '2018-09-21'),
(1, 'M234', '2018-09-16', '2018-10-01'),
(2, 'K231', '2018-11-20', '2018-12-25'),
(5, 'H503', '2018-11-01', '2018-12-10');

/* 1. Mostrar los datos de los investigadores por orden de DNI*/

select *
from investigadores
order by DNI;

/* 2. Mostrar DNI y en otra columna conjuntamente el nombre y el apellido
(CONCAT) de todos los investigadores por orden alfabético de los apellidos.*/

select DNI, concat_ws(' ', NomInvestigador, ApellInvestigador)
from investigadores
order by ApellInvestigador;

/* 3. Mostrar DNI, nombre y apellidos de los investigadores y el nombre de la
facultad ordenados por facultad */
 
select investigadores.DNI, investigadores.NomInvestigador, investigadores.ApellInvestigador, NomFacultad
from investigadores
	join facultad on facultad.idFacultad = investigadores.idFacultad
order by facultad.NomFacultad;

/* 4. Mostrar todas las facultades que contengan la palabra ciencias en su
nombre*/

select NomFacultad
from facultad
where NomFacultad LIKE '%ciencias%';

/* 5. Mostrar todos los equipos y el nombre de la facultad a la que pertenece*/

select equipos.*, facultad.NomFacultad
from equipos
	join facultad on facultad.idFacultad = equipos.idFacultad;
	
/* 6. Mostrar todos los equipos que pertenecen a la facultad de Ciencia y
tecnología */

select *
from equipos
where idFacultad = 3;

/* 7. Mostrar todos los equipos cuyo código empiezan por H*/

select *
from equipos
where idEquipo LIKE 'H%';

/* 8. Mostrar todos los investigadores de las facultades 2 y 4. Tiene que aparecer
también el nombre de la facultad*/

select investigadores.*, facultad.NomFacultad
from investigadores
	join facultad on facultad.idFacultad = investigadores.idFacultad
where investigadores.idFacultad = 2 or investigadores.idFacultad = 4;
	
/* 9. Mostrar las reservas de noviembre. Es decir, se tienen que mostrar los
campos DNI, IdEquipo, FechaInicio donde Fecha inicio sea en noviembre.*/

select investigadores.DNI, reservas.idEquipo, reservas.FechaInicio
from reservas
	join investigadores on reservas.idInvestigador = investigadores.idInvestigador
where reservas.FechaInicio like '2018-11%';

/* 10. Mostrar los equipos que estarán reservados entre noviembre y diciembre,
es decir que tanto su fecha de inicio como su fecha final estén entre
noviembre y diciembre.*/

select *
from reservas
where FechaInicio like '2018-11%'
	or FechaInicio like '2018-12%'
	or FechaFin like '2018-11%'
	or FechaFin like '2018-12%';

/* 11. Mostrar NomInvestigador, ApellInvestigador, IdEquipo, Descripción,
FechaInicio y FechaFin de las reservas efectuadas. La consulta mostrará los
resultados ordenados por ApellInvestigador y FechaInicio*/

select 	investigadores.NomInvestigador,
		investigadores.ApellInvestigador,
		equipos.idEquipo,
		equipos.descripcion,
		reservas.FechaInicio,
		reservas.FechaFin
	from reservas
		join investigadores on reservas.idInvestigador = investigadores.idInvestigador
		join equipos on reservas.idEquipo = equipos.idEquipo
order by investigadores.ApellInvestigador, reservas.FechaInicio;

/* 12. Mostrar el DNI y el nombre y apellidos de aquellos investigadores que han
hecho más de una reserva.*/

select DNI, NomInvestigador, ApellInvestigador
from investigadores
	join reservas on reservas.idInvestigador = investigadores.idInvestigador
group by reservas.idInvestigador
having count(reservas.idInvestigador)>1;


/* 13. */
select investigadores.DNI, investigadores.nomInve,
		count(reservas.idInvestigador) as 'Num reservas'
from investigadores
left join reservas on investigadores.idInvestigador = reservas.idInvestigador
group by reservas.idInvestigador


/* 25. Crear un Procedure que tenga un parámetro de entrada (idFac) y que nos
devuelva los investigadores filtrados por la facultad que tiene el idFacultad
del parámetro de entrada.*/
















