# AgentKit — WhatsApp AI Agent Builder

Baue deinen eigenen WhatsApp-Agenten mit künstlicher Intelligenz in weniger als 30 Minuten.
Du musst nicht programmieren können. Claude Code baut alles für dich.

<!-- ![AgentKit Demo](demo.gif) -->

---

## Was ist AgentKit?

AgentKit ist ein Projekt, das **Claude Code** (das Programmierwerkzeug von Anthropic)
verwendet, um einen vollständigen und personalisierten WhatsApp-Agenten für dein Unternehmen zu generieren.

Du beantwortest nur Fragen über dein Unternehmen. Claude Code kümmert sich um:
- Den gesamten Code schreiben
- Die WhatsApp-Verbindung einrichten
- Ein KI-„Gehirn" erstellen, das dein Unternehmen kennt
- Alles so vorbereiten, dass deine Kunden damit schreiben können

---

## Wie funktioniert es? (Der vollständige Ablauf)

### Schritt 1: Du klonst das Repo und führst einen Befehl aus

```bash
git clone https://github.com/Hainrixz/whatsapp-agentkit.git
cd whatsapp-agentkit
bash start.sh
```

`start.sh` prüft nur, ob du Python 3.11+ und Claude Code installiert hast.

### Schritt 2: Du öffnest Claude Code und schreibst /build-agent

```bash
claude
# Innerhalb von Claude Code schreibe:
/build-agent
```

Dies aktiviert das System. Claude Code liest die Anweisungen aus `CLAUDE.md` und beginnt
dich Schritt für Schritt zu begleiten.

### Schritt 3: Claude Code interviewt dich (5 Minuten)

Es stellt dir 10 Fragen, eine nach der anderen:

1. **Name deines Unternehmens** — z.B.: „Café Zum Guten Geschmack"
2. **Was dein Unternehmen macht** — z.B.: „Wir verkaufen Spezialitätenkaffee und hausgemachte Desserts"
3. **Wofür du den Agenten nutzen möchtest** — Fragen beantworten, Termine vereinbaren, Bestellungen aufnehmen, etc.
4. **Name des Agenten** — z.B.: „Sophie" (der Name, den deine Kunden sehen)
5. **Kommunikationston** — professionell, freundlich, verkaufsfördernd oder einfühlsam
6. **Öffnungszeiten** — z.B.: „Montag bis Freitag 9:00 bis 18:00 Uhr"
7. **Dateien über dein Unternehmen** — Menü, Preise, FAQ (legst du in den Ordner /knowledge)
8. **Anthropic API-Key** — der Schlüssel für die Nutzung von Claude KI (er begleitet dich dabei, ihn zu erhalten)
9. **WhatsApp-Anbieter** — du wählst zwischen Whapi.cloud, Meta oder Twilio
10. **Anbieter-Zugangsdaten** — der Token oder die Keys deines WhatsApp-Dienstes

### Schritt 4: Claude Code baut deinen Agenten (2-5 Minuten)

Mit deinen Antworten generiert er automatisch diese Dateien:

```
dein-projekt/
├── agent/                     ← DER VOLLSTÄNDIGE AGENT
│   ├── main.py                Webserver, der WhatsApp-Nachrichten empfängt
│   ├── brain.py               Verbindung mit Claude KI (das Gehirn)
│   ├── memory.py              Speichert den Verlauf jedes Kunden
│   ├── tools.py               Unternehmensspezifische Werkzeuge
│   └── providers/             Verbindung mit deinem WhatsApp-Dienst
│       ├── base.py            Gemeinsame Schnittstelle
│       ├── __init__.py        Wählt Anbieter automatisch aus
│       └── whapi.py           Adapter (oder meta.py, oder twilio.py)
│
├── config/                    ← KONFIGURATION
│   ├── business.yaml          Deine Unternehmensdaten
│   └── prompts.yaml           Der „Prompt", der die Persönlichkeit des Agenten definiert
│
├── knowledge/                 ← DEINE DATEIEN
│   └── (menu.pdf, preise.txt, etc.)
│
├── tests/
│   └── test_local.py          Chat-Simulator in deinem Terminal
│
├── requirements.txt           Python-Abhängigkeiten
├── Dockerfile                 Für Produktion
├── docker-compose.yml         Orchestrierung
└── .env                       Deine API-Keys (sicher, wird nie hochgeladen)
```

