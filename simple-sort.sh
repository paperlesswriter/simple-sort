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

# Hauptscript
for file in *; do
    if [ -f "$file" ]; then
        ext="${file##*.}"
        category=$(get_category "$ext")
        mkdir -p "$category"
        mv "$file" "$category/"
        echo "Verschoben: $file nach $category/"
    fi
done

echo "Sortierung abgeschlossen."
