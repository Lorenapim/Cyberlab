--
-- PostgreSQL database dump
--

\restrict VOiy1mEhsnWJoZ3PcSvXR5c3ZK6UKypM3fb3sIxu6zkYIRxEAS8PPbvodNwyAIC

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-06 03:52:27

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
-- TOC entry 2 (class 3079 OID 16427)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


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
4d6a75d7-09b4-4de2-b680-cbb2a5195ece	usuario-demo	92dbe429-f9ab-4b02-846f-a4d3f928d738	56541469-b484-4ce5-9923-191833a0e399	B	t	2025-10-31 13:24:19.79552-03
1713bc74-d07f-47ef-8c3e-272379eaa47a	usuario-demo	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	B	t	2025-10-31 13:24:47.195356-03
28e90463-0be0-48f9-8039-265fdc31947c	usuario-demo	32d62adc-13cc-493b-83f7-49b4aaaeda7c	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	C	f	2025-10-31 18:08:37.796801-03
5631d632-4b66-45a3-b4e2-8dd7e8a72397	usuario-demo	e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	A	f	2025-12-05 23:55:42.914876-03
1f6fbf03-f87c-42b5-b5a6-f8386236168a	usuario-demo	3c538536-c84f-4ccd-9257-254db07dddd5	1128ee0b-1dc4-4441-95bf-908897f7adbf	A	t	2025-12-06 01:25:30.171373-03
cee2c99b-0370-4229-bcdc-b04c4a2b0337	usuario-demo	7ed958ac-d666-4526-893f-12eddb610396	7912c228-f7a2-449f-a512-8fe0ab19ce1e	B	f	2025-12-06 01:25:51.8764-03
07e1640f-55ac-4f87-ace0-4172c7b61dcb	usuario-demo	a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	d4999b9f-bd6b-4562-8913-5b40678d137f	A	f	2025-12-06 01:30:26.736799-03
a19abdf9-b394-4d83-adec-4a4a678cf760	usuario-demo	6720e6c1-0819-452a-bca7-b4bff66e633e	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	B	f	2025-12-06 01:56:42.969872-03
7c2e8a3d-f254-4642-b6c3-dacabeabf5cb	usuario-demo	2b263786-8b05-422c-857b-f2201817ccd6	9a4ce529-55fa-42ba-80f0-caf110060d0a	B	f	2025-12-06 02:34:18.021343-03
efcaacec-fdc2-4370-be2f-94c7a8859ed2	usuario-demo	b4726e9b-4fec-427c-8fe1-e49b31edf19f	8fe80527-5661-4fe4-a9ab-689a1fc7260f	C	t	2025-12-06 02:52:45.200595-03
\.


