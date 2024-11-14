#!/bin/bash

# Überprüfen, ob ein Pfad als Argument übergeben wurde
if [ -z "$1" ]; then
    echo "Bitte geben Sie einen Pfad an."
    exit 1
fi

# Übergebenen Pfad speichern
directory=$1

# Überprüfen, ob libreoffice installiert ist, und es gegebenenfalls installieren
if ! command -v libreoffice &> /dev/null; then
    echo "LibreOffice ist nicht installiert. Installiere LibreOffice..."
    sudo apt update
    sudo apt install -y libreoffice
else
    echo "LibreOffice ist bereits installiert."
fi

# Find-Befehl zum Durchsuchen des Verzeichnisses und Konvertieren der Dateien
find "$directory" -type f \( \
    -iname "*.ppt" -o -iname "*.pptx" -o \
    -iname "*.doc" -o -iname "*.docx" -o \
    -iname "*.xls" -o -iname "*.xlsx" \
\) | while read -r file; do
    echo "Konvertiere: $file"
    libreoffice --headless --convert-to pdf "$file" --outdir "$(dirname "$file")"
done
