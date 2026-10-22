#!/usr/bin/env python3
import os
import sys

MANDATORY_PATHS = [
    "config.json",
    "index.html",
    "beheercentrum/index.html",
    "beheercentrum/actuele_structuur.md",
    "docs/beheer/blue_team/ir_playbook.md",
    "docs/beheer/blue_team/tactical_ops.md",
    "docs/beheer/blue_team/system_hardening.md",
    "docs/beheer/blue_team/network_defense.md",
    "docs/beheer/red_team/rtfm_manual.md",
    "rekencentrum/",
    "auto_sync.sh",
    "start_services.py",
    "realtime_pipeline.sh"
]

def validate_repository():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    print(f"🔍 Validatie van VORTEX OS monorepo in: {base_dir}\n")
    missing_items = []
    for path in MANDATORY_PATHS:
        full_path = os.path.join(base_dir, path)
        if os.path.exists(full_path):
            print(f"  [ 🟢 OK ] {path}")
        else:
            print(f"  [ 🔴 ONTBREEKT ] {path}")
            missing_items.append(path)
    print("\n" + "="*40)
    if not missing_items:
        print("✅ Alle verplichte onderdelen zijn aanwezig!")
        sys.exit(0)
    else:
        print(f"⚠️ Waarschuwing: {len(missing_items)} item(s) ontbreken.")
        sys.exit(1)

if __name__ == "__main__":
    validate_repository()
