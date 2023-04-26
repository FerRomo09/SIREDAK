drop database if exists kueski;
create database if not exists kueski;
use kueski;

create table usuario(
	u_id SMALLINT NOT NULL,
    u_nombre VARCHAR(20),
    u_papellido VARCHAR(20),
    u_sapellido VARCHAR(20),
    u_fnacimiento DATE,
    u_nacionalidad VARCHAR(20),
    u_edonacimiento VARCHAR(20),
    u_curp VARCHAR(18),
    u_genero CHAR,
    u_celular VARCHAR(15), 
    u_email VARCHAR(50),
    u_escliente VARCHAR(2),
    u_esbloqueado VARCHAR(2),
    PRIMARY KEY (u_id)
);

create table direccion(
	d_id SMALLINT NOT NULL,
    d_pais VARCHAR(30),
    d_edo VARCHAR(30),
    d_ciudad VARCHAR(30),
    d_colonia VARCHAR(30),
    d_calle VARCHAR(30),
    d_cp VARCHAR(5),
    d_numext VARCHAR(5),
    d_numint VARCHAR(5),
    u_id SMALLINT NOT NULL,
    PRIMARY KEY(d_id),
	FOREIGN KEY(u_id) REFERENCES usuario(u_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table identificaciones(
	i_id SMALLINT,
    id_num SMALLINT,
	i_tipo VARCHAR(20),
    u_id SMALLINT NOT NULL,
    PRIMARY KEY(i_id),
    FOREIGN KEY(u_id) REFERENCES usuario(u_id)
);

create table empleado(
	e_id SMALLINT,
    e_nombre VARCHAR(20),
	e_papellido VARCHAR(20),
    e_sapellido VARCHAR(20),
    PRIMARY KEY(e_id)
);

create table historial(
	h_id SMALLINT,
    h_arco VARCHAR(15),
    h_fecha DATE,
    h_comentarios TINYTEXT,
    u_id SMALLINT NOT NULL,
    -- reportepdf
    PRIMARY KEY(h_id),
    FOREIGN KEY(u_id) REFERENCES usuario(u_id)
);

SELECT * FROM usuario;
SELECT * FROM direccion;
SELECT * FROM identificaciones;
SELECT * FROM empleado;
SELECT * FROM historial;