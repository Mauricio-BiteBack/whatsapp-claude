Lies die vollständige CLAUDE.md-Datei. Sie enthält alle detaillierten Anweisungen.

Führe den AgentKit-Onboarding-Ablauf durch und folge dabei den 5 Phasen IN REIHENFOLGE:

PHASE 1 — Willkommen und Umgebungsprüfung
- Zeige die Willkommensnachricht an
- Prüfe Python >= 3.11
- Erstelle die benötigten Ordner (agent/, agent/providers/, config/, knowledge/, tests/)
- Generiere requirements.txt und installiere Abhängigkeiten
- Erstelle .env-Basis

PHASE 2 — Unternehmensinterview
- Stelle die 10 Fragen EINE NACH DER ANDEREN
- Warte auf Antwort bevor du zur nächsten übergehst
- FRAGE 9: Der Nutzer wählt seinen WhatsApp-Anbieter (Whapi/Meta/Twilio)
- FRAGE 10: Frage nach den spezifischen Zugangsdaten des gewählten Anbieters
- Speichere alle Antworten für Phase 3

PHASE 3 — Agentengenerierung
- Generiere config/business.yaml mit Unternehmensdaten
- Generiere config/prompts.yaml mit starkem und spezifischem System-Prompt
- Falls Dateien in /knowledge vorhanden, lese und integriere sie in den Prompt
- Generiere agent/providers/ mit dem gewählten Anbieter (base.py + __init__.py + Adapter)
- Generiere agent/main.py (FastAPI + provider-agnostischer Webhook)
- Generiere agent/brain.py (Claude API)
- Generiere agent/memory.py (SQLite + Verlauf)
- Generiere agent/tools.py (Werkzeuge je nach Anwendungsfall)
- Generiere tests/test_local.py (Chat-Simulator)
- Generiere Dockerfile und docker-compose.yml
- Konfiguriere .env mit WHATSAPP_PROVIDER und den API-Keys des Nutzers

PHASE 4 — Lokaler Test
- Führe python tests/test_local.py aus
- Der Nutzer chattet mit seinem Agenten im Terminal
- Falls Anpassungen nötig, ändere prompts.yaml und wiederhole
- Gehe nicht ohne Genehmigung des Nutzers weiter

PHASE 5 — Deploy auf Railway
- Nur wenn der Nutzer es möchte
- Docker-Build + Railway-Anweisungen
- Webhook-Konfiguration spezifisch für den gewählten Anbieter

REGELN:
- Sprich immer auf Deutsch
- Eine Frage auf einmal
- Niemals API-Keys hardcoden
- Nicht ohne Bestätigung Phase wechseln
- Agent muss funktionieren bevor über Deploy gesprochen wird
- Generiere NUR den Adapter des gewählten Anbieters (nicht alle 3)
