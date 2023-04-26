use kueski;
/*usuario*/
INSERT INTO usuario(u_id, u_nombre, u_papellido, u_sapellido, u_fnacimiento, u_nacionalidad, u_edonacimiento, u_curp, u_genero, u_celular, u_email, u_escliente, u_esbloqueado) VALUES (1, 'Fernanda', 'Romo', 'Alarcon', '2000-01-01', 'mexicana', 'Jalisco', 'FEAF771012HMCRGR08', 'F', '32259874256', 'fernandaeliromo@gmail.com', 'Si', 'No');
INSERT INTO usuario(u_id, u_nombre, u_papellido, u_sapellido, u_fnacimiento, u_nacionalidad, u_edonacimiento, u_curp, u_genero, u_celular, u_email, u_escliente, u_esbloqueado) VALUES (2, 'Jacobo', 'Hirsch', 'Rodriguez', '2001-01-01', 'mexicana', 'Colima', 'JEAF771012HMCRGR08', 'M', '32248250196', 'jacobohirsch@gmail.com', 'Si', 'No');
INSERT INTO usuario(u_id, u_nombre, u_papellido, u_sapellido, u_fnacimiento, u_nacionalidad, u_edonacimiento, u_curp, u_genero, u_celular, u_email, u_escliente, u_esbloqueado) VALUES (3, 'Andrea', 'Espindola', 'Gomez', '2002-01-01', 'mexicana', 'CDMX', 'AEAF771012HMCRGR08', 'F', '5539750429', 'alegomez@gmail.com', 'Si', 'No');

/*direccion*/
INSERT INTO direccion(d_id, d_pais, d_edo, d_ciudad, d_colonia, d_calle, d_cp, d_numext, d_numint, u_id) VALUES (1, 'Mexico', 'Jalisco', 'Puerto Vallarta', 'Riberas', 'Masayas', '01430', 34, 12, 1);
INSERT INTO direccion(d_id, d_pais, d_edo, d_ciudad, d_colonia, d_calle, d_cp, d_numext, d_numint, u_id) VALUES (2, 'Mexico', 'Colima', 'La Gran Manzana', 'Big', 'Apple', '01938', 69, 3, 2);
INSERT INTO direccion(d_id, d_pais, d_edo, d_ciudad, d_colonia, d_calle, d_cp, d_numext, d_numint, u_id) VALUES (3, 'Mexico', 'Nayarit', 'Bucelife', 'Flamingos', 'Capi', '01280', 57, 12, 3);

/*identificaciones*/
INSERT INTO identificaciones(i_id, id_num , i_tipo, u_id) VALUES (1, 1, 'INE', 1);
INSERT INTO identificaciones(i_id, id_num , i_tipo, u_id) VALUES (2, 2, 'Licencia', 2);
INSERT INTO identificaciones(i_id, id_num , i_tipo, u_id) VALUES (3, 3, 'Pasaporte', 3);

/*empleado*/
INSERT INTO empleado(e_id, e_nombre, e_papellido, e_sapellido) VALUES (1,'Elizabeth', 'Solis','Hidalgo');
INSERT INTO empleado(e_id, e_nombre, e_papellido, e_sapellido) VALUES (2,'Joaquin', 'Perez','Uribe');
INSERT INTO empleado(e_id, e_nombre, e_papellido, e_sapellido) VALUES (3,'Andrea', 'Romero','Tinajero');

/*historial*/
INSERT INTO historial(h_id, h_arco, h_fecha, h_comentarios, u_id) VALUES (1, 'Acceso', current_date(), 'Sin comentarios', 1);
INSERT INTO historial(h_id, h_arco, h_fecha, h_comentarios, u_id) VALUES (2, 'Cancelacion', current_date(), 'Sin comentarios', 2);
INSERT INTO historial(h_id, h_arco, h_fecha, h_comentarios, u_id) VALUES (3, 'Rectificacion', current_date(), 'Sin comentarios', 3);
  