--
-- TOC entry 5083 (class 0 OID 16494)
-- Dependencies: 222
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, question_id, key, text, correct, explanation) FROM stdin;
5b70d1d3-b6dd-4877-849a-9520d8bc73c5	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	A	Cortas la llamada y llamas al número oficial del departamento de TI (o envías un ticket por el canal interno) para verificar la solicitud.	t	Verificación confirmada por TI. La llamada resultó ser fraudulenta. \n\nCortar y comunicarte por canales oficiales (teléfono de la organización, ticket interno) evita la suplantación y protege el entorno.
63f99e65-75f4-4278-a06d-de20585cc62b	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	C	Pides al supuesto técnico que envíe un correo desde su dirección institucional y sigues sus instrucciones sin notificar a nadie.	f	Un atacante puede falsificar remitentes o enviar correos aparentando ser institucionales. Confiar solo en un mensaje y actuar sin confirmar con TI a través de canales oficiales mantiene el riesgo activo. Seguir instrucciones no verificadas puede permitir instalación de malware o manipulación del equipo.
8ab902e5-5623-409e-a0f8-65f1c8591ed8	19d5fd34-ee2e-4e32-8ef6-242cc48290fc	B	Proporcionas la contraseña y permites el acceso remoto para que lo solucionen rápido.	f	Compartir credenciales o permitir acceso remoto no solicitado facilita que un atacante tome control del equipo y de los sistemas internos. Los equipos de TI nunca piden contraseñas por teléfono, y conceder acceso sin validación compromete datos, cuentas y servicios críticos de la organización.
34f76c4a-4454-4028-bf51-e00b1ea366a7	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	B	No ingresar al enlace del correo, revisar el calendario oficial o escribir directamente a tu jefa por un canal interno para confirmar el cambio.	t	Excelente decisión. Confirmaste la autenticidad del enlace por un canal oficial antes de actuar.\n\n Revisar el calendario corporativo o contactar directamente evita caer en phishing de videoconferencia.
8fd2ff8e-db03-4a66-b98e-33940d0d65c4	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	A	Enviar un mensaje al grupo de trabajo para preguntar si alguien más recibió el nuevo enlace y unirse si otros lo confirman.	f	Consultar al grupo no garantiza autenticidad: si otros también recibieron el mensaje, todos podrían estar siendo víctimas del mismo intento de phishing. Validar con personas que también fueron objetivo no confirma el origen real del enlace y puede propagar el riesgo dentro del equipo.
b451dc58-a236-4c66-9696-df9f43e69a67	4dca3bdf-54aa-46c6-8ab5-2d47885a888c	C	Ingresar al nuevo enlace para evitar retrasarte, verificando luego si se trataba del enlace correcto.	f	Acceder primero y verificar después expone tu equipo a sitios falsos diseñados para robar credenciales o instalar malware. Un enlace malicioso puede capturar información apenas ingresas, por lo que actuar sin confirmar previamente compromete tu seguridad y la de la organización.
0d9a2c71-55f9-489b-b707-e89fd360f905	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	B	Reportar inmediatamente al área de TI y, si es posible, aislar el equipo de la red (desconectando Wi-Fi o cable).	t	Decisión adecuada. Aíslas el equipo y reportas al instante para que TI investigue y contenga el incidente.\n\nLa contención rápida y la notificación activan el procedimiento de respuesta y reducen el impacto.
ab964e88-7ad0-411e-918e-439c8a35ab7d	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	A	Ignorar el mensaje y seguir trabajando hasta que el sistema vuelva a la normalidad.	f	Omitir alertas de antivirus y señales de actividad anómala permite que una posible amenaza continúe propagándose. La inacción retrasa la contención y aumenta el impacto en otros equipos y servicios. Ignorar los síntomas compromete la detección temprana del incidente y dificulta su manejo.
eec8e577-afdd-42ec-936e-b4f286a74311	53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	C	Apagar el equipo para que el problema no avance	f	Apagar bruscamente el equipo puede interrumpir procesos que TI necesita analizar para identificar el origen del incidente. Además, apagar no evita que la amenaza ya haya afectado otros sistemas o la red interna. Sin un reporte previo, se pierde visibilidad y se dificulta la respuesta coordinada del equipo técnico.
48f2add7-5f18-4291-ad83-ba044bc78835	56541469-b484-4ce5-9923-191833a0e399	C	Conectarte a “Café_WiFi_Trabajo”, que tiene contraseña WPA2 entregada por el personal del local.	f	Aunque WPA2 es más seguro que una red abierta, sigue siendo una red pública donde otros usuarios autorizados podrían estar conectados. No garantiza privacidad total ni protege datos sensibles sin una VPN. Usarla para enviar información de clientes expone el tráfico a posibles interceptaciones dentro del mismo local.
5608aa88-53e8-4ee3-8ced-4f0a2e73290c	56541469-b484-4ce5-9923-191833a0e399	A	Usar la red “CaféLibre_Internet” porque no necesita contraseña y es más rápida.	f	Las redes abiertas sin cifrado permiten que cualquier persona conectada pueda observar o interceptar tu tráfico. Utilizarlas para enviar datos sensibles facilita ataques como sniffing o la captura de información personal. La velocidad no compensa el riesgo de exponer el informe y comprometer la privacidad de los clientes.
6d46cd60-23d0-4beb-a8ec-fdc15da0200f	56541469-b484-4ce5-9923-191833a0e399	B	Compartir internet desde tu teléfono (red móvil personal) o activar una VPN antes de conectarte.	t	Decisión ideal. Conexión móvil o VPN garantizan máxima privacidad.\n\nSon las opciones más seguras fuera de la oficina, ya que el tráfico se cifra completamente y no depende de redes públicas.
702e59f6-f0d9-44ed-a7b2-3b29b1275330	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	C	Eliminar el correo sin avisar a nadie para evitar riesgos.	f	Borrar el mensaje sin reportarlo impide que el área de TI investigue el intento de ataque y tome medidas preventivas para proteger al resto de la organización. No informar puede dejar a otros compañeros expuestos al mismo archivo malicioso y permitir que la campaña continúe sin ser detectada.
8713d9f6-2de0-4f94-9a50-2485e8d5e931	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	B	Descargar el archivo y abrirlo para revisarlo de inmediato, ya que proviene de un compañero.	f	Abrir un archivo ejecutable disfrazado sin validar su origen facilita la instalación de malware, especialmente si proviene de un remitente falsificado. Los atacantes suelen imitar direcciones corporativas para generar confianza. Ejecutar el archivo sin verificación compromete tu equipo y los sistemas internos de la organización.
249a26e1-3558-4a75-a4ce-1b8b78dd64b7	9a4ce529-55fa-42ba-80f0-caf110060d0a	A	Revisas la dirección de correo y confirmas la solicitud llamando directamente al Director General por un canal conocido.	t	Verificación exitosa. Era un intento de phishing.\n\nConfirmar con la persona real antes de actuar evita fraudes y protege la información corporativa.
389401b6-033b-49ca-aebd-ce0ec0c23aaa	d4999b9f-bd6b-4562-8913-5b40678d137f	C	Compartir la publicación para advertir a tus contactos y que ellos también revisen.	f	Difundir enlaces no verificados amplifica la desinformación y puede exponer a otros a páginas maliciosas. Compartir antes de validar en fuentes oficiales contribuye a propagar estafas y campañas de phishing que usan contenido viral para atraer víctimas.
88d4607c-67cc-49b8-a066-023fe1559d9a	d4999b9f-bd6b-4562-8913-5b40678d137f	B	Ignorar la publicación, no abrir el enlace y verificar la noticia en un medio oficial o sitio confiable.	t	Buena decisión. Evitaste un sitio sospechoso y verificaste la información en fuentes confiables.\n\nAntes de abrir enlaces virales, revisa la dirección web y contrasta la información con medios oficiales o verificadores.
cf66ea4b-4949-4dc1-835f-e21f8115d12f	1128ee0b-1dc4-4441-95bf-908897f7adbf	A	Cambiar los permisos de acceso y limitarlo solo a los correos internos autorizados.	t	Acceso restringido correctamente. Solo el personal autorizado puede ver el informe.\n\nLimitar permisos a usuarios específicos y revisar el historial de acceso evita fugas de información.
e5d05f91-b6ee-4597-97dd-bfcc7270b92e	1128ee0b-1dc4-4441-95bf-908897f7adbf	B	Dejar el enlace como está, ya que solo el equipo tiene el acceso.	f	Mantener el enlace público permite que cualquier persona con el link acceda al documento, incluso fuera de la organización. No restringir el acceso a usuarios autenticados aumenta el riesgo de fuga de datos y dificulta controlar quién visualiza la información sensible.
e97e5ed7-2c92-4e96-a946-4fe769de073b	1128ee0b-1dc4-4441-95bf-908897f7adbf	C	Borrar el archivo y crear una nueva copia con los mismos datos públicos.	f	Eliminar el archivo no revierte la exposición ya ocurrida ni impide que terceros hayan descargado o compartido el contenido. Volver a subirlo sin corregir los permisos vuelve a dejar la información accesible y no soluciona la raíz del incidente.
ac241faa-e882-4365-a31c-1ec7e9650029	5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	A	Escanear el archivo con antivirus o verificar con el remitente real si él lo envió.	t	Excelente decisión: verificaste la fuente antes de actuar. El correo era un intento de ataque.\n\nEscanear los archivos con antivirus o confirmar con el remitente evita infecciones y protege tus datos.
0a8c6400-0751-4da1-9092-86c322f40ec9	7912c228-f7a2-449f-a512-8fe0ab19ce1e	C	Laura123 — tu nombre con una secuencia de números fácil de recordar.	f	Usar información personal como el nombre hace que la contraseña sea predecible y vulnerable a ataques de fuerza bruta o diccionario. Los atacantes prueban primero combinaciones comunes como nombres + números. Este tipo de contraseñas se descifra fácilmente y no protege cuentas internas.
5383ff68-de66-452d-b3b7-5413259be0f5	7912c228-f7a2-449f-a512-8fe0ab19ce1e	A	R3p*9#tE!92 — una combinación aleatoria de letras, números y símbolos.	t	Excelente: contraseña robusta creada. Buen uso de caracteres y longitud.\n\nContraseñas largas y aleatorias, combinadas con autenticación multifactor (MFA), reducen significativamente el riesgo de compromiso. Guarda la contraseña en un gestor seguro si no la recuerdas.
f3680dc2-9d7c-49f2-8e8c-be43c7c2d988	7912c228-f7a2-449f-a512-8fe0ab19ce1e	B	Reporte2024 — es simple y coincide con el nombre del sistema.	f	Las contraseñas basadas en palabras relacionadas al sistema o al trabajo son fáciles de adivinar y suelen aparecer en listas de contraseñas comunes. Su simplicidad y falta de variación (sin símbolos, números aleatorios o mayúsculas) la vuelven altamente vulnerable a ataques automatizados.
6738a92a-cad3-4989-be12-7bb3a93c587c	9a4ce529-55fa-42ba-80f0-caf110060d0a	C	Abres el archivo adjunto o haces clic en el enlace para verificar los datos.	f	Acceder a enlaces abreviados o adjuntos no verificados puede descargar malware o llevar a sitios falsificados diseñados para robar credenciales. La presencia de un dominio desconocido en el enlace y un reply-to diferente indica spoofing. Abrir el contenido sin confirmación incrementa el riesgo de infección y fraude.
6880d369-95d4-4a11-88ef-6d63bb6cb0f0	9a4ce529-55fa-42ba-80f0-caf110060d0a	B	Realizas la transferencia de inmediato para cumplir con la solicitud.	f	Efectuar un pago sin validar la autenticidad del correo facilita fraudes de ingeniería social conocidos como “CEO fraud”. Los atacantes imitan a directivos para generar presión y urgencia. Ejecutar la transferencia sin confirmación pone en riesgo fondos corporativos y compromete la seguridad financiera de la empresa.
abb027b6-4f2e-4c6f-bdce-9fbc824020a0	d4999b9f-bd6b-4562-8913-5b40678d137f	A	Abrir el enlace “solo para mirar” sin iniciar sesión ni descargar nada.	f	Ingresar a sitios desconocidos o con URLs sospechosas puede activar descargas automáticas, cargar scripts maliciosos o redirigirte a páginas diseñadas para robar información. Aunque no ingreses datos, simplemente abrir el enlace puede exponer tu equipo a malware o rastreadores usados en estafas y campañas fraudulentas.
49c582d8-27c6-4c46-be57-86dcd7a983ec	8fe80527-5661-4fe4-a9ab-689a1fc7260f	C	No completar el formulario, verificar con el área de TI o protección de datos si el correo es legítimo y reportarlo en caso de duda.	t	Muy bien. Has evitado una posible filtración de datos y seguiste el protocolo correcto.\n\nNunca entregues información personal o corporativa en formularios no verificados. Reportar permite investigar el origen del correo.
1af33784-8682-4440-b904-747dcff5fd2e	8fe80527-5661-4fe4-a9ab-689a1fc7260f	B	Llenar el formulario solo con los datos básicos (nombre y cargo) para cumplir con la solicitud sin exponer demasiado.	f	Completar un formulario dudoso, aunque sea parcialmente, igual entrega información válida que un atacante puede usar para ingeniería social. Si el correo es falso, cualquier dato enviado puede ser explotado para ataques más dirigidos.
62fae8eb-fa11-4622-ace6-dc435320a4e2	8fe80527-5661-4fe4-a9ab-689a1fc7260f	A	Responder al remitente pidiendo más información sobre el proceso antes de llenar el formulario.	f	Confiar en el remitente sin verificar puede facilitar ataques de phishing. Los atacantes suelen responder con rapidez y credenciales falsas para ganar tu confianza. Pedir más información no confirma legitimidad y puede llevarte a entregar datos sensibles.
\.


