--
-- PostgreSQL database dump
--

\restrict 1xrky5nFugXmnvZcasYx0WVoMLdfyRVI7CTzXfmucLVjcF2LApti6vFqQON92CX

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-31 18:21:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16513)
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id text NOT NULL,
    scenario_id uuid NOT NULL,
    question_id uuid NOT NULL,
    choice_key character(1) NOT NULL,
    correct boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16494)
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    question_id uuid NOT NULL,
    key character(1) NOT NULL,
    text text NOT NULL,
    correct boolean DEFAULT false NOT NULL,
    explanation text
);


ALTER TABLE public.options OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16476)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    scenario_id uuid NOT NULL,
    text text NOT NULL,
    order_index integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16465)
-- Name: scenarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scenarios (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.scenarios OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16541)
-- Name: user_scores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_scores AS
 SELECT user_id,
    scenario_id,
    sum(
        CASE
            WHEN correct THEN 10
            ELSE 0
        END) AS score
   FROM public.answers
  GROUP BY user_id, scenario_id;


ALTER VIEW public.user_scores OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 16513)
-- Dependencies: 223
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answers (id, user_id, scenario_id, question_id, choice_key, correct, created_at) FROM stdin;
854cedd2-a236-4257-9661-082a1c823267	usuario-demo	b4726e9b-4fec-427c-8fe1-e49b31edf19f	f3863027-fb9b-4fbb-8ebc-a8bf36998495	A	f	2025-10-31 13:23:45.019634-03
6f431952-013d-4fdd-a1d3-85c8884c2008	usuario-demo	ec9a9ca9-1616-4c33-bd15-8ce02877eae4	b4a34b73-b4ef-4c1a-9cbd-2b76d91bac21	B	t	2025-10-31 13:23:58.691021-03
7a8ba8b5-147d-4ae6-b0a1-6f21f65bc035	usuario-demo	ec9a9ca9-1616-4c33-bd15-8ce02877eae4	d6bbf88d-ed7d-4c90-887d-2a32a47dfa14	B	t	2025-10-31 13:24:09.297567-03
4d6a75d7-09b4-4de2-b680-cbb2a5195ece	usuario-demo	92dbe429-f9ab-4b02-846f-a4d3f928d738	56541469-b484-4ce5-9923-191833a0e399	B	t	2025-10-31 13:24:19.79552-03
c152ab25-93d8-4851-9b3d-09e731de2efd	usuario-demo	92dbe429-f9ab-4b02-846f-a4d3f928d738	cf44667c-cec9-4180-882e-91ef2a771a27	A	t	2025-10-31 13:24:36.606765-03
1713bc74-d07f-47ef-8c3e-272379eaa47a	usuario-demo	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	B	t	2025-10-31 13:24:47.195356-03
588d26b7-c988-4ef7-af83-135952b277e6	usuario-demo	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	5ad69095-36b3-47e8-8071-3fa6bd28d934	B	t	2025-10-31 13:24:56.252061-03
f4426ccf-d414-49f0-b8d5-ee82f01cb1c0	usuario-demo	7ed958ac-d666-4526-893f-12eddb610396	f6332b0b-064a-4ae6-a601-6e8c0fa708b7	A	f	2025-10-31 18:08:30.894791-03
28e90463-0be0-48f9-8039-265fdc31947c	usuario-demo	32d62adc-13cc-493b-83f7-49b4aaaeda7c	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	C	f	2025-10-31 18:08:37.796801-03
\.


