-- CREAMOS STORES PROCEDURES / ENDPOINTS. Cada endpoint llama un SP en la DB.
-- BÚSQUEDAS
-- Todos los Usuarios

use kueski;

DROP PROCEDURE IF EXISTS getAllUsuarios;
DELIMITER &&
CREATE PROCEDURE getAllUsuarios()
BEGIN
SELECT
	u_id, u_nombre, u_papellido, u_sapellido, u_curp, u_celular, u_email
FROM 
	usuario
ORDER BY 
	u_id ASC;
END &&
DELIMITER ;
-- call getAllUsuarios();

-- Busqueda de Usuarios por Email
DROP PROCEDURE IF EXISTS getUsuariosEmail;
DELIMITER &&
CREATE PROCEDURE getUsuariosEmail(IN email varchar(50))
BEGIN
SELECT
	u_id, u_nombre, u_papellido, u_sapellido, u_curp, u_celular, u_email
FROM 
	usuario
WHERE
	u_email LIKE CONCAT(email, '%')
ORDER BY 
	u_email ASC;
END &&
DELIMITER ;
-- call getUsuariosEmail("jacobohirsch@gmail.com");


-- Busqueda de Usuarios por Celular
DROP PROCEDURE IF EXISTS getUsuariosCel;
DELIMITER &&
CREATE PROCEDURE getUsuariosCel(IN cel varchar(50))
BEGIN
SELECT
	u_id, u_nombre, u_papellido, u_sapellido, u_curp, u_celular, u_email
FROM 
	usuario
WHERE
	u_celular LIKE CONCAT(cel, '%')
ORDER BY 
	u_celular ASC;
END &&
DELIMITER ;
-- call getUsuariosCel("55");

-- Busqueda de Usuarios por CURP
DROP PROCEDURE IF EXISTS getUsuariosCURP;
DELIMITER &&
CREATE PROCEDURE getUsuariosCURP(IN curp varchar(50))
BEGIN
SELECT
	u_id, u_nombre, u_papellido, u_sapellido, u_curp, u_celular, u_email
FROM 
	usuario
WHERE
	u_curp LIKE CONCAT(curp, '%')
ORDER BY 
	u_curp ASC;
END &&
DELIMITER ;
-- call getUsuariosCURP("FEAF");


-- ARCO ACCESO
-- Ver Información Usuario por User_ID
DROP PROCEDURE IF EXISTS getUsuario;
DELIMITER &&
CREATE PROCEDURE getUsuario(IN id smallint(6))
BEGIN
SELECT
	*
FROM 
	usuario
JOIN
	identificaciones
ON
	usuario.u_id = identificaciones.u_id
JOIN
	direccion
ON
	usuario.u_id = direccion.u_id
WHERE
	usuario.u_id LIKE CONCAT(id, '%')
ORDER BY 
	usuario.u_id ASC;
END &&
DELIMITER ;
-- call getUsuario("1");


-- ARCO RECTIFICACION
-- Cambiar información por User_ID (Tablas: Usuario, Direccion e Identificaciones)

-- Usuario 
-- Nombre 
DROP PROCEDURE IF EXISTS modificarNombre;
DELIMITER &&
CREATE PROCEDURE modificarNombre(nombre VARCHAR(20), identificacion SMALLINT)
BEGIN 
UPDATE usuario SET u_nombre = nombre  WHERE u_id = identificacion;
END &&
DELIMITER ;


