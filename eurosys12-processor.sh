#!/bin/bash

# Inspiration: https://www.youtube.com/watch?feature=player_embedded&v=hNENiG7LAnc
# Useful resolutions: http://pacoup.com/2011/06/12/list-of-true-169-resolutions/
# Montage examples: http://www.imagemagick.org/Usage/montage/

# we're going after a 1280x720 (aka 720p HD) resolution
# 1080p would be 1920x1080, so could have higher-quality video

# Internal notes:
# 191 is last rev with tex/ ... after this, switched to trunk/tex/ layout
# 217 is final revision

rev=194
last_rev=217

repo=nsdi12cosmos
output=paper.pdf

while [ $rev -lt $((last_rev+1)) ]; do
    echo "Revision $rev..."
    cd $repo
    svn up -r$rev >/dev/null
#   cd tex
    cd trunk/tex
    make >/dev/null
#    mv $output ../../pdfs/$rev.pdf
    mv $output ../../../pdfs/$rev.pdf
    make clean >/dev/null
#   cd ../..
    cd ../../..

    cd pdfs
    montage $rev.pdf -tile 7x2 -background white -geometry 213x275-15+4 $rev.png
    cd ..

    rev=$((rev+1))
done

# We need to do some renumbering and cropping to make ffmpeg happy

cd pdfs

x=0
for f in `ls -1 *.png | grep -v "\-1.png" | sort -n`; do
    n=`printf "%03d" $x`
    mv $f $n.png
    convert $n.png -crop 1280x568+0+0 a$n.png # the formula above results in 1281x568 images
    mv -f a$n.png $n.png
    x=$((x+1))
done

rm *-1.png

ffmpeg -r 5 -i %03d.png -vcodec libx264 -pix_fmt yuv420p -b 8000k movie.mov
mv movie.mov ..

cd ..
