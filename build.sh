#! /bin/mksh

_render() {
	for i in `cat "src/index"`; do
		if [ ! -f "gtk-3.0/img/$i.png" ]; then
			inkscape --export-png="gtk-3.0/img/$i.png" "src/img/$i.svg" > /dev/null
			inkscape --export-dpi=192 --export-png="gtk-3.0/img/$i@2.png" "src/img/$i.svg" > /dev/null
		fi
	done
}

_compile() {
	for t in "" "-dark"; do
		sassc "src/scss/gtk${t}.scss" "gtk-3.0/gtk${t}.css"
	done
}

_error() {
	echo -e "\033[38;5;1m $1 \n"
}

_success() {
	echo -e "\033[38;5;5m $1 \n"
}

echo ''

_render  || _error ' --- FAILED RENDERING IMAGES.' && _success ' --- DONE RENDERING IMAGES.'
_compile || _error ' --- FAILED COMPILING SCSS.'   && _success ' --- DONE COMPILING SCSS.'
