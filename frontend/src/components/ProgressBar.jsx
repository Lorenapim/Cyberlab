export default function ProgressBar({ current, total }) {
const percent = Math.round((current/total)*100);
return (
<div style={{ margin:'8px 0 16px' }}>
<div style={{ height:10, background:'#eee', borderRadius:8, overflow:'hidden' }}>
<div style={{ width:`${percent}%`, height:'100%', background:'#4f46e5' }} />
</div>
<small>{current} / {total}</small>
</div>
);
}