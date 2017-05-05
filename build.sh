#! /bin/sh

# This script listens for changes in the files contained 
# in the 'src' folder.
# Whenever a file is added or modified; the theme is
# rebuilt.
# 
# If you want to modify the images, first you must delete
# the old file from the 'src/img' directory and then
# modify the 

_render() {

	# - - - GTK-3

	for i in `cat "src/index"`; do

		img="gtk-3.0/img/$i"
		src="src/img/$i.svg"

		if [ ! -f "$img.png" ]; then
			inkscape -e "$img.png" "$src" > /dev/null
			inkscape -d 192 -e "$img@2.png" "$src" > /dev/null
		fi
	done

	# - - - GTK-2

	./gtk-2.0/render.sh
}

_compile() {
	for t in "" "-dark"; do
		sassc "src/scss/gtk${t}.scss" "gtk-3.0/gtk${t}.css"
	done
}

_error() {
	echo -e "\033[38;5;1m $@ \n"
}

_success() {
	echo -e "\033[38;5;5m $@ \n"
}

_main() {
	_render  ||
	_error ' - FAILED RENDERING IMAGES.' &&
	_success ' - DONE RENDERING IMAGES.'

	_compile ||
	_error ' - FAILED COMPILING SCSS.' &&
	_success ' - DONE COMPILING SCSS.'

	gtk3-widget-factory
}

_main

find 'src/' | entr -r -c -d -p -s ${PWD}/build.sh
