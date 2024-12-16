#!/bin/bash

# Skript: convert_asciidoc_to_html.sh
# Zweck: Automatische Konvertierung von AsciiDoc-Dateien (.adoc) in HTML
# Rekursive Verarbeitung aller Unterverzeichnisse

# Ausgangsverzeichnis (aktuelles Verzeichnis standardmäßig)
START_DIR=$(pwd)

echo "=========================================="
echo " Starte Konvertierung von AsciiDoc nach HTML"
echo " Verzeichnis: $START_DIR"
echo "=========================================="

# Findet alle .adoc-Dateien in allen Unterverzeichnissen und konvertiert sie
find "$START_DIR" -type f -name "*.adoc" | while read -r adoc_file; do
    # Ziel-HTML-Dateiname
    html_file="${adoc_file%.adoc}.html"
    
    # Konvertierung mit asciidoctor
    echo "Konvertiere: $adoc_file -> $html_file"
    asciidoctor "$adoc_file"
    
    # Überprüfen, ob die Konvertierung erfolgreich war
    if [[ $? -eq 0 ]]; then
        echo "✓ Erfolgreich konvertiert: $html_file"
    else
        echo "✗ Fehler bei der Konvertierung: $adoc_file"
    fi
done

echo "=========================================="
echo " Konvertierung abgeschlossen."
echo "=========================================="
