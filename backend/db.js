import dotenv from 'dotenv';
dotenv.config();
import pkg from 'pg';
const { Pool } = pkg;


export const pool = new Pool({ connectionString: process.env.DATABASE_URL });


export async function query(sql, params) {
const client = await pool.connect();
try {
const res = await client.query(sql, params);
return res.rows;
} finally {
client.release();
}
}