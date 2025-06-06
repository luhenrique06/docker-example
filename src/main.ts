const express = require('express');
const mariadb = require('mariadb');

const app = express();
const PORT = process.env.PORT || 3000;

const mariadb = require('mariadb');
require('dotenv').config(); // Load environment variables from .env file

const pool = mariadb.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  connectionLimit: 5
});
app.get('/', async (req, res) => {
  let conn;
  try {
    conn = await pool.getConnection();
    const rows = await conn.query("SELECT 'Conexão bem-sucedida com MariaDB!' AS mensagem");
    res.json({ status: "OK", message: rows[0].mensagem });
  } catch (err) {
    console.error("Erro ao conectar ao banco:", err);
    res.status(500).json({ status: "ERRO", error: err.message });
  } finally {
    if (conn) conn.release();
  }
});


app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
