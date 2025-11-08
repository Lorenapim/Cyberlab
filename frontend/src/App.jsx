import { Routes, Route, Link } from 'react-router-dom';
import Home from './pages/Home.jsx';
import Scenario from './pages/Scenario.jsx';
import Results from './pages/Results.jsx';


export default function App() {
const nav = { display:'flex', gap:12, padding:12, borderBottom:'1px solid #eee' };
return (
<div>
<nav style={nav}>
<Link to='/'>Inicio</Link>
<Link to='/results'>Resultados</Link>
</nav>
<Routes>
<Route path='/' element={<Home />} />
<Route path='/scenario/:id' element={<Scenario />} />
<Route path='/results' element={<Results />} />
</Routes>
</div>
);
}