--
-- TOC entry 5083 (class 0 OID 16494)
-- Dependencies: 222
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, question_id, key, text, correct, explanation) FROM stdin;
f972d095-b7ca-4c70-a563-f522979fdb3b	f3863027-fb9b-4fbb-8ebc-a8bf36998495	A	Hacer clic y verificar	f	No hagas clic sin validar.
ce3e5b19-4d5f-499c-b7a1-233b2a6a0c17	f3863027-fb9b-4fbb-8ebc-a8bf36998495	B	Revisar remitente y pasar el mouse sobre el enlace	t	Validar dominio reduce el riesgo.
bdd0b406-722a-4318-bc85-d9ff20455750	f3863027-fb9b-4fbb-8ebc-a8bf36998495	C	Reenviar a todos para preguntar	f	Difundir correos maliciosos no es buena práctica.
5383ff68-de66-452d-b3b7-5413259be0f5	7912c228-f7a2-449f-a512-8fe0ab19ce1e	A	Reportar a TI y marcar como phishing	t	Ayuda a proteger a la organización.
f3680dc2-9d7c-49f2-8e8c-be43c7c2d988	7912c228-f7a2-449f-a512-8fe0ab19ce1e	B	Ignorar y borrar	f	Reportar permite bloquearlo para otros.
0a8c6400-0751-4da1-9092-86c322f40ec9	7912c228-f7a2-449f-a512-8fe0ab19ce1e	C	Responder pidiendo más info	f	Interactuar con el atacante aumenta el riesgo.
d88814b8-1d12-4a35-ab4d-7ed92a3f3107	f6332b0b-064a-4ae6-a601-6e8c0fa708b7	A	Hacer clic y verificar	f	No hagas clic sin validar.
150aae2a-bad9-42bf-a899-35c1d6d75630	f6332b0b-064a-4ae6-a601-6e8c0fa708b7	B	Revisar remitente y pasar el mouse sobre el enlace	t	Validar dominio reduce el riesgo.
18daed4a-3d66-4a35-ab25-2cc7e7eb906c	f6332b0b-064a-4ae6-a601-6e8c0fa708b7	C	Reenviar a todos para preguntar	f	Difundir correos maliciosos no es buena práctica.
912111c8-913b-4527-9f0b-6f6a7b8713ba	d6bbf88d-ed7d-4c90-887d-2a32a47dfa14	A	Pagar el rescate y recuperar acceso	f	Pagar incentiva el delito y no garantiza nada.
a9a52c2a-af12-44a2-a9d1-b09191a93223	d6bbf88d-ed7d-4c90-887d-2a32a47dfa14	B	Desconectar el equipo de la red y avisar a TI	t	Aísla el incidente y preserva evidencia.
9cb92d6b-b003-4665-b5f7-fcfa36ba9b1b	d6bbf88d-ed7d-4c90-887d-2a32a47dfa14	C	Reiniciar para ver si se arregla	f	Podrías dañar evidencia y no resolverás el problema.
e1f3d7bb-eaf9-49a0-b50a-26cc41e4067b	b4a34b73-b4ef-4c1a-9cbd-2b76d91bac21	A	Abrir el .zip para revisar	f	No abras adjuntos inesperados. Verifica remitente y política.
a494e72c-040e-4b23-9c38-3792b54d2baf	b4a34b73-b4ef-4c1a-9cbd-2b76d91bac21	B	Reportar a TI y no abrir el adjunto	t	Reportar permite bloquear antes de que se propague.
b9bef7ee-b39a-407a-a3fc-5aba33bde913	b4a34b73-b4ef-4c1a-9cbd-2b76d91bac21	C	Reenviar a compañeros para preguntar	f	Difunde el riesgo a otros. Evítalo.
bb3af46e-5fde-4ead-885d-fe9eac12a372	cf44667c-cec9-4180-882e-91ef2a771a27	A	Notificar al responsable de datos/Seguridad	t	Permite evaluar impacto y medidas.
941d1572-799d-463d-98f8-f4980f7d46b1	cf44667c-cec9-4180-882e-91ef2a771a27	B	Subir otra copia con los mismos permisos	f	Repite el problema.
eca65fbe-9632-4da0-85cf-8e593d0e80ff	cf44667c-cec9-4180-882e-91ef2a771a27	C	Compartir masivamente para “transparencia”	f	Aumenta el daño.
5608aa88-53e8-4ee3-8ced-4f0a2e73290c	56541469-b484-4ce5-9923-191833a0e399	A	Nada, total casi nadie lo verá	f	Riesgo alto: datos personales expuestos.
6d46cd60-23d0-4beb-a8ec-fdc15da0200f	56541469-b484-4ce5-9923-191833a0e399	B	Cambiar permisos a “Sólo internos/autorizados”	t	Limitar acceso corta la exposición.
48f2add7-5f18-4291-ad83-ba044bc78835	56541469-b484-4ce5-9923-191833a0e399	C	Borrar el archivo y olvidarlo	f	Debes notificar y registrar el incidente.
249a26e1-3558-4a75-a4ce-1b8b78dd64b7	9a4ce529-55fa-42ba-80f0-caf110060d0a	A	Mantener la calma y no ceder; verificar por canal oficial	t	La presión es típica del atacante.
6880d369-95d4-4a11-88ef-6d63bb6cb0f0	9a4ce529-55fa-42ba-80f0-caf110060d0a	B	Dar parcialmente la contraseña	f	Cualquier porción ya es comprometedora.
6738a92a-cad3-4989-be12-7bb3a93c587c	9a4ce529-55fa-42ba-80f0-caf110060d0a	C	Compartir preguntas y respuestas de seguridad	f	Material sensible.
2a8f70d7-7a62-4710-9194-d7954a2ffac1	42f14c1d-c11b-4ea7-8e95-2892b951613d	A	Dar la contraseña por teléfono	f	Política: jamás compartir credenciales.
27162932-4baa-42b7-ab45-6c1313badd84	42f14c1d-c11b-4ea7-8e95-2892b951613d	B	Colgar y reportar a TI por canal oficial	t	Corta el ataque y permite investigar.
fb097062-c344-45ce-ab9f-9efdbab5c3d3	42f14c1d-c11b-4ea7-8e95-2892b951613d	C	Enviar la contraseña por correo interno	f	Sigue siendo exposición de credenciales.
2e512186-f6ad-428b-b34d-5a109602eb09	2df570b3-fcaf-43fe-8d55-44f8a9a5917e	A	En notas del celular sin protección	f	Riesgo alto de exposición.
c5d2dbed-c2f4-4973-8392-cc3274652d47	2df570b3-fcaf-43fe-8d55-44f8a9a5917e	B	En un gestor de contraseñas confiable	t	Cifrado y sincronización segura.
cf1c7b69-5ca7-495e-b54e-4d46d585a11b	2df570b3-fcaf-43fe-8d55-44f8a9a5917e	C	Memorizar todas y reciclar cuando te olvides	f	Reciclar debilita la seguridad.
abb027b6-4f2e-4c6f-bdce-9fbc824020a0	d4999b9f-bd6b-4562-8913-5b40678d137f	A	Usar “123456” para recordar fácil	f	Muy predecible.
88d4607c-67cc-49b8-a066-023fe1559d9a	d4999b9f-bd6b-4562-8913-5b40678d137f	B	Usar frases largas + símbolos	t	Más longitud = más entropía y seguridad.
389401b6-033b-49ca-aebd-ce0ec0c23aaa	d4999b9f-bd6b-4562-8913-5b40678d137f	C	Usar tu fecha de nacimiento	f	Dato fácil de adivinar.
237efbc8-eb5d-4b40-ad5e-9bcfb7755a85	5ad69095-36b3-47e8-8071-3fa6bd28d934	A	Ignorar la alerta si no pasa nada	f	Nunca ignores alertas de seguridad.
8524a37f-bcd7-4dbc-bea0-72a4455fecca	5ad69095-36b3-47e8-8071-3fa6bd28d934	B	Desconectar el dispositivo y reportar	t	Reduce superficie y permite análisis.
9c890187-28ed-45b6-ac25-04d4b9a61915	5ad69095-36b3-47e8-8071-3fa6bd28d934	C	Desactivar el antivirus y continuar	f	Dejas el equipo desprotegido.
ab964e88-7ad0-411e-918e-439c8a35ab7d	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	A	Conectarlo para ver de quién es	f	USBs abandonados son un vector común.
0d9a2c71-55f9-489b-b707-e89fd360f905	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	B	Entregarlo a TI sin conectarlo	t	Evaluación segura y registrada.
eec8e577-afdd-42ec-936e-b4f286a74311	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	C	Llevarlo a casa y probarlo allá	f	Riesgo para tu equipo personal.
b45dd272-2c75-4822-8e21-a30e921f708a	90fd2f13-109b-40e2-911a-f3ad9309dae6	A	Desde sitios oficiales o verificados	t	Reduce riesgo de malware/troyanos.
84f65f66-35a6-4dc7-ab4f-6e8522fc5f5d	90fd2f13-109b-40e2-911a-f3ad9309dae6	B	Desde foros al azar por ser “gratis”	f	Alta probabilidad de infección.
ee574cec-c6d2-46a0-974d-d54e919f09ab	90fd2f13-109b-40e2-911a-f3ad9309dae6	C	Desde enlaces acortados desconocidos	f	Difícil verificar origen real.
5b70d1d3-b6dd-4877-849a-9520d8bc73c5	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	A	Usa HTTPS y certificado válido	t	Capa cifrada + identidad validada.
8ab902e5-5623-409e-a0f8-65f1c8591ed8	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	B	Que tenga muchos colores y animaciones	f	No es indicador de seguridad.
63f99e65-75f4-4278-a06d-de20585cc62b	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	C	Que pida desactivar el antivirus	f	Bandera roja evidente.
3e8c92db-1f48-405a-871a-dd39b684699d	ed8428a9-3ee7-4459-abcd-1e5a1986ff25	A	Sí, podría exponer información sensible	t	Evita que se vean datos internos.
53e3e254-073b-4118-b38f-6ec613339f48	ed8428a9-3ee7-4459-abcd-1e5a1986ff25	B	No, es sólo una foto bonita	f	El contexto puede filtrar secretos.
c6d75e23-f0e5-4622-97d5-482a3267cf4b	ed8428a9-3ee7-4459-abcd-1e5a1986ff25	C	Subirla en alta calidad para que se lea mejor	f	Empeora el riesgo.
8fd2ff8e-db03-4a66-b98e-33940d0d65c4	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	A	Aceptar todos los permisos por rapidez	f	Concede acceso innecesario.
34f76c4a-4454-4028-bf51-e00b1ea366a7	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	B	Rechazar permisos injustificados	t	Principio de mínima exposición.
b451dc58-a236-4c66-9696-df9f43e69a67	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	C	Instalar APK de terceros con permisos completos	f	Riesgo de malware.
2e5e480b-8d52-412d-99b7-2aa1785d059b	fc7500d8-9824-4dec-89ba-5647078cca11	A	Cambiar SSID y clave por defecto (WPA2/3)	t	Elimina credenciales por defecto.
e73a130d-b820-4560-8ec7-f2d437776035	fc7500d8-9824-4dec-89ba-5647078cca11	B	Desactivar cifrado para “mayor velocidad”	f	Exposición total del tráfico.
5fb24267-4a23-4468-b5d7-fba128fe18e8	fc7500d8-9824-4dec-89ba-5647078cca11	C	Compartir la clave con vecinos “de confianza”	f	Difunde acceso y responsabilidad.
ac241faa-e882-4365-a31c-1ec7e9650029	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	A	Usar VPN de la empresa	t	Cifra y encamina tráfico corporativo.
8713d9f6-2de0-4f94-9a50-2485e8d5e931	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	B	Compartir equipo con familiares	f	Riesgo de exposición/instalación software.
702e59f6-f0d9-44ed-a7b2-3b29b1275330	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	C	Dejar sesión abierta en lugares públicos	f	Riesgo de acceso no autorizado.
92943d64-568c-4827-bb98-33f91ad75a90	f28dd78e-f4b5-4e74-af27-ba7f413cf6fc	A	Notificar, documentar y preservar evidencia	t	Flujo básico del plan de respuesta.
7312fd05-f790-4466-aca6-ac4a5d017c89	f28dd78e-f4b5-4e74-af27-ba7f413cf6fc	B	Restaurar de backup sin avisar	f	Riesgo de reinfección y pérdida de evidencia.
37eda271-db88-4f1b-8130-9e0619b5a153	f28dd78e-f4b5-4e74-af27-ba7f413cf6fc	C	Publicarlo en redes sociales	f	Divulga información sensible.
cf66ea4b-4949-4dc1-835f-e21f8115d12f	1128ee0b-1dc4-4441-95bf-908897f7adbf	A	Desconectar de la red y avisar al equipo de respuesta	t	Contiene y activa el protocolo.
e5d05f91-b6ee-4597-97dd-bfcc7270b92e	1128ee0b-1dc4-4441-95bf-908897f7adbf	B	Borrar logs para “limpiar”	f	Destruye evidencia clave.
e97e5ed7-2c92-4e96-a946-4fe769de073b	1128ee0b-1dc4-4441-95bf-908897f7adbf	C	Ignorar hasta confirmar con un compañero	f	Demora la contención.
\.


