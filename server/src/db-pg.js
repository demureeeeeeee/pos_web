// db-pg.js — replace previous sqlite db.js
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');


const pool = new Pool({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } });


async function migrate(){
const sql = fs.readFileSync(path.join(__dirname,'..','migrations','migration.sql')).toString();
await pool.query(sql);
}


module.exports = {
query: (text, params) => pool.query(text, params),
pool,
migrate
};