### Schritt 5: Du testest deinen Agenten im Terminal (5 Minuten)

Claude Code führt einen Chat-Simulator aus, bei dem DU schreibst als wärst du ein Kunde:

```
Du: Hallo, welche Öffnungszeiten habt ihr?
Agent: Hallo! Unsere Öffnungszeiten sind Montag bis Freitag von 9:00 bis 18:00 Uhr.
        Kann ich dir noch mit etwas anderem helfen?

Du: Was kostet der Americano?
Agent: Der Americano kostet 3,50 Euro.
        Möchtest du einen bestellen?
```

Wenn dir etwas nicht gefällt, sagst du es Claude Code und er passt es sofort an.

### Schritt 6: Deploy in die Produktion (optional, 10 Minuten)

Wenn du mit deinem Agenten zufrieden bist, begleitet dich Claude Code dabei, ihn online zu stellen:

1. **Claude Code bereitet dein Projekt vor** für die Produktion (passt die Konfiguration an)
2. **Du lädst es auf GitHub hoch** — Claude Code gibt dir die genauen Befehle, um dein Repo zu erstellen
3. **Du verbindest Railway** — gehst zu [railway.app](https://railway.app), gibst dein GitHub-Repo an und Railway deployt es automatisch
4. **Du konfigurierst die Variablen** — Claude Code sagt dir genau welche du in Railway setzen musst (dieselben API-Keys aus deiner .env)
5. **Du konfigurierst den Webhook** — Claude Code begleitet dich dabei, deinen WhatsApp-Anbieter mit der Railway-URL zu verbinden

Danach wird jede Person, die dir über WhatsApp schreibt, von deinem Agenten betreut.

**Hinweis:** Du musst nichts über Server oder Deploy wissen. Claude Code sagt dir jeden Schritt, was du schreiben und wo du klicken sollst.

---

## Wie funktioniert der Agent in der Produktion?

```
Ein Kunde schreibt „Hallo" über WhatsApp
         |
         v
Dein WhatsApp-Anbieter (Whapi/Meta/Twilio) empfängt die Nachricht
         |
         v
Sendet die Nachricht an deinen Railway-Server über Webhook
         |
         v
agent/providers/ → Normalisiert die Nachricht (jeder Anbieter hat ein anderes Format)
         |
         v
agent/memory.py → Sucht den Verlauf DIESES Kunden (nach Telefonnummer)
         |
         v
agent/brain.py → Sendet an Claude KI:
                 - Den System-Prompt (Persönlichkeit + Infos über dein Unternehmen)
                 - Den Gesprächsverlauf
                 - Die neue Kundennachricht
         |
         v
Claude KI generiert eine intelligente Antwort
         |
         v
agent/providers/ → Sendet die Antwort zurück über WhatsApp
         |
         v
Der Kunde erhält die Antwort in Sekunden
```

**Wichtige Hinweise:**
- Jeder Kunde hat seinen eigenen Verlauf. Wenn jemand mit dir schreibt und am nächsten Tag zurückkommt, erinnert sich der Agent an das vorherige Gespräch.
- Der Agent ERFINDET NIE Informationen. Er antwortet nur mit dem, was du ihm gegeben hast.
- Wenn er etwas nicht weiß, antwortet er: „Diese Information habe ich leider nicht, lass mich dich mit jemandem aus dem Team verbinden."

---

## Voraussetzungen

Du brauchst 4 Dinge bevor du anfängst:

### 1. Python 3.11 oder höher
- **Mac**: `brew install python` oder herunterladen von [python.org](https://python.org/downloads)
- **Windows**: Herunterladen von [python.org](https://python.org/downloads) (Haken bei „Add to PATH" setzen)
- **Linux**: `sudo apt install python3.11`
- Überprüfen: `python3 --version`

### 2. Claude Code
```bash
# Zuerst benötigst du Node.js: https://nodejs.org
npm install -g @anthropic-ai/claude-code

# Einmalig authentifizieren
claude
```

### 3. Anthropic API-Key
1. Gehe zu [platform.anthropic.com](https://platform.anthropic.com/settings/api-keys)
2. Erstelle ein Konto oder melde dich an
3. Gehe zu Settings → API Keys → Create Key
4. Kopiere den Key (beginnt mit `sk-ant-...`)

### 4. WhatsApp API-Konto (wähle eines)

| Anbieter | Schwierigkeit | Kosten | Am besten für |
|-----------|-----------|-------|--------------|
| [Whapi.cloud](https://whapi.cloud) | Einfach | Kostenlose Sandbox | Schnell starten, testen |
| [Meta Cloud API](https://developers.facebook.com) | Mittel | Kostenlos pro Gespräch | Ernsthafter Einsatz |
| [Twilio](https://twilio.com) | Mittel | Pro Nachricht bezahlen | Unternehmen, hohe Zuverlässigkeit |

**Falls du dir nicht sicher bist, starte mit Whapi.cloud.** Das ist die schnellste Option — du registrierst dich, kopierst einen Token, und fertig.

---

## Schnellstart (3 Befehle)

```bash
# 1. Repository klonen
git clone https://github.com/Hainrixz/whatsapp-agentkit.git
cd whatsapp-agentkit

# 2. Umgebung prüfen
bash start.sh

# 3. Claude Code öffnen und Agenten bauen
claude
# Schreibe: /build-agent
```

Claude Code begleitet dich von dort an. Beantworte einfach die Fragen.

---

## WhatsApp-Anbieter

AgentKit unterstützt 3 Anbieter. Du wählst beim Setup welchen du nutzen möchtest.

### Whapi.cloud (empfohlen für den Einstieg)
- Registriere dich bei [whapi.cloud](https://whapi.cloud)
- Sie haben eine kostenlose Sandbox (keine Verifizierung nötig)
- Du brauchst nur: **1 Token**
- Ideal zum Testen und für kleine Unternehmen

### Meta Cloud API (offiziell)
- Einrichten bei [developers.facebook.com](https://developers.facebook.com)
- Das ist die offizielle WhatsApp-API (von Meta/Facebook)
- Du brauchst: **Access Token** + **Phone Number ID** + **Verify Token**
- Erfordert ein verifiziertes Facebook Business-Konto
- Kostenlos pro Gespräch (zahlst nur für von dir initiierte Gespräche)

### Twilio
- Registriere dich bei [twilio.com](https://twilio.com)
- Sehr zuverlässig, ausgezeichnete Dokumentation
- Du brauchst: **Account SID** + **Auth Token** + **Telefonnummer**
- Hat eine Sandbox zum kostenlosen Testen
- Bezahlung pro Nachricht in der Produktion

---

## Anwendungsfälle

| Unternehmenstyp | Was der Agent macht | Beispiel |
|-----------------|-------------------|---------| 
| **Restaurant** | Beantwortet Fragen zu Menü, Öffnungszeiten, Standort | „Das Tagesgericht ist..." |
| **Klinik/Salon** | Vereinbart Termine und Reservierungen | „Dein Termin ist für Dienstag um 15 Uhr" |
| **Immobilien** | Qualifiziert Leads und sendet Immobilieninfos | „Wir haben 3 Wohnungen in deiner Preisspanne..." |
| **Online-Shop** | Nimmt Bestellungen per WhatsApp auf | „Deine Bestellung von 2 Kuchen wurde bestätigt" |
| **SaaS/Software** | Technischer Support nach dem Kauf | „Um dein Passwort zurückzusetzen, folge diesen Schritten..." |
| **Jedes Unternehmen** | Beantwortet häufige Fragen 24/7 | „Unsere Öffnungszeiten sind..." |

---

## Nützliche Befehle (nach dem Setup)

```bash
# Agenten ohne WhatsApp testen (Chat im Terminal)
python tests/test_local.py

# Server lokal starten
uvicorn agent.main:app --reload --port 8000

# Docker-Build für Produktion
docker compose up --build

# Agent-Logs anzeigen
docker compose logs -f agent
```

---

## Agent nach dem Setup anpassen

Du musst keinen Code anfassen. Öffne Claude Code und bitte um Änderungen in natürlicher Sprache:

```bash
# Ändern wie der Agent antwortet
claude "Der Agent ist zu förmlich. Mach ihn freundlicher und lockerer."

# Neue Informationen hinzufügen
claude "Wir haben einen neuen Lieferservice. Aktualisiere den Agenten."

# Ein Werkzeug hinzufügen
claude "Ich möchte, dass der Agent Terminverfügbarkeit prüfen kann."

# WhatsApp-Anbieter wechseln
claude "Ich möchte von Whapi zu Meta Cloud API migrieren."
```

---

## Technischer Stack

Für Neugierige — das wird unter der Haube verwendet:

| Komponente | Technologie | Wofür |
|-----------|-----------|--------|
| KI | Claude KI (claude-sonnet-4-6) | Generiert die intelligenten Antworten |
| Server | FastAPI + Uvicorn | Empfängt die WhatsApp-Webhooks |
| WhatsApp | Whapi.cloud / Meta / Twilio | Verbindet mit WhatsApp (du wählst) |
| Datenbank | SQLite (lokal) / PostgreSQL (Prod) | Speichert Gesprächsverläufe |
| Deploy | Docker + Railway | Stellt deinen Agenten ins Internet |
| Konfiguration | python-dotenv + YAML | Verwaltet API-Keys und Einstellungen |

---

## Architektur (für Entwickler)

```
WhatsApp (Kunde)
    |
    v
Anbieter (Whapi/Meta/Twilio) ←→ agent/providers/ (normalisiert Format)
    |
    v
FastAPI (agent/main.py) ←→ agent/memory.py (Verlauf SQLite)
    |
    v
Claude API (agent/brain.py) ←→ config/prompts.yaml (Persönlichkeit)
    |
    v
Antwort zurück über WhatsApp gesendet
```

Das System verwendet ein **Adapter-Muster** für WhatsApp-Anbieter. Jeder Anbieter
(Whapi, Meta, Twilio) implementiert dieselbe Schnittstelle, sodass `main.py` nicht weiß
und es nicht interessiert welchen du verwendest. Es ruft einfach `proveedor.parsear_webhook()` und
`proveedor.enviar_mensaje()` auf.

---

## Häufige Fragen

**Muss ich programmieren können?**
Nein. Claude Code schreibt den gesamten Code für dich. Du beantwortest nur Fragen.

**Was kostet es?**
- AgentKit ist kostenlos und Open Source
- Claude API: du zahlst pro Nutzung (~$3/Million Tokens, sehr günstig für einen Bot)
- WhatsApp: abhängig vom Anbieter (Whapi hat eine kostenlose Sandbox)
- Railway: kostenloser Plan für kleine Projekte verfügbar

**Kann ich das für mein echtes Unternehmen nutzen?**
Ja. Nach den lokalen Tests lädst du es auf Railway hoch und jeder Kunde,
der dir über WhatsApp schreibt, wird von deinem Agenten betreut.

**Was wenn der Agent etwas nicht weiß?**
Er antwortet ungefähr: „Diese Information habe ich leider nicht, lass mich dich mit jemandem
aus unserem Team verbinden." Er erfindet nie Daten.

**Kann ich mehrere Agenten haben?**
Ja. Klone das Repo mehrmals, einen pro Unternehmen. Jeder Agent ist unabhängig.

**Kann ich den WhatsApp-Anbieter später wechseln?**
Ja. Öffne Claude Code und sage ihm: „Ich möchte von Whapi zu Meta Cloud API wechseln."
Er generiert die nötigen Dateien neu.

---

## Danksagung

Erstellt von **Todo de IA** — [@soyenriquerocha](https://instagram.com/soyenriquerocha)

Gebaut mit [Claude Code](https://claude.ai/claude-code) für Builder aus LATAM.

---

## Lizenz

MIT — Verwende dieses Projekt wie du möchtest, für was auch immer du möchtest.