--
-- TOC entry 5082 (class 0 OID 16476)
-- Dependencies: 221
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, scenario_id, text, order_index) FROM stdin;
f3863027-fb9b-4fbb-8ebc-a8bf36998495	b4726e9b-4fec-427c-8fe1-e49b31edf19f	¿Qué haces primero?	0
8fe80527-5661-4fe4-a9ab-689a1fc7260f	b4726e9b-4fec-427c-8fe1-e49b31edf19f	Detectas dominio sospechoso, ¿qué sigue?	1
7912c228-f7a2-449f-a512-8fe0ab19ce1e	7ed958ac-d666-4526-893f-12eddb610396	Detectas dominio sospechoso, ¿qué sigue?	1
f6332b0b-064a-4ae6-a601-6e8c0fa708b7	7ed958ac-d666-4526-893f-12eddb610396	¿Qué haces primero?	0
d6bbf88d-ed7d-4c90-887d-2a32a47dfa14	ec9a9ca9-1616-4c33-bd15-8ce02877eae4	Tu equipo muestra una pantalla de rescate. ¿Cuál es la primera acción?	1
b4a34b73-b4ef-4c1a-9cbd-2b76d91bac21	ec9a9ca9-1616-4c33-bd15-8ce02877eae4	Recibes un correo con adjunto .zip supuestamente de “RR.HH.”. ¿Qué haces?	0
cf44667c-cec9-4180-882e-91ef2a771a27	92dbe429-f9ab-4b02-846f-a4d3f928d738	Tras corregir permisos, ¿qué paso adicional es correcto?	1
56541469-b484-4ce5-9923-191833a0e399	92dbe429-f9ab-4b02-846f-a4d3f928d738	Publicaste un archivo con datos personales con “Cualquiera con el enlace”. ¿Qué haces de inmediato?	0
9a4ce529-55fa-42ba-80f0-caf110060d0a	2b263786-8b05-422c-857b-f2201817ccd6	El interlocutor presiona y amenaza con “suspender tu cuenta”. ¿Respuesta correcta?	1
42f14c1d-c11b-4ea7-8e95-2892b951613d	2b263786-8b05-422c-857b-f2201817ccd6	Alguien llama diciendo ser TI y pide tu contraseña “para arreglar un problema”. ¿Qué haces?	0
2df570b3-fcaf-43fe-8d55-44f8a9a5917e	a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	¿Cuál es la mejor forma de almacenar tus contraseñas?	1
d4999b9f-bd6b-4562-8913-5b40678d137f	a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	¿Qué opción es una buena práctica?	0
5ad69095-36b3-47e8-8071-3fa6bd28d934	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	Conectaste un USB y el antivirus alertó malware. ¿Acción inmediata?	1
53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	Encuentras un USB en el estacionamiento. ¿Qué haces?	0
90fd2f13-109b-40e2-911a-f3ad9309dae6	6720e6c1-0819-452a-bca7-b4bff66e633e	Al descargar software, ¿qué práctica es correcta?	1
19d5fd34-ee2e-4e32-8ef6-242cc48290fc	6720e6c1-0819-452a-bca7-b4bff66e633e	¿Qué indica que un sitio es más confiable para ingresar datos?	0
ed8428a9-3ee7-4459-abcd-1e5a1986ff25	e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	Compartes una foto del trabajo con pizarras visibles. ¿Riesgo?	1
4dca3bdf-54aa-46c6-8ab5-2d47885a888c	e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	Una app móvil pide acceso a contactos y ubicación para una calculadora. ¿Qué haces?	0
fc7500d8-9824-4dec-89ba-5647078cca11	32d62adc-13cc-493b-83f7-49b4aaaeda7c	¿Cómo proteger mejor una Wi-Fi doméstica?	1
5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	32d62adc-13cc-493b-83f7-49b4aaaeda7c	¿Qué práctica es correcta al trabajar desde casa?	0
f28dd78e-f4b5-4e74-af27-ba7f413cf6fc	3c538536-c84f-4ccd-9257-254db07dddd5	Tras contener, ¿qué sigue dentro del proceso formal?	1
1128ee0b-1dc4-4441-95bf-908897f7adbf	3c538536-c84f-4ccd-9257-254db07dddd5	Detectas comportamiento anómalo en tu equipo. ¿Primero?	0
\.


