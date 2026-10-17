#!/bin/bash
cd /home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main
git init
git remote remove origin 2>/dev/null || true
git remote add origin "[suspicious link removed]"
git branch -M main
git add .
git commit -m "feat: sync geocentrum-main v158.1" --allow-empty
git push -u origin main --force
