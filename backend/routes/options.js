import { Router } from 'express';
import { query } from '../db.js';
const r = Router();


r.get('/by-question/:id', async (req, res) => {
const rows = await query('select * from options where question_id=$1 order by key asc', [req.params.id]);
res.json(rows);
});


export default r;