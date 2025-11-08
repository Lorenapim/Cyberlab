create extension if not exists "uuid-ossp";


-- Escenarios
create table if not exists public.scenarios (
id uuid primary key default uuid_generate_v4(),
title text not null,
description text,
created_at timestamptz default now()
);


-- Preguntas
create table if not exists public.questions (
id uuid primary key default uuid_generate_v4(),
scenario_id uuid not null references public.scenarios(id) on delete cascade,
text text not null,
order_index int not null default 0
);


-- Opciones
create table if not exists public.options (
id uuid primary key default uuid_generate_v4(),
question_id uuid not null references public.questions(id) on delete cascade,
key char(1) not null,
text text not null,
correct boolean not null default false,
explanation text
);


-- Respuestas de usuarios
create table if not exists public.answers (
id uuid primary key default uuid_generate_v4(),
user_id text not null, -- si luego usas auth real, migra a uuid
scenario_id uuid not null references public.scenarios(id) on delete cascade,
question_id uuid not null references public.questions(id) on delete cascade,
choice_key char(1) not null,
correct boolean not null default false,
created_at timestamptz default now(),
unique (user_id, question_id) -- bloquea segunda respuesta
);


-- Vista de puntaje por usuario
create or replace view public.user_scores as
select user_id, scenario_id,
count(*) filter (where correct) * 10 as score
from public.answers
group by user_id, scenario_id;

insert into public.scenarios (id, title, description)
values ('00000000-0000-0000-0000-000000000001','Phishing por correo','Verifica remitente y dominio antes de hacer clic.')
on conflict do nothing;


-- Preguntas
insert into public.questions (id, scenario_id, text, order_index)
values
('10000000-0000-0000-0000-000000000001','00000000-0000-0000-0000-000000000001','¿Qué haces primero?',0),
('10000000-0000-0000-0000-000000000002','00000000-0000-0000-0000-000000000001','Detectas dominio sospechoso, ¿qué sigue?',1)
ON CONFLICT DO NOTHING;


-- Opciones Q1
insert into public.options (question_id, key, text, correct, explanation)
values
('10000000-0000-0000-0000-000000000001','A','Hacer clic y verificar', false, 'No hagas clic sin validar.'),
('10000000-0000-0000-0000-000000000001','B','Revisar remitente y pasar el mouse sobre el enlace', true, 'Validar dominio reduce el riesgo.'),
('10000000-0000-0000-0000-000000000001','C','Reenviar a todos para preguntar', false, 'Difundir correos maliciosos no es buena práctica.');


-- Opciones Q2
insert into public.options (question_id, key, text, correct, explanation)
values
('10000000-0000-0000-0000-000000000002','A','Reportar a TI y marcar como phishing', true, 'Ayuda a proteger a la organización.'),
('10000000-0000-0000-0000-000000000002','B','Ignorar y borrar', false, 'Reportar permite bloquearlo para otros.'),
('10000000-0000-0000-0000-000000000002','C','Responder pidiendo más info', false, 'Interactuar con el atacante aumenta el riesgo.');