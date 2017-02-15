#! /bin/sh

for i in `cat "index"`; do
	if [ ! -f "img/$i.png" ]; then
		echo "Rendering icon $i.svg"
		inkscape --export-png="img/$i.png" "img/svg/$i.svg" > /dev/null
		inkscape --export-dpi=192 --export-png="img/$i@2.png" "img/svg/$i.svg" > /dev/null
	fi
done

for v in "gtk-3.0" "gtk-3.20"; do
	for t in "" "-dark"; do
		sassc --style compressed "${v}/scss/gtk${t}.scss" "${v}/gtk${t}.css"
	done
done