--
-- TOC entry 5081 (class 0 OID 16465)
-- Dependencies: 220
-- Data for Name: scenarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scenarios (id, title, description, created_at) FROM stdin;
b4726e9b-4fec-427c-8fe1-e49b31edf19f	Phishing por correo	Verifica remitente y dominio antes de hacer clic en enlaces sospechosos.	2025-10-31 04:31:45.147037-03
7ed958ac-d666-4526-893f-12eddb610396	Phishing por correo	Verifica remitente y dominio antes de hacer clic en enlaces sospechosos.	2025-10-31 04:33:44.914178-03
ec9a9ca9-1616-4c33-bd15-8ce02877eae4	Ransomware	Bloqueo de archivos y pedido de rescate; la prevención y respuesta temprana son clave.	2025-10-31 04:37:54.282358-03
92dbe429-f9ab-4b02-846f-a4d3f928d738	Fuga de datos	Documento confidencial compartido con acceso público por error.	2025-10-31 04:38:10.752744-03
2b263786-8b05-422c-857b-f2201817ccd6	Ingeniería social (vishing)	Llamada telefónica suplantando a Soporte para obtener accesos.	2025-10-31 04:38:27.040152-03
a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	Contraseñas seguras	Buenas prácticas de creación y gestión de contraseñas.	2025-10-31 04:38:43.084247-03
eb1cc2c3-76bb-4003-af0c-49c66c7c264c	Dispositivos externos (USB)	Riesgos de malware al conectar dispositivos desconocidos.	2025-10-31 04:38:59.331207-03
6720e6c1-0819-452a-bca7-b4bff66e633e	Navegación segura	Buenas prácticas al navegar y descargar contenido.	2025-10-31 04:39:14.639299-03
e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	Datos personales y privacidad	Minimiza exposición de datos y controla permisos.	2025-10-31 04:39:27.908192-03
32d62adc-13cc-493b-83f7-49b4aaaeda7c	Teletrabajo seguro	Conexiones seguras y cuidado del entorno doméstico.	2025-10-31 04:39:41.275971-03
3c538536-c84f-4ccd-9257-254db07dddd5	Respuesta ante incidentes	Acciones iniciales para contener, notificar y documentar.	2025-10-31 04:39:53.760861-03
\.


