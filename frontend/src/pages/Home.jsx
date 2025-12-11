import React from 'react';
import { useEffect, useState } from 'react';
import { getScenarios } from '../api';
import ScenarioCard from '../components/ScenarioCard';


export default function Home() {
const [items, setItems] = useState([]);
useEffect(() => { getScenarios().then(setItems); }, []);


return (
    <main className="min-h-screen bg-gray-100">
    <section className="max-w-6xl mx-auto px-4 py-8">
        <h1 className="inline-block rounded-md bg-yellow-100 px-4 py-2 text-4xl font-extrabold text-blue-700">
        CyberLab (React)
        </h1>

        <p className="mt-2 text-sm text-gray-700">
        Escoge un escenario y comienza. Cada correcta vale 10 puntos.
        </p>

        <div className="mt-6 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {items.map((s) => (
            <ScenarioCard key={s.id} scenario={s} />
        ))}
        </div>
    </section>
    </main>
);
}