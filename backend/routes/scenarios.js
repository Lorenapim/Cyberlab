import { Router } from 'express';
import { query } from '../db.js';
const r = Router();


r.get('/', async (_req, res) => {
const rows = await query('select * from scenarios order by created_at asc');
res.json(rows);
});


export default r;