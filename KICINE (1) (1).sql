
Drop database if exists kicine;

Create database Kicine;

use Kicine;

Create table Pelicula(
  idPelicula int auto_increment,
  titulo varchar(255) not null,
  genero varchar(255) not null,
  director varchar(255) not null,
  duracion int not null,
  sinopsis text not null,
  ano_lanzamiento int not null,
  calificacion varchar(50) not null,
  idioma varchar(50) not null,
  primary key PK_idPelicula(idPelicula)
);


-- carlos juarez
Create table SalaCine(
  idSalacine int auto_increment not null,
  numero_sala int not null,
  capacidad int not null,
  tipo_sala varchar(50) not null,
  ubicacion varchar(255) not null,
  primary key PK_idSalaCine(idSalaCine)
);


-- Palma
Create table HorariosProyeccion(
  idHorariosProyeccion int auto_increment not null,
  hora_inicio time not null,
  hora_fin time not null,
  disponibilidad_asientos int not null,
  sala_id int not null,
  pelicula_id int not null,
  primary key PK_idHorariosProyeccion(idHorariosProyeccion),
  foreign key (sala_id) references SalaCine(idSalacine),
  foreign key (pelicula_id) references Pelicula(idPelicula)
);



-- Quiyuch
Create table Login(
	codigoUsuario int auto_increment not null,
    usuario varchar(50) not null not null,
    contrasena varchar(50) not null not null,
    primary key PK_codUsuario(codigoUsuario)

);


Create table Usuario(
  idUsuario int auto_increment not null,
  nombre varchar(255) not null,
  apellido varchar(255) not null,
  correo_electronico varchar(255) not null,
  contrasena varchar(255) not null,
  tarjeta_credito varchar(255) not null,
  primary key PK_idUsuario(idUsuario)
);




-- Brandon
Create table Reserva(
  idReserva int auto_increment not null,
  pelicula_idPelicula int not null,
  sala_id int not null,
  horario_id int not null,
  usuario_id int not null,
  cantidad_entradas int not null,
  primary key PK_idReserva(idReserva),
  foreign key (pelicula_idPelicula) references Pelicula(idPelicula),
  foreign key (sala_id) references SalaCine(idSalaCine),
  foreign key (horario_id) references HorariosProyeccion(idHorariosProyeccion),
  foreign key (usuario_id) references Usuario(idUsuario)
);


-- Luis michu
Create table Cine(
  idCine int auto_increment not null,
  nombre varchar(255) not null,
  ubicacion varchar(255) not null,
  telefono varchar(50) not null,
  pagina_web varchar(255) not null,
  horarios_apertura varchar(255) not null,
  primary key PK_idCine(idCine)
);


-- Diego
Create table Taquilla (
  idTaquilla int auto_increment not null,
  numero_taquilla int not null,
  ubicacion varchar(255) not null,
  estado varchar(255) not null,
  capacidad int not null,
  tipo_pago_aceptado varchar(255) not null,
  horario_operacion varchar(255) not null,
  id_cine int not null,
  primary key PK_idTaquilla (idTaquilla),
  foreign key (id_cine) references Cine(idCine)
);


-- Herling
Create table Comentario(
  idComentario int auto_increment not null,
  usuario_id int not null,
  pelicula_id int not null,
  texto text not null,
  puntuacion int not null,
  primary key PK_idComentario(idComentario),
  foreign key (usuario_id) references Usuario(idUsuario),
  foreign key (pelicula_id) references Pelicula(idPelicula)
);


-- Sebastian
Create table Promocion(
  idPromocion int auto_increment not null,
  nombre_promocion varchar(255) not null,
  descripcion text not null,
  fechas_validez varchar(255) not null,
  codigo_promocion varchar(255) not null,
  primary key PK_idPromocion(idPromocion)
);


-- Beto
Create table FuncionEspecial(
  idFuncionEspecial int auto_increment not null,
  tipo_funcion varchar(255) not null,
  descripcion text not null,
  pelicula_id int not null,
  horario_id int not null,
  primary key PK_idFuncionEspecial(idFuncionEspecial),
  foreign key (pelicula_id) references Pelicula(idPelicula),
  foreign key (horario_id) references HorariosProyeccion(idHorariosProyeccion)
);




-- Jimenez
Create table Estreno(
  idEstreno int auto_increment not null,
  pelicula_id int not null,
  fecha_estreno date not null,
  promocion_id int not null,
  primary key PK_idEstreno(idEstreno),
  foreign key (pelicula_id) references Pelicula(idPelicula),
  foreign key (promocion_id) references Promocion(idPromocion)
);


-- Empleados
/*Create table Empleado(
  idEmpleado int auto_increment,
  nombre varchar(255),
  cargo varchar(255),
  horario_trabajo varchar(255),
  primary key PK_idEmpleado(idEmpleado)
);*/


