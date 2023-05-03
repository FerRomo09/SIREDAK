-- CREAMOS STORES PROCEDURES / ENDPOINTS. Cada endpoint llama un SP en la DB.
-- BÚSQUEDAS
-- Todos los Usuarios
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
--  getUsuariosEmail("jacobohirsch@gmail.com");


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


-- ARCO ACCESO
-- Ver Información Usuario por User_ID

-- ARCO RECTIFICACION
-- Cambiar información por User_ID (Tablas: Usuario, Direccion e Identificaciones)


-- ARCO CANCELACION 
-- Eliminar Usuario (u_id) y solo mantener eso


-- ARCO OPOSICION 
-- Oponerse a la Informacion (u_id)