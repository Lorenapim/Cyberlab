import { useEffect, useState } from 'react';
import { useGameStore } from '../store';
import { getScore } from '../api';


export default function Results() {
const userId = useGameStore(s => s.userId);
const [score, setScore] = useState(0);
useEffect(() => { getScore(userId).then(x => setScore(x.score)); }, [userId]);


const reset = useGameStore(s => s.reset);


return (
<main style={{ padding:20 }}>
<h1>Resultados</h1>
<p>Puntaje total: <b>{score}</b></p>
<button onClick={reset}>Reiniciar (local)</button>
</main>
);
}