--
-- TOC entry 4926 (class 2606 OID 16528)
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- TOC entry 4928 (class 2606 OID 16530)
-- Name: answers answers_user_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_user_id_question_id_key UNIQUE (user_id, question_id);


--
-- TOC entry 4924 (class 2606 OID 16507)
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 16488)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 16475)
-- Name: scenarios scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scenarios
    ADD CONSTRAINT scenarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4931 (class 2606 OID 16536)
-- Name: answers answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- TOC entry 4932 (class 2606 OID 16531)
-- Name: answers answers_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES public.scenarios(id) ON DELETE CASCADE;


--
-- TOC entry 4930 (class 2606 OID 16508)
-- Name: options options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- TOC entry 4929 (class 2606 OID 16489)
-- Name: questions questions_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES public.scenarios(id) ON DELETE CASCADE;


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO cyber;


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE answers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.answers TO cyber;


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE options; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.options TO cyber;


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.questions TO cyber;


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE scenarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.scenarios TO cyber;


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE user_scores; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_scores TO cyber;


--
-- TOC entry 2105 (class 826 OID 16546)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO cyber;


-- Completed on 2025-10-31 18:21:45

--
-- PostgreSQL database dump complete
--

\unrestrict 1xrky5nFugXmnvZcasYx0WVoMLdfyRVI7CTzXfmucLVjcF2LApti6vFqQON92CX

