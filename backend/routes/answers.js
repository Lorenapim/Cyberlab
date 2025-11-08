import { Router } from 'express';
import { query } from '../db.js';
const r = Router();


// Registrar respuesta: bloquea segunda por UNIQUE(user_id, question_id)
r.post('/', async (req, res) => {
const { user_id, scenario_id, question_id, choice_key, correct } = req.body;
try {
await query(
`insert into answers (user_id, scenario_id, question_id, choice_key, correct)
values ($1,$2,$3,$4,$5)`,
[user_id, scenario_id, question_id, choice_key, !!correct]
);
res.json({ ok: true });
} catch (err) {
if (err?.code === '23505') {
return res.status(409).json({ ok: false, reason: 'already-answered' });
}
console.error(err);
res.status(500).json({ ok: false, error: 'server-error' });
}
});


// Puntaje total por usuario (todas las preguntas)
r.get('/score/:userId', async (req, res) => {
const rows = await query(
`select coalesce(sum(case when correct then 10 else 0 end),0) as score
from answers where user_id=$1`, [req.params.userId]
);
res.json({ score: Number(rows?.[0]?.score ?? 0) });
});


export default r;