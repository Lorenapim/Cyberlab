import { Link } from 'react-router-dom';


export default function ScenarioCard({ scenario }) {
return (
<div style={{ border:'1px solid #eee', borderRadius:12, padding:16 }}>
<h3 style={{ marginTop:0 }}>{scenario.title}</h3>
<p style={{ color:'#555', minHeight:48 }}>{scenario.description}</p>
<Link to={`/scenario/${scenario.id}`}>
<button>Empezar</button>
</Link>
</div>
);
}