--  primer apellido 
DROP PROCEDURE IF EXISTS modificarPApellido;
DELIMITER &&
CREATE PROCEDURE modificarPApellido(apellido VARCHAR(20), identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_papellido = apellido  WHERE u_id = identificacion;
END &&
DELIMITER ;


--  segundo apellido 
DROP PROCEDURE IF EXISTS modificarSApellido;
DELIMITER &&
CREATE PROCEDURE modificarSApellido(apellido VARCHAR(20), identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_sapellido = apellido  WHERE u_id = identificacion;
END &&
DELIMITER ;


-- nacionalidad 
DROP PROCEDURE IF EXISTS modificarNacionalidad;
DELIMITER &&
CREATE PROCEDURE modificarNacionalidad(nacionalidad VARCHAR(20), identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_nacionalidad = nacionalidad   WHERE u_id = identificacion;
END &&
DELIMITER ;


-- CURP 
DROP PROCEDURE IF EXISTS modificarCurp;
DELIMITER &&
CREATE PROCEDURE modificarCurp( curp VARCHAR(18), identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_curp = curp  WHERE u_id = identificacion;
END &&
DELIMITER ;


-- GENERO 
DROP PROCEDURE IF EXISTS modificarGenero;
DELIMITER &&
CREATE PROCEDURE modificarGenero( genero CHAR , identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_genero = genero  WHERE u_id = identificacion;
END &&
DELIMITER ;


 -- celular
DROP PROCEDURE IF EXISTS modificarCelular;
DELIMITER &&
CREATE PROCEDURE modificarCelular( celular VARCHAR(15) , identificacion SMALLINT)
BEGIN
UPDATE usuario SET u_celular = celular  WHERE u_id = identificacion;
END &&
DELIMITER ;


 -- e-mail
 DROP PROCEDURE IF EXISTS modificarMail;
DELIMITER &&
CREATE PROCEDURE modificarMail(  email VARCHAR(50) , identificacion SMALLINT)
BEGIN
UPDATE usuario SET  u_email = email  WHERE u_id = identificacion;
END &&
DELIMITER ;



 -- escliente
DROP PROCEDURE IF EXISTS modificarEscliente;
DELIMITER &&
CREATE PROCEDURE modificarEscliente(  escliente BOOL , identificacion SMALLINT)
BEGIN
UPDATE usuario SET  u_escliente = escliente  WHERE u_id = identificacion;
END &&
DELIMITER ;


 -- u_acces Usuario 
DROP PROCEDURE IF EXISTS modificarAccesoUsuario;
DELIMITER &&
CREATE PROCEDURE modificarAccesoUsuario(  access VARCHAR(12) , identificacion SMALLINT)
BEGIN
UPDATE usuario SET  u_access = access  WHERE u_id = identificacion;
END &&
DELIMITER ;

DROP PROCEDURE IF EXISTS modificarDireccion;
DELIMITER &&
CREATE PROCEDURE modificarDireccion( dID SMALLINT  , pais VARCHAR(30) , edo VARCHAR(30) , ciudad VARCHAR(30), colonia VARCHAR(30), calle VARCHAR(30), cp VARCHAR(5),  numext VARCHAR(5) , numint VARCHAR(5), uID SMALLINT)
BEGIN
UPDATE direccion 
SET d_id = dID , d_pais = pais, d_edo = edo, d_ciudad = ciudad, d_colonia = colonia, d_calle = calle , d_cp = cp, d_numext = numext, d_numint = numint
WHERE u_id = uID;
END &&
DELIMITER ;
-- SELECT * FROM direccion; 

                       
 -- CALL modificarDireccion(1, 'Mexico', 'Jalisco', 'luis miguel ', 'Riberas', 'Masayas', '01430', '34', '12', 1 );
 
-- identificaciones 
DROP PROCEDURE IF EXISTS modificarIdentificacion;
DELIMITER &&
CREATE PROCEDURE modificarIdentificacion(iID SMALLINT,  idNum VARCHAR(10), iTipo VARCHAR(20), uID SMALLINT)
BEGIN
UPDATE identificaciones
SET  id_num  = idNum , i_tipo = iTipo
WHERE u_id = uID AND i_id = iID;
END &&
DELIMITER ;
 
 
-- modificar acceso identificacion
DROP PROCEDURE IF EXISTS modificarAccesoIdentificacion;
DELIMITER &&
CREATE PROCEDURE modificarAccesoIdentificacion(access BOOL, identificacion SMALLINT, iID SMALLINT)
BEGIN
UPDATE identificaciones  SET  i_access = access  WHERE u_id = identificacion AND i_id = iID;
END &&
DELIMITER ;

-- dirección 
-- modificar acceso direccion 
DROP PROCEDURE IF EXISTS modificarAccesoDireccion;
DELIMITER &&
CREATE PROCEDURE modificarAccesoDireccion(access BOOL, identificacion SMALLINT)
BEGIN
UPDATE direccion SET  d_access = access  WHERE u_id = identificacion;
END &&
DELIMITER ;


-- ARCO CANCELACION 
-- Eliminar Usuario (u_id) y solo mantener eso
DROP PROCEDURE IF EXISTS deleteUsuario;
DELIMITER &&
CREATE PROCEDURE deleteUsuario(IN id smallint(6))
BEGIN
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE DIRECCION
	DROP PRIMARY KEY;
DELETE FROM DIRECCION
WHERE direccion.u_id = id;
ALTER TABLE direccion
	ADD PRIMARY KEY(d_id);
ALTER TABLE identificaciones
	DROP PRIMARY KEY;
DELETE FROM identificaciones
WHERE identificaciones.u_id = id;
ALTER TABLE identificaciones
	ADD PRIMARY KEY(i_id);
UPDATE usuario
SET u_nombre = NULL, u_papellido = NULL, u_sapellido = NULL, u_fnacimiento = NULL, u_nacionalidad = NULL, u_edonacimiento = NULL, u_curp = NULL, u_genero = NULL, u_celular = NULL, u_email = NULL, u_escliente = NULL, u_access = NULL
WHERE usuario.u_id = id;
SET SQL_SAFE_UPDATES = 1;
END &&
DELIMITER ;

/*call deleteUsuario(1);
select * from usuario
where u_id = 2;*/

-- HISTORIAL
DROP PROCEDURE IF EXISTS crearHistorial;
DELIMITER &&
CREATE PROCEDURE crearHistorial(arco VARCHAR(15), comentarios TINYTEXT, id SMALLINT)
BEGIN
INSERT INTO historial(h_id, h_arco, h_fecha, h_comentarios, u_id) VALUES (NULL, arco, current_date(), comentarios, id);
END &&
DELIMITER ;
-- call crearHistorial('Acceso', 'Sin Comentarios', 12);
-- select * from historial;
