#!/bin/bash
echo "Start Beheercentrum omgeving..."
cd ~/VORTEX_OS/beheercentrum
touch actuele_structuur.md index.html
python3 -m http.server 8080
