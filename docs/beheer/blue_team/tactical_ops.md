# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Syntaxis & Copy/Paste Richtlijnen
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | Let op bij copy/paste met streepjes: onderscheid en/em-dash (`–`, `—`) en hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en ontbrekende spaties in commando's |

## 2. Operationeel Beheer
- **Poort 8082 vrijgeven:** `sudo fuser -k 8082/tcp`
- **Live poortstatus:** `python3 start_services.py`
