#!/bin/bash

# Funktion zur Bestimmung der Kategorie einer Datei
get_category() {
    case "$1" in
        pdf|docx|txt|doc|odt|rtf)
            echo "Dokumente"
            ;;
        png|jpg|jpeg|gif|bmp|tiff)
            echo "Bilder"
            ;;
        mp4|avi|mkv|mov|wmv)
            echo "Videos"
            ;;
        mp3|wav|flac|ogg|aac)
            echo "Audio"
            ;;
        ppt|pptx|odp)
            echo "Präsentationen"
            ;;
        zip|rar|tar|gz|7z)
            echo "Archive"
            ;;
        *)
            echo "Sonstige"
            ;;
    esac
}

# Array zur Speicherung der Kategorien und Dateien
declare -A categories

# Hauptscript
for file in *; do
    if [ -f "$file" ] && [ "$file" != "simple-sort.sh" ]; then
        ext="${file##*.}"
        category=$(get_category "$ext")
        mkdir -p "$category"
        mv "$file" "$category/"
        echo "Verschoben: $file nach $category/"
        
        # Füge die Datei zur entsprechenden Kategorie im Array hinzu
        categories["$category"]+="$file, "
    fi
done

echo "Sortierung abgeschlossen."

# Erstelle Markdown-Datei
echo "# Verschobene Dateien" > verschoben.md
echo "" >> verschoben.md
echo "| Kategorie | Dateien |" >> verschoben.md
echo "|-----------|---------|" >> verschoben.md

for category in "${!categories[@]}"; do
    files=${categories[$category]}
    # Entferne das letzte Komma und Leerzeichen
    files=${files%, }
    echo "| $category | $files |" >> verschoben.md
done

echo "Markdown-Datei 'verschoben.md' wurde erstellt."