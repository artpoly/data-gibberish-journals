#!/usr/bin/env bash
set -eu
shopt -s nullglob

option="$1"

update=$(date +%Y-%m-%d )
echo "Process $option, update = $update"

echo "run $option"
##################################################
case $option in
"shit")
    python download-shit.py --config shit/config --pdf shit/pdf --limit 50 --pdf-limit 200 
    ;;

"rubbish")
    python download-rubbish.py --config rubbish/config.json --pdf rubbish/pdf
    ;;

"joker")
    python download-joker.py --config joker/config.json --pdf joker/pdf
    ;;

*)
    echo "Unknown case."
    ;;

esac
##################################################

pdf_count=$(find "$option" -name "*.pdf" | wc -l | xargs)
echo "pdf in $option = $pdf_count"

sed -i '' -E "s/(Update at:).*/\1 $update/" README.md
sed -i '' -E "s/($option.*papers:).*/\1 $pdf_count/" README.md

echo "Done"
