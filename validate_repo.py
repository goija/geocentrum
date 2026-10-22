#!/usr/bin/env python3
import os
import sys
import stat

MANDATORY_PATHS = [
    "config.json",
    "index.html",
    "manifest.json",
    "beheercentrum/index.html",
    "rekencentrum/tijdscapsule/index.html",
    "rekencentrum/tijdscapsule/tijdscapsule_metadata.json",
    "docs/beheer/blue_team/ir_playbook.html",
    "docs/beheer/blue_team/tactical_ops.html",
    "docs/beheer/blue_team/system_hardening.html",
    "docs/beheer/blue_team/network_defense.html",
    "docs/beheer/red_team/rtfm_manual.html",
    "test_webrtc_channel.py",
    "webrtc_test_runner.sh",
    "auto_sync.sh"
]

def validate_repository():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    print(f"🔍 Validatie van VORTEX OS monorepo (Desktop + Mobile + WebRTC + Tijdscapsule):\n")
    missing = []
    perm_issues = []

    for p in MANDATORY_PATHS:
        if os.path.exists(os.path.join(base_dir, p)):
            print(f"  [ 🟢 OK ] {p}")
        else:
            print(f"  [ 🔴 ONTBREEKT ] {p}")
            missing.append(p)

    print("\n🔐 Controleren van FinalCrypt OTP-sleutelrechten (.otp)...")
    for root, _, files in os.walk(base_dir):
        if ".git" in root or "venv" in root:
            continue
        for file in files:
            if file.endswith(".otp"):
                full_p = os.path.join(root, file)
                mode = stat.S_IMODE(os.stat(full_p).st_mode)
                rel_p = os.path.relpath(full_p, base_dir)
                if mode == 0o600:
                    print(f"  [ 🟢 OK ] chmod 600 geverifieerd: {rel_p}")
                else:
                    print(f"  [ ⚠️ FOUT ] Onveilige rechten ({oct(mode)}) op: {rel_p}")
                    perm_issues.append(rel_p)

    print("\n" + "="*45)
    if not missing and not perm_issues:
        print("✅ Monorepo 100% gevalideerd voor Desktop, Mobiel & Vercel!")
        sys.exit(0)
    sys.exit(1)

if __name__ == "__main__":
    validate_repository()
