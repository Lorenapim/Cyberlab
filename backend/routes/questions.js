import { Router } from 'express';
import { query } from '../db.js';
const r = Router();


// preguntas por escenario, con opciones anidadas
r.get('/by-scenario/:id', async (req, res) => {
const { id } = req.params;
const qs = await query('select * from questions where scenario_id=$1 order by order_index asc', [id]);
const qIds = qs.map(q => q.id);
let opts = [];
if (qIds.length) {
const placeholders = qIds.map((_, i) => `$${i+1}`).join(',');
opts = await query(`select * from options where question_id in (${placeholders}) order by key asc`, qIds);
}
const merged = qs.map(q => ({ ...q, options: opts.filter(o => o.question_id === q.id) }));
res.json(merged);
});


export default r;