--
-- TOC entry 5082 (class 0 OID 16476)
-- Dependencies: 221
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, scenario_id, text, order_index) FROM stdin;
1128ee0b-1dc4-4441-95bf-908897f7adbf	3c538536-c84f-4ccd-9257-254db07dddd5	📤 Te das cuenta de que el informe con datos personales de clientes se compartió públicamente. ¿Qué deberías hacer?	0
19d5fd34-ee2e-4e32-8ef6-242cc48290fc	6720e6c1-0819-452a-bca7-b4bff66e633e	📞 Has recibido la llamada anterior. ¿Qué haces?	0
4dca3bdf-54aa-46c6-8ab5-2d47885a888c	e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	💻 ¿Qué deberías hacer en esta situación?	0
53aac1c0-5de5-47f3-8294-b2eb3af8cc4e	eb1cc2c3-76bb-4003-af0c-49c66c7c264c	🚨 ¿Cuál es la primera acción que debes realizar?	0
56541469-b484-4ce5-9923-191833a0e399	92dbe429-f9ab-4b02-846f-a4d3f928d738	📶 ¿Qué opción eliges para enviar el informe de forma segura?	0
5c1dc4de-a7ab-483b-9a9b-69fe2ba0ebee	32d62adc-13cc-493b-83f7-49b4aaaeda7c	🦠 Has recibido este correo con un archivo adjunto comprimido. ¿Qué deberías hacer?	0
7912c228-f7a2-449f-a512-8fe0ab19ce1e	7ed958ac-d666-4526-893f-12eddb610396	🔑 ¿Qué contraseña eliges para crear tu cuenta en el sistema interno?	1
8fe80527-5661-4fe4-a9ab-689a1fc7260f	b4726e9b-4fec-427c-8fe1-e49b31edf19f	🧾 ¿Qué deberías hacer ante este correo y formulario?	1
9a4ce529-55fa-42ba-80f0-caf110060d0a	2b263786-8b05-422c-857b-f2201817ccd6	📩 Has recibido el correo anterior en tu bandeja. ¿Qué haces?	1
d4999b9f-bd6b-4562-8913-5b40678d137f	a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	🌐 ¿Qué deberías hacer ante esta publicación?	0
\.


