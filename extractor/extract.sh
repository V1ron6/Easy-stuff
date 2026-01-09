#!/bin/bash

# Create extraction function
extract_archive() {
    file="$1"
    base="${file%.*}"   # filename without extension

    # Make target folder if not exists
    mkdir -p "$base"

    case "$file" in
        *.zip)
            unzip -o "$file" -d "$base"
            ;;
        *.rar)
            unrar x -o+ "$file" "$base/"
            ;;
        *)
            echo "Skipping unsupported file: $file"
            ;;
    esac
}

# Loop through zip and rar files in current directory
for f in *.zip *.rar; do
    [ -e "$f" ] || continue  # Skip if no files
    echo "Extracting $f ..."
    extract_archive "$f"
done

echo "✅ All archives extracted."
