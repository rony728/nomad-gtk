#! /bin/mksh

for i in `cat "src/index"`; do
	if [ ! -f "gtk-3.0/img/$i.png" ]; then
		inkscape --export-png="gtk-3.0/img/$i.png" "src/img/$i.svg" > /dev/null
		inkscape --export-dpi=192 --export-png="gtk-3.0/img/$i@2.png" "src/img/$i.svg" > /dev/null
	fi
done

echo -e "\n --- DONE RENDERING IMAGES --- \n"

for t in "" "-dark"; do
	sassc "src/scss/gtk${t}.scss" "gtk-3.0/gtk${t}.css"
done

echo " --- DONE COMPILING SCSS --- \n"
