const mysql = require('mysql2/promise');
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;
const fs = require('fs');

// Middleware- parsear para convertir a json
app.use(express.json());

/* Casos de prueba JS y Metodos*/
let idUsuario = 3;
let email = "fer";
let cel = 33;
let curp = "F";


// server/index.js
const path = require('path');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'kueski'
});


// Endpoints Búsqueda
app.get('/usuarios', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL getAllUsuarios()`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});

app.get('/busquedaEmail', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL getUsuariosEmail ("${email}")`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});

app.get('/busquedaCURP', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL getUsuariosCURP ("${curp}")`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});

app.get('/busquedaCel', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL getUsuariosCel ("${cel}")`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});


// ACCESO ARCO- Información de un Usuario
app.get('/usuario', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL getUsuario("${idUsuario}")`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});

// Cancelacion ARCO- Información de un Usuario
app.delete('/deleteUsuario', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows] = await connection.execute(`CALL deleteUsuario("${idUsuario}")`);
        connection.release();
        if (rows[0].length === 0) {
            res.status(404).json({ error: 'No se encontraron Usuarios' });
        } else {
            res.status(200).json(rows[0]);
            const [rows] = connection.execute(`CALL getAllUsuarios()`);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error'});
    }
});

app.put('/nombre/:id', async (req, res) => {
    try {
        
        console.log(req.body);
        console.log(req.params);
        console.log(req.body.u_nombre);
        const connection = await pool.getConnection();
        const [rows] = await connection.query(`
        UPDATE usuario SET 
            u_nombre = '${req.body.u_nombre}'
            WHERE u_id = ${req.params.id}
        `);
        connection.release();

        res.status(200).json({data: "Regreso de put"});
    } catch(err) {
        console.log(err)
        res.status(500).json({data: `Error ${err}`});
    }
})

// Rectificacion y Oposicion ARCO
function permisos(num) {
    return {
        numero: parseInt(num, 2),

        // QUITAR PERMISOS
        sin_acceso_nombre: 2046, // 11111111110
        sin_acceso_papellido: 2045, // 11111111101
        sin_acceso_sapellido: 2043, // 11111111011
        sin_acceso_fnacimiento: 2039, // 11111110111
        sin_acceso_nacionalidad: 2031, // 11111101111
        sin_acceso_edonacimiento: 2015, // 11111011111
        sin_acceso_genero: 1983, // 11110111111
        in_acceso_curp: 1919, // 11101111111
        sin_acceso_celular: 1791, // 11011111111
        sin_acceso_email: 1535, // 10111111111
        sin_acceso_escliente: 1023, // 01111111111

        // DAR PERMISOS / CHECAR PERMISOS

        acceso_nombre: 1, // 00000000001
        acceso_papellido: 2, // 00000000010
        acceso_sapellido: 4, // 00000000100
        acceso_fnacimiento: 8, // 00000001000
        acceso_nacionalidad: 16, // 00000010000
        acceso_edonacimiento: 32, // 00000100000
        acceso_genero: 64, // 00001000000
        acceso_curp: 128, // 00010000000
        acceso_celular: 256, // 00100000000
        acceso_email: 512, // 01000000000
        acceso_escliente: 1024, // 10000000000

        quitarAccesoNombre() {
            this.numero = this.numero & this.sin_acceso_nombre;
        },
        quitarAccesoPApellido() {
            this.numero = this.numero & this.sin_acceso_papellido;
        },
        quitarAccesoSApellido() {
            this.numero = this.numero & this.sin_acceso_sapellido;

        },
        quitarAccesoFNacimiento() {
            this.numero = this.numero & this.sin_acceso_fnacimiento;
        },
        quitarAccesoNacionalidad() {
            this.numero = this.numero & this.sin_acceso_nacionalidad;
        },
        quitarAccesoEdonacimiento() {
            this.numero = this.numero & this.sin_acceso_edonacimiento;
        },
        quitarAccesoGenero() {
            this.numero = this.numero & this.sin_acceso_genero;
        },
        quitarAccesoCelular() {
            this.numero = this.numero & this.sin_acceso_celular;
        },
        quitarAccesoEmail() {
            this.numero = this.numero & this.sin_acceso_email;
        },
        quitarAccesoEsCliente() {
            this.numero = this.numero & this.sin_acceso_escliente;
        },
        darAccesoNombre() {
            this.numero = this.numero | this.acceso_nombre;
        },
        darAccesoPApellido() {
            this.numero = this.numero | this.acceso_papellido;
        },
        darAccesoSApellido() {
            this.numero = this.numero | this.acceso_sapellido;
        },
        darAccesoFNacimiento() {
            this.numero = this.numero | this.acceso_fnacimiento;
        },
        darAccesoNacionalidad() {
            this.numero = this.numero | this.acceso_nacionalidad;
        },
        darAccesoEdonacimiento() {
            this.numero = this.numero | this.acceso_edonacimiento;
        },
        darAccesoGenero() {
            this.numero = this.numero | this.acceso_genero;
        },
        darAccesoCelular() {
            this.numero = this.numero | this.acceso_celular;
        },
        darAccesoEmail() {
            this.numero = this.numero | this.acceso_email;
        },
        darAccesoEsCliente() {
            this.numero = this.numero | this.acceso_escliente;
        },
        lecturaNombre() {
            return this.numero & this.acceso_nombre;
        },
        lecturaPApellido() {
            return this.numero & this.acceso_papellido;
        },
        lecturaSApellido() {
            return this.numero & this.acceso_sapellido;
        },
        lecturaFNacimiento() {
            return this.numero & this.acceso_fnacimiento;
        },
        lecturaNacionalidad() {
            return this.numero & this.acceso_nacionalidad;
        },
        lecturaEdonacimiento() {
            return this.numero & this.acceso_edonacimiento;
        },
        lecturaGenero() {
            return this.numero & this.acceso_genero;
        },
        lecturaCelular() {
            return this.numero & this.acceso_celular;
        },
        lecturaEmail() {
            return this.numero & this.acceso_email;
        },
        lecturaEsCliente() {
            return this.numero & this.acceso_escliente;
        },
        lecturaNumero() {
            return (this.numero.toString(10));
        }
    };
}




//  Historial
// app.post();



//LISTEN
app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`);
});
