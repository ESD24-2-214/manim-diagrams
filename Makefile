##
# 1 semester rapport
#
# @file
# @version 0.1

all: build

clean:

build:
	echo SOURCE_DATE_EPOCH=$(date +%s)
	manim -p -ql main.py CreateCircle

image:
	manim main.py -s -qk -t --format=png

watch: image
	okular ./media/images/main/DefaultTemplate_ManimCE_v0.19.0.png &
	while inotifywait -e close_write main.py; do make image; done
