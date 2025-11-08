const BASE = import.meta.env.VITE_API_URL || 'http://localhost:4000';


export async function getScenarios() {
const r = await fetch(`${BASE}/scenarios`);
return r.json();
}


export async function getQuestionsByScenario(id) {
const r = await fetch(`${BASE}/questions/by-scenario/${id}`);
return r.json();
}


export async function postAnswer(payload) {
const r = await fetch(`${BASE}/answers`, {
method: 'POST',
headers: { 'Content-Type':'application/json' },
body: JSON.stringify(payload)
});
return r.json();
}


export async function getScore(userId) {
const r = await fetch(`${BASE}/answers/score/${userId}`);
return r.json();
}