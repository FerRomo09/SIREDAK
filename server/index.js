const mysql = require('mysql2/promise');
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;
const fs = require('fs');

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
        const [rows] = await connection.execute('CALL getAllUsuarios()');
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
        const [rows] = await connection.execute('CALL getUsuariosEmail("fernanda")');
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


// Abrir HTML INDEZ
app.use( express.static( path.resolve( __dirname, '../client')));
// Todas las peticiones GET que no manejamos ahora regresarán nuestra React App
app.get('*', (req, res) => {
    res.sendFile( path.resolve( __dirname, '../client', 'index.html'));
});


//LISTEN
app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`);
});
