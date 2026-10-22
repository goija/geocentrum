#!/bin/bash
echo "🧪 VORTEX OS Rekenkernen Test Script..."

# Test de R-Simulatie
if command -v Rscript &> /dev/null; then
    echo "📊 Tzolk'in R-script uitvoeren..."
    Rscript rekenkernen/r_scripts/tzolkin_5fold_almanac.R
else
    echo "⚠️ Rscript is niet geïnstalleerd. Typ 'sudo apt install r-base' om dit op te lossen."
fi

echo ""

# Compileer en test de Rust-code
if command -v rustc &> /dev/null; then
    echo "⚙️ Rust Galois LFSR compileren en uitvoeren..."
    rustc rekenkernen/cpp_rust/lfsr_galois_generator.rs -o rekenkernen/cpp_rust/lfsr_generator
    ./rekenkernen/cpp_rust/lfsr_generator
else
    echo "⚠️ Rust compiler (rustc) is niet geïnstalleerd."
fi
