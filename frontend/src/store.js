import { create } from 'zustand';


const STORAGE_KEY = 'cybergame_local_v1';


const saved = (() => {
try { return JSON.parse(localStorage.getItem(STORAGE_KEY)) || null; } catch { return null; }
})();


const initial = saved ?? {
userId: 'usuario-demo',
answers: {}, // { [questionId]: { choiceKey, correct } }
score: 0
};


export const useGameStore = create((set, get) => ({
...initial,


getAnswer: (questionId) => get().answers?.[questionId] ?? null,


registerLocalAnswer: (questionId, choiceKey, correct) => {
const s = get();
if (s.answers[questionId]) return; // ya respondió
const next = {
...s,
answers: { ...s.answers, [questionId]: { choiceKey, correct } },
score: s.score + (correct ? 10 : 0)
};
set(next);
localStorage.setItem(STORAGE_KEY, JSON.stringify(next));
},


reset: () => {
const next = { userId: 'usuario-demo', answers: {}, score: 0 };
set(next);
localStorage.setItem(STORAGE_KEY, JSON.stringify(next));
}
}));