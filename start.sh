#!/bin/bash
# AgentKit — Startskript
# Der Nutzer führt aus: bash start.sh

set -e

echo ""
echo "==========================================================="
echo "   AgentKit — WhatsApp AI Agent Builder"
echo "==========================================================="
echo ""
echo "  Bereite deine Umgebung vor, um deinen KI-Agenten zu bauen..."
echo ""

# ── Python prüfen ─────────────────────────────────────────────
echo "  [1/4] Python wird geprüft..."
if ! command -v python3 &> /dev/null; then
    echo ""
    echo "  FEHLER: Python 3 nicht gefunden."
    echo "  Herunterladen unter: https://python.org/downloads"
    echo ""
    exit 1
fi

PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')
if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 11 ]); then
    echo ""
    echo "  FEHLER: Du benötigst Python 3.11 oder höher."
    echo "  Aktuelle Version: $(python3 --version)"
    echo "  Lade die neueste Version herunter unter: https://python.org/downloads"
    echo ""
    exit 1
fi
echo "  OK — $(python3 --version)"

# ── Claude Code prüfen ──────────────────────────────────────────
echo "  [2/4] Claude Code wird geprüft..."
if ! command -v claude &> /dev/null; then
    echo ""
    echo "  Claude Code ist nicht installiert."
    echo ""
    echo "  So installierst du es:"
    echo "    npm install -g @anthropic-ai/claude-code"
    echo ""
    echo "  Falls du npm/Node.js nicht hast:"
    echo "    https://nodejs.org (lade LTS herunter)"
    echo ""
    echo "  Nach der Installation führe einmal 'claude' aus, um dich zu authentifizieren,"
    echo "  und starte dann neu: bash start.sh"
    echo ""
    exit 1
fi
echo "  OK — Claude Code installiert"

# ── Basisordner erstellen ────────────────────────────────────────
echo "  [3/4] Ordner werden vorbereitet..."
mkdir -p knowledge
echo "  OK — Struktur bereit"

# ── Fertig ───────────────────────────────────────────────────────
echo "  [4/4] Alles geprüft"

echo ""
echo "==========================================================="
echo ""
echo "  Alles bereit. Öffne jetzt Claude Code:"
echo ""
echo "    claude"
echo ""
echo "  Und schreibe:"
echo ""
echo "    /build-agent"
echo ""
echo "  Claude Code begleitet dich Schritt für Schritt beim Aufbau"
echo "  deines personalisierten WhatsApp-KI-Agenten."
echo ""
echo "==========================================================="
echo ""
