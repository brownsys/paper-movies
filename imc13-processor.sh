#!/bin/bash

# Inspiration: https://www.youtube.com/watch?feature=player_embedded&v=hNENiG7LAnc
# Useful resolutions: http://pacoup.com/2011/06/12/list-of-true-169-resolutions/
# Montage examples: http://www.imagemagick.org/Usage/montage/

# we're going after a 1280x720 (aka 720p HD) resolution
# 1080p would be 1920x1080, so could have higher-quality video

rev=2
last_rev=92

repo=imc13cogent
output=ferguson-imc13.pdf

mkdir pdfs

while [ $rev -lt $((last_rev+1)) ]; do
    echo "Revision $rev..."
    cd $repo 
    svn up -r$rev >/dev/null
    cd tex
    cat Makefile | sed "s/%.bib \*.cls/\*.cls/" | sed "s/ \*.sty/ \*.cls/" > m2
    sed -i "" "s/pdflatex/pdflatex -interaction nonstopmode -halt-on-error/g" m2 
    mv Makefile Makefile.bak
    mv m2 Makefile
    make >/dev/null

    success=true

    if [ -f "$output" ]; then
        mv $output ../../pdfs/$rev.pdf
    else
        success=false
    fi

    make clean >/dev/null
    rm Makefile
    mv Makefile.bak Makefile
    cd ../..

    if $success; then
        cd pdfs
        montage $rev.pdf -tile 3x2 -background white -geometry 272x352-5+4 $rev.png
        cd ..
    fi

    rev=$((rev+1))
done

# We need to do some renumbering and cropping to make ffmpeg happy

cd pdfs

x=0
for f in `ls -1 *.png | grep -v "\-1.png" | sort -n`; do
    n=`printf "%03d" $x`
    mv $f $n.png
#    convert $n.png -crop 1280x568+0+0 a$n.png # the formula above results in 1281x568 images
#    mv -f a$n.png $n.png
    x=$((x+1))
done

rm *-1.png

ffmpeg -r 5 -i %03d.png -vcodec libx264 -pix_fmt yuv420p -b 8000k movie.mov
mv movie.mov ..

cd ..
