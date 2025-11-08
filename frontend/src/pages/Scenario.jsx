import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getQuestionsByScenario, postAnswer } from '../api';
import { useGameStore } from '../store';
import ProgressBar from '../components/ProgressBar';
import QuestionView from '../components/QuestionView';


export default function Scenario() {
const { id } = useParams();
const navigate = useNavigate();
const [questions, setQuestions] = useState([]);
const [idx, setIdx] = useState(0);
const userId = useGameStore(s => s.userId);


useEffect(() => { getQuestionsByScenario(id).then(setQuestions); }, [id]);


const total = questions.length;
const q = questions[idx];


const onAnswered = async (choiceKey, correct) => {
// enviar al backend (bloqueo real por UNIQUE)
await postAnswer({ user_id: userId, scenario_id: id, question_id: q.id, choice_key: choiceKey, correct });
};


const goNext = () => {
if (idx < total - 1) setIdx(i => i + 1);
else navigate('/results');
};


if (!q) return <main style={{padding:20}}>Cargando…</main>;


return (
<main style={{ padding:20, maxWidth:800, margin:'0 auto' }}>
<h2>Escenario</h2>
<ProgressBar current={idx+1} total={total} />
<QuestionView question={q} onAnswered={onAnswered} onNext={goNext} />
</main>
);
}