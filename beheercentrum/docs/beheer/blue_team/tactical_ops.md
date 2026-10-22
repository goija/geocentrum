# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Command-Line Syntaxis Tabel
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | **Caution:** Let op bij copy/paste met streepjes: en/em-dash (`–`, `—`) vs ASCII hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en ontbrekende spaties in commando's |

## 2. VORTEX OS Stack Beheer (`start_vortex.sh`)
- **Volledige VORTEX stack starten (8080, 8000, 8081):** `./start_vortex.sh`
- **WebRTC DataChannel CLI Test (in venv):** `./webrtc_test_runner.sh`
- **Valideren & Synchroniseren naar GitHub/Vercel:** `./auto_sync.sh`