--
-- TOC entry 5081 (class 0 OID 16465)
-- Dependencies: 220
-- Data for Name: scenarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scenarios (id, title, description, created_at) FROM stdin;
2b263786-8b05-422c-857b-f2201817ccd6	Proteger contra Phishing, una de las tácticas de ataque más recurrentes en el mundo de la ciberseguridad.	emitente: Juan Pérez — Director General\nCorreo: juan.perez@empresa-grupo.com\nAsunto: URGENTE: Transferencia a proveedor (vencimiento hoy)\n\nCuerpo del mensaje:\n\nBuenas tardes,\n\nNecesito que proceses sólo hoy la transferencia de $3.200.000 a nuestro proveedor "Soluciones TI Ltda.". Adjunté el comprobante y la cuenta. Por favor realiza el pago y envíame el comprobante por esta vía.\n\nNo puedo atender llamadas ahora, es urgente.\n\nSaludos,\nJuan Pérez\nDirector General\n\nEl enlace del adjunto apunta a http://bit.ly/solicitapago123 (no a un dominio corporativo). El verdadero correo (encabezados) muestra reply-to: juan.perez@prov.example (dominio diferente).	2025-10-31 04:38:27.040152-03
32d62adc-13cc-493b-83f7-49b4aaaeda7c	Proteger contra Ransomware, un tipo de ataque que bloquea tus archivos y exige un rescate para recuperarlos.	Remitente: Carolina Rojas — Finanzas\nCorreo visible: carolina.rojas@empresa-interna.com\nAsunto: Revisión urgente del informe mensual\n\nCuerpo del mensaje:\n\nHola,\n\nNecesito que revises este informe urgente antes de la reunión de las 15:00. Está comprimido porque el sistema no permitía enviarlo como Word.\n\n[Adjunto: InformeUrgente.zip]\n\nAvísame cuando lo revises, por favor.\n\nSaludos,\nCarolina Rojas\nÁrea de Finanzas\n\nEl archivo ZIP contiene un ejecutable disfrazado con icono de Word (Informe.docx.exe).\nEl remitente usa una dirección muy similar a la corporativa, pero con una letra cambiada: carolina.rojas@empersa-interna.com.\n	2025-10-31 04:39:41.275971-03
3c538536-c84f-4ccd-9257-254db07dddd5	Proteger contra fugas de datos, evitando la exposición pública de información sensible en plataformas compartidas.	Tu jefa te pide compartir un informe en la nube para que el equipo de marketing lo revise. El documento contiene nombres, RUT, correos y direcciones de clientes.\nAl subirlo a Google Drive, eliges la opción “Cualquiera con el enlace puede ver” para que sea más rápido compartirlo. Horas después, descubres que el enlace fue reenviado fuera de la empresa.	2025-10-31 04:39:53.760861-03
6720e6c1-0819-452a-bca7-b4bff66e633e	Proteger contra la ingeniería social, técnicas de manipulación que buscan obtener credenciales o acceso mediante engaño.	Recibes una llamada de alguien que se identifica como del “Soporte Técnico”. Indica que detectaron actividad irregular en tu cuenta y que necesita acceder remotamente a tu equipo o que le proporciones tu contraseña para “restablecer la sesión”. La persona suena segura y afirma que es urgente para evitar pérdida de datos.\n\nEl número mostrado en la pantalla no coincide con la extensión interna y la persona solicita instalar una herramienta de acceso remoto o desactivar temporalmente el antivirus.	2025-10-31 04:39:14.639299-03
7ed958ac-d666-4526-893f-12eddb610396	Proteger contra contraseñas débiles, una de las causas más comunes de accesos no autorizados en entornos laborales.	Estás creando una nueva cuenta para acceder al sistema de reportes de la empresa. El sistema no te obliga a usar mayúsculas, números ni símbolos. Llevas varias tareas atrasadas y quieres terminar rápido, así que piensas en usar una contraseña fácil de recordar.	2025-10-31 04:33:44.914178-03
92dbe429-f9ab-4b02-846f-a4d3f928d738	Proteger el acceso a redes y dispositivos, evitando conexiones inseguras que puedan exponer información.	Estás en una cafetería terminando un informe con datos de clientes que debes enviar antes de una reunión. \nLa red Wi-Fi abierta “CaféLibre_Internet” no tiene contraseña y parece rápida, pero también ves otra red llamada \n“Café_WiFi_Trabajo”, que pide una contraseña de acceso entregada por el personal. \nTu teléfono tiene buena señal y podrías compartir internet con tus datos móviles, aunque te preocupa el consumo. No tienes configurada la VPN y el tiempo apremia: faltan solo 15 minutos para la reunión.\n\nAl revisar la red “CaféLibre_Internet”, observas que no tiene cifrado y cualquiera conectado podría ver tu tráfico.\nEn cambio, “Café_WiFi_Trabajo” utiliza seguridad WPA2 y requiere autenticación, lo que la hace más segura.	2025-10-31 04:38:10.752744-03
a82d77ba-bd7c-47c1-aeab-b1a90bfd7650	Promover la navegación segura, evitando acceder o compartir enlaces sospechosos en redes sociales.	Durante tu hora de almuerzo, estás navegando por redes sociales en tu computador del trabajo. Ves una publicación con el titular:\n\n“🚨 Último momento: se filtran datos de todas las cuentas bancarias del país — revisa si tu nombre aparece aquí 👇”\n\nEl enlace dirige a una página con un diseño similar a un medio de noticias, pero con una URL extraña (por ejemplo, noticias24-alerta.info).\nEn los comentarios, varios usuarios aseguran que “funciona” y recomiendan compartirlo.	2025-10-31 04:38:43.084247-03
b4726e9b-4fec-427c-8fe1-e49b31edf19f	Proteger los datos personales, evitando entregar información a fuentes no verificadas o formularios falsos.	Estás trabajando en el área de atención al cliente y recibes un correo de un proveedor externo que dice estar actualizando los registros de contacto de tu empresa. En el mensaje incluye un enlace a un formulario de Google con el asunto:\n\n“Actualización de datos de clientes – urgente completar antes del mediodía”.\n\nEl formulario solicita nombre completo, cargo, correo institucional y número de teléfono. Además, pide adjuntar una copia digital de tu cédula “para verificación”.\n\nEl remitente parece legítimo, pero no está en la lista oficial de proveedores con los que trabajas. El formulario no usa logotipo institucional ni política de privacidad. La dirección del enlace está acortada con un servicio como bit.ly, lo que impide ver el destino real.	2025-10-31 04:31:45.147037-03
eb1cc2c3-76bb-4003-af0c-49c66c7c264c	Responder ante incidentes priorizando contención y notificación, evitando acciones que eliminen evidencia.	Estás trabajando en un informe cuando tu equipo comienza a comportarse de forma extraña: las aplicaciones tardan en abrir, algunos archivos cambian de nombre y aparece un mensaje del antivirus que dice “actividad inusual detectada”.\n\nIntentas guardar tu trabajo, pero el sistema se congela por unos segundos.\nAl revisar, notas que varios compañeros mencionan en el chat interno que sus equipos también presentan lentitud y no pueden acceder al servidor de archivos compartido.\nTienes la duda de si deberías reiniciar el computador o esperar a ver si el sistema se recupera solo.	2025-10-31 04:38:59.331207-03
e0f99f80-fcf2-43f2-99de-54a1cc37bcb4	Proteger el trabajo remoto, verificando enlaces y remitentes antes de unirse a reuniones virtuales.	Estás trabajando desde casa y a punto de unirte a una reunión virtual con tu equipo.\nPocos minutos antes de la hora programada, recibes un correo con el asunto:\n\n“Cambio de enlace — reunión de coordinación 10:00 AM”.\nEl mensaje incluye un nuevo enlace a la videollamada (meet-empresa-support.com) y una nota que dice:\n“El enlace anterior presenta fallas. Únete aquí, por favor”.\nEl remitente parece ser tu jefa, pero su correo tiene un ligero cambio en el dominio (@empersasupport.cl en lugar de @empresasupport.cl).\nYa tienes el enlace oficial guardado en tu calendario, pero la hora está cerca y dudas cuál usar.	2025-10-31 04:39:27.908192-03
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
-- TOC entry 5090 (class 0 OID 0)
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


-- Completed on 2025-12-06 03:52:27

--
-- PostgreSQL database dump complete
--

\unrestrict VOiy1mEhsnWJoZ3PcSvXR5c3ZK6UKypM3fb3sIxu6zkYIRxEAS8PPbvodNwyAIC

