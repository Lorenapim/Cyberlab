import React from 'react';  
import { useGameStore } from '../store';
import { useMemo, useState } from 'react';


export default function QuestionView({ question, onAnswered, onNext }) {
const { id, text, options } = question;
const getAnswer = useGameStore(s => s.getAnswer);
const registerLocalAnswer = useGameStore(s => s.registerLocalAnswer);


const prev = getAnswer(id);
const [showFeedback, setShowFeedback] = useState(!!prev);


const choose = async (opt) => {
if (prev) return; // bloquea segunda respuesta en cliente
await onAnswered(opt.key, !!opt.correct);
registerLocalAnswer(id, opt.key, !!opt.correct);
setShowFeedback(true);
};


const chosen = useMemo(() => prev ? options.find(o => o.key === prev.choiceKey) : null, [prev, options]);


return (
<section style={{ border:'1px solid #eee', borderRadius:12, padding:16 }}>
<h3 style={{ marginTop:0 }}>{text}</h3>
<div style={{ display:'flex', flexDirection:'column', gap:10, marginTop:12 }}>
{options.map(opt => (
<button key={opt.key}
style={{ padding:'10px 12px', borderRadius:10, border:'1px solid #ddd', cursor: prev?'not-allowed':'pointer', opacity: prev?0.7:1 }}
disabled={!!prev}
onClick={() => choose(opt)}>
<b>{opt.key})</b> {opt.text}
</button>
))}
</div>


{showFeedback && (
<div style={{ marginTop:14 }}>
{ (prev?.correct)
? <p>✅ <b>Correcto</b>. {options.find(o=>o.key===prev.choiceKey)?.explanation}</p>
: <p>❌ <b>Incorrecto</b>. {options.find(o=>o.key===prev?.choiceKey)?.explanation}</p>
}
<button onClick={onNext} style={{ marginTop:8 }}>Siguiente</button>
</div>
)}
</section>
);
}