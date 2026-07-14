const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 5001;

// 1. Enable CORS for your S3 Local Port
const allowedOrigin = process.env.CORS_ORIGIN || 'http://localhost:4566';
app.use(cors({
  origin: allowedOrigin,
  credentials: true
}));

app.use(express.json());

// 2. Database Connection
const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'mydb',
  port: 5432,
});

// 3. Health Endpoint
app.get('/api/health', async (req, res) => {
  try {
    const dbRes = await pool.query('SELECT NOW()');
    res.json({
      status: "Vion Backend Server UP",
      tier2_backend: "Vion Backend Server Healthy",
      tier3_database: "Vio Backend Server Connected",
      db_time: dbRes.rows[0].now
    });
  } catch (err) {
    res.status(500).json({
      status: "Vion Backend Server UP",
      tier2_backend: "Vion Backend Server Healthy",
      tier3_database: "Database Connection Failed",
      error: err.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`Backend API listening on port ${PORT}`);
});
