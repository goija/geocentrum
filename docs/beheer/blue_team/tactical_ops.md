# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Command-Line Syntaxis Referentietabel
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | **Caution:** Let op bij copy/paste met streepjes: en/em-dash (`–`, `—`) vs ASCII hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en geen ontbrekende spaties in commando's |

## 2. VORTEX OS Dagelijkse Operaties
- **Start volledige pijplijn:** `./realtime_pipeline.sh`
- **Test WebRTC DataChannels (CLI):** `./webrtc_test_runner.sh`
- **Valideer & Sync naar GitHub/Vercel:** `./auto_sync.sh`