-- Quezada
Create table Cartelera(
  idCartelera int auto_increment not null,
  fecha date not null,
  pelicula_id int not null not null,
  horario_id int not null not null,
  primary key PK_idCartelera(idCartelera),
  foreign key (pelicula_id) references Pelicula(idPelicula),
  foreign key (horario_id) references HorariosProyeccion(idHorariosProyeccion)
);





-- ------------------ Procedimientos almacenados -----------------------------


Delimiter $$
	Create procedure sp_AgregarPelicula(in titulo varchar(255), in genero varchar(255), in director varchar(255), in duracion int, in sinopsis text, in ano_lanzamiento int, in calificacion varchar(50), in idioma varchar(50))
    Begin
		Insert into Pelicula(titulo, genero, director, duracion, sinopsis, ano_lanzamiento, calificacion, idioma)
			values(titulo, genero, director, duracion, sinopsis, ano_lanzamiento, calificacion, idioma);
    End$$
Delimiter ;

call sp_AgregarPelicula('¿Qué pasó ayer?', 'Comedia', 'Jhon', 130, 'Es una muy buena película', 2009, '4.6 estrellas', 'Español e inglés');


-- --------------------------Procedimiento Almacenado Agregar de Horarios de Proyeccion
Delimiter $$
	Create procedure sp_AgregarHorariosProyeccion(in hora_inicio time, in hora_fin time, in disponibilidad_asientos int, in sala_id int,
    in pelicula_id int)
    Begin
		Insert into HorariosProyeccion(hora_inicio, hora_fin, disponibilidad_asientos, sala_id, pelicula_id)
				values(hora_inicio, hora_fin, disponibilidad_asientos, sala_id, pelicula_id);
    End$$
Delimiter ;

call sp_AgregarHorariosProyeccion("12:00","14:45", 50, 1, 1);
call sp_AgregarHorariosProyeccion("15:00","17:45", 50, 2, 2);
call sp_AgregarHorariosProyeccion("18:00","20:45", 50, 3, 3);
call sp_AgregarHorariosProyeccion("21:00","23:45", 50, 4, 4);



-- --------------------------Procedimiento Almacenado Listar de Horarios de Proyeccion
Delimiter $$
	Create Procedure sp_ListarHorariosProyeccion()
    Begin
		Select 
			HP.idHorariosProyeccion,
            HP.hora_inicio,
            HP.hora_fin,
            HP.disponibilidad_asientos,
            HP.sala_id,
            HP.pelicula_id
            from HorariosProyeccion HP;
    End$$
Delimiter ; 

Call sp_ListarHorariosProyeccion();


-- --------------------------Procedimiento Almacenado Buscar de Horarios de Proyeccion
Delimiter $$
	Create Procedure sp_BuscarHorariosProyeccion(in idHorariosProy int)
    Begin
		Select 
            HP.hora_inicio,
            HP.hora_fin,
            HP.disponibilidad_asientos,
            HP.sala_id,
            HP.pelicula_id
            from HorariosProyeccion HP where HP.idHorariosProyeccion = idHorariosProy;
    End$$
Delimiter ; 

Call sp_BuscarHorariosProyeccion(1);
Call sp_BuscarHorariosProyeccion(2);
Call sp_BuscarHorariosProyeccion(3);
Call sp_BuscarHorariosProyeccion(4);



-- --------------------------Procedimiento Almacenado Editar de Horarios de Proyeccion
Delimiter $$
	create Procedure sp_EditarHorariosProyeccion(in idHorariosProy int, in hora_i time, in hora_f time, in disp_asientos int, in sal_id int,
    in peli_id int)
    Begin
		Update HorariosProyeccion HP
			set HP.hora_inicio = hora_i, HP.hora_fin = hora_f, HP.disponibilidad_asientos = disp_asientos,
				HP.sala_id = sal_id, HP.pelicula_id = peli_id
					where HP.idHorariosProyeccion = idHorariosProy;
		
    End$$
Delimiter ;


Call sp_EditarHorariosProyeccion("24:00", "02:45", 60, 1, 1);
Call sp_EditarHorariosProyeccion("03:00", "05:45", 60, 2, 2);
Call sp_EditarHorariosProyeccion("06:00", "08:45", 60, 3, 3);
Call sp_EditarHorariosProyeccion("09:00", "11:45", 60, 4, 4);


Select * from HorariosProyeccion;
-- --------------------------Procedimiento Almacenado Eliminar de Horarios de Proyeccion
Delimiter $$
	Create Procedure sp_EliminarHorariosProyeccion(in idHorariosProy int )
    Begin
		Delete from HorariosProyeccion
			where HorariosProyeccion = idHorariosProy;
    End$$
Delimiter ;

Call sp_EliminarHorariosProyeccion(1);
Call sp_EliminarHorariosProyeccion(2);
Call sp_EliminarHorariosProyeccion(3);
Call sp_EliminarHorariosProyeccion(4);


Select * from Pelicula;
