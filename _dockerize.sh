#!/bin/sh

if ! docker ps 2>&1 > /dev/null; then
	sudo systemctl start docker
fi

docker run -it --rm --label=jekyll -p 127.0.0.1:4000:4000 --volume=$(pwd):/srv/jekyll jekyll/jekyll:pages jekyll serve --watch --drafts
