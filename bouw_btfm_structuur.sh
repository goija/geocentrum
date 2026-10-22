#!/bin/bash

# ==============================================================================
# VORTEX OS - BTFM (Blue Team Field Manual) Architectuur Builder
# Genereert mappen en bestanden op basis van NIST & BTFM standaarden
# ==============================================================================

# Definieer de hoofdmap voor de Blue Team documentatie
BASE_DIR="docs/beheer/blue_team"

echo "🛡️ Start opbouw BTFM mappenstructuur in $BASE_DIR..."

# Maak de hoofddirectory aan
mkdir -p "$BASE_DIR"

# ------------------------------------------------------------------------------
# 0. PREPARATION (DOCUMENTATION REVIEW)
# ------------------------------------------------------------------------------
PREP_DIR="$BASE_DIR/0_preparation"
mkdir -p "$PREP_DIR"

# Key Documents en Review bestanden
cat << 'EOF' > "$PREP_DIR/key_documents.md"
# Key Documents (BTFM)
Hier worden alle essentiële netwerkschema's, VORTEX OS architectuurtekeningen (zoals Tijdscapsule en Monorepo diagrammen) en toegangslijsten gedocumenteerd.
EOF

cat << 'EOF' > "$PREP_DIR/review.md"
# Documentation Review (BTFM)
Logboek voor het periodiek beoordelen van het Juridisch Register, Operationeel Procesdossier en systeem hardening baselines.
EOF

# ------------------------------------------------------------------------------
# 1. IDENTIFY (SCOPE)
# ------------------------------------------------------------------------------
IDENTIFY_DIR="$BASE_DIR/1_identify"
mkdir -p "$IDENTIFY_DIR/scanning_vulnerabilities"
mkdir -p "$IDENTIFY_DIR/network_discovery"
mkdir -p "$IDENTIFY_DIR/windows_linux_hosts"

# Scanning & Vulnerabilities
touch "$IDENTIFY_DIR/scanning_vulnerabilities/nmap.md"
touch "$IDENTIFY_DIR/scanning_vulnerabilities/nessus.md"
touch "$IDENTIFY_DIR/scanning_vulnerabilities/openvas.md"

# Network Discovery & Hashing
touch "$IDENTIFY_DIR/network_discovery/dhcp.md"
touch "$IDENTIFY_DIR/network_discovery/dns.md"
touch "$IDENTIFY_DIR/network_discovery/hashing.md"
touch "$IDENTIFY_DIR/network_discovery/netbios.md"

# User Activity & Passwords
touch "$IDENTIFY_DIR/windows_linux_hosts/user_activity.md"
touch "$IDENTIFY_DIR/windows_linux_hosts/passwords.md"

# Voeg een standaard template toe aan NMAP als voorbeeld
cat << 'EOF' > "$IDENTIFY_DIR/scanning_vulnerabilities/nmap.md"
# NMAP Cheatsheet
Tactische commando's voor het scannen van de Tiny Server, localhost netwerken en VORTEX OS poorten (8000, 8081).
* Basis scan: `nmap -sV 127.0.0.1`
EOF

# ------------------------------------------------------------------------------
# 2. PROTECT (DEFEND)
# ------------------------------------------------------------------------------
PROTECT_DIR="$BASE_DIR/2_protect"
mkdir -p "$PROTECT_DIR"

cat << 'EOF' > "$PROTECT_DIR/disable_stop_services.md"
# Disable / Stop Services (BTFM)
Procedures voor het direct isoleren van de Python API of Podcast Server tijdens een incident.
* Voorbeeld commando: `systemctl stop podcast-rss-server`
EOF

# ------------------------------------------------------------------------------
# Afronding
# ------------------------------------------------------------------------------
echo "✅ BTFM mappen en 'Key Documents' succesvol ingebouwd!"
echo "📁 Navigeer naar $BASE_DIR om de structuur te bekijken."
tree "$BASE_DIR" 2>/dev/null || echo "(Tip: installeer 'tree' via 'sudo apt install tree' om de structuur visueel te zien in je terminal)"
