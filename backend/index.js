import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import helmet from 'helmet';
import morgan from 'morgan';
import rateLimit from 'express-rate-limit';


import scenarios from './routes/scenarios.js';
import questions from './routes/questions.js';
import options from './routes/options.js';
import answers from './routes/answers.js';


dotenv.config();
const app = express();


app.use(helmet());
app.use(cors({
  origin: [
    'http://localhost:5173',
    'http://localhost:5174'
  ]
}));
app.use(express.json());
app.use(morgan('dev'));
app.use(rateLimit({ windowMs: 60_000, max: 120 }));


app.get('/', (req, res) => res.json({ ok: true, name: 'cybergame-api' }));
app.use('/scenarios', scenarios);
app.use('/questions', questions);
app.use('/options', options);
app.use('/answers', answers);


const port = process.env.PORT || 4000;
app.listen(port, () => console.log(`API on http://localhost:${port}`));