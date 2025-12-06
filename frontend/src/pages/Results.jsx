import { useEffect, useState } from 'react';
import { useGameStore } from '../store';
import { getScore } from '../api';


export default function Results() {
const userId = useGameStore(s => s.userId);
const [score, setScore] = useState(0);
useEffect(() => { getScore(userId).then(x => setScore(x.score)); }, [userId]);


const reset = useGameStore(s => s.reset);


return (
    <main className="min-h-screen bg-gray-100">
      <section className="max-w-xl mx-auto px-4 py-10">
        <h1 className="text-3xl font-bold text-gray-900">Resultados</h1>

        <p className="mt-4 text-lg text-gray-700">
          Puntaje total:{' '}
          <span className="font-semibold text-blue-700">{score}</span>
        </p>

        <button
          onClick={reset}
          className="mt-6 inline-flex items-center rounded-lg bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700"
        >
          Reiniciar (local)
        </button>
      </section>
    </main>
  );
}