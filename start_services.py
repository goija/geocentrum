#!/usr/bin/env python3
import json
import os
import subprocess
import sys

CONFIG_FILE = "config.json"

def load_config():
    if not os.path.exists(CONFIG_FILE):
        print(f"❌ Fout: {CONFIG_FILE} niet gevonden in de hoofdmap.")
        sys.exit(1)
    with open(CONFIG_FILE, "r", encoding="utf-8") as f:
        return json.load(f)

def display_status(config):
    print(f"=== {config['system']['name']} ({config['system']['environment']}) ===")
    print(f"OS: {config['system']['os']} | Hardware: {config['system']['hardware']}\n")
    print("📋 Geregistreerde Services:")
    
    for name, details in config.get("services", {}).items():
        port = details.get("port") or details.get("federation_port", "N/B")
        status = details.get("status", "geconfigureerd")
        print(f"  - {name.upper()}: poort {port} [status: {status}]")

def main():
    config = load_config()
    display_status(config)
    
    if len(sys.argv) > 1 and sys.argv[1] == "--start-beheer":
        port = config["services"]["beheercentrum"]["port"]
        path = config["services"]["beheercentrum"]["path"]
        print(f"\n🚀 Start Beheercentrum lokaal op poort {port} vanuit {path}...")
        os.chdir(path)
        subprocess.run(["python3", "-m", "http.server", str(port)])

if __name__ == "__main__":
    main()
