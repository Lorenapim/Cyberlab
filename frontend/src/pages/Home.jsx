import { useEffect, useState } from 'react';
import { getScenarios } from '../api';
import ScenarioCard from '../components/ScenarioCard';


export default function Home() {
const [items, setItems] = useState([]);
useEffect(() => { getScenarios().then(setItems); }, []);


return (
<main style={{ padding:20 }}>
<h1>CyberLab (React)</h1>
<p>Escoge un escenario y comienza. Cada correcta vale 10 puntos.</p>
<div style={{ display:'grid', gridTemplateColumns:'repeat(auto-fill, minmax(260px,1fr))', gap:16 }}>
{items.map(s => <ScenarioCard key={s.id} scenario={s} />)}
</div>
</main>
);
}