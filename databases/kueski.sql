drop database if exists kueski;
create database if not exists kueski;
use kueski;

create table usuario(
	u_id SMALLINT NOT NULL,
    u_nombre VARCHAR(20),
    u_papellido VARCHAR(20),
    u_sapellido VARCHAR(20),
    u_fnacimiento DATE,
    u_nacionalidad VARCHAR(20) check(u_nacionalidad regexp '^[a-zA-Z]'),
    u_edonacimiento VARCHAR(20) check(u_edonacimiento regexp '^[a-zA-Z]'),
    u_curp VARCHAR(18) check(u_curp regexp '^[A-Za-z0-9]{18}$'),
    u_genero CHAR check(u_genero="M"|u_genero="F"|u_genero="O"),
    u_celular VARCHAR(15) check(u_celular regexp '^[0-9]{10}'), 
    u_email VARCHAR(50) ,
    u_escliente BOOL,
    u_access VARCHAR(11) check(u_access regexp '^[0-1]{11}'),
    PRIMARY KEY (u_id)
);

create table direccion(
	d_id SMALLINT,
    d_pais VARCHAR(30),
    d_edo VARCHAR(30),
    d_ciudad VARCHAR(30),
    d_colonia VARCHAR(30),
    d_calle VARCHAR(30),
    d_cp VARCHAR(5),
    d_numext VARCHAR(5),
    d_numint VARCHAR(5),
    u_id SMALLINT NOT NULL,
    d_access BOOL,
    PRIMARY KEY(d_id),
	FOREIGN KEY(u_id) REFERENCES usuario(u_id)
);

create table identificaciones(
	i_id SMALLINT,
    id_num SMALLINT,
	i_tipo VARCHAR(20),
    u_id SMALLINT NOT NULL,
    i_access BOOL,
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
	h_id SMALLINT not null auto_increment,
    h_arco VARCHAR(15) not null,
    h_fecha DATE not null,
    h_comentarios TINYTEXT,
    u_id SMALLINT NOT NULL,
    -- reportepdf
    PRIMARY KEY(h_id),
    FOREIGN KEY(u_id) REFERENCES usuario(u_id)
);

-- Observar tablas ya creadas
SELECT * FROM usuario;
SELECT * FROM direccion;
SELECT * FROM identificaciones;
SELECT * FROM empleado;
SELECT * FROM historial;
