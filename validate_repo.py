#!/usr/bin/env python3
import os
import sys
import stat

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
    "server_met_markdown.py",
    "test_webrtc_channel.py",
    "webrtc_test_runner.sh"
]

def validate_repository():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    print(f"🔍 Validatie van VORTEX OS monorepo in: {base_dir}\n")
    
    missing_items = []
    permission_issues = []

    for path in MANDATORY_PATHS:
        full_path = os.path.join(base_dir, path)
        if os.path.exists(full_path):
            print(f"  [ 🟢 OK ] {path}")
        else:
            print(f"  [ 🔴 ONTBREEKT ] {path}")
            missing_items.append(path)

    print("\n🔐 Controleren van cryptografische sleutelbestanden (.otp)...")
    otp_found = False
    for root, dirs, files in os.walk(base_dir):
        for file in files:
            if file.endswith('.otp'):
                otp_found = True
                otp_path = os.path.join(root, file)
                rel_path = os.path.relpath(otp_path, base_dir)
                
                file_mode = stat.S_IMODE(os.stat(otp_path).st_mode)
                if file_mode == 0o600:
                    print(f"  [ 🟢 OK ] Veilig (chmod 600): {rel_path}")
                else:
                    print(f"  [ ⚠️ WAARSCHUWING ] Onveilige permissies voor '{rel_path}' (huidig: {oct(file_mode)}, verwacht: 0600).")
                    permission_issues.append(rel_path)

    if not otp_found:
        print("  [ ℹ️ INFO ] Geen .otp sleutelbestanden aangetroffen in de actieve mappenstructuur.")

    print("\n" + "="*40)
    if not missing_items and not permission_issues:
        print("✅ Alle verplichte onderdelen en sleutelpermissies zijn 100% in orde!")
        sys.exit(0)
    else:
        print(f"⚠️ Waarschuwing: {len(missing_items)} ontbrekende item(s) en {len(permission_issues)} permissie-waarschuwing(en).")
        sys.exit(1)

if __name__ == "__main__":
    validate_repository()
