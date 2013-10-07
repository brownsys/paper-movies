#!/bin/bash

movie_path=`pwd`
pdf_path="${movie_path}/pdfs"
repo_path="${HOME}/ibm/nsdi14-planck"
png_path="${movie_path}/pngs"

montage_path="/usr/local/Cellar/imagemagick/6.8.7-0/bin/montage"

start_commit="185ce43ff463fc716190eb0b60a23216b22fb16a"
end_commit="4bb68dc8e731e930d6730bd2f4a74aa3510cf32c"

mkdir -p $pdf_path
mkdir -p $png_path
cd $repo_path
make clean > /dev/null

git checkout $end_commit
if [ $? != 0 ]; then
    echo "unable to proceed"
    exit 1
fi
commits=`git log | egrep "^commit " | sed 's/commit //' | perl -e 'print reverse <>'`
count=0
for commit in $commits; do
    echo $commit
    if [ $start_commit == $commit ]; then
        echo "$start_commit $commit"
        count=1
    fi

    if [ $count -ge 1 ]; then
        git checkout $commit > /dev/null
        cp Makefile mk.bak
        sed -i "" "s/pdflatex/pdflatex -halt-on-error/g" Makefile
        cp ${movie_path}/Makefile .
        make > /dev/null
        if [ $? == 0 ]; then
            mv paper.pdf "${pdf_path}/${count}.pdf"
            n=`printf "%03d" $count`
            ${montage_path} "${pdf_path}/${count}.pdf" -tile 7x2 -background white -geometry 213x275-15+4 ${png_path}/${n}.png
            convert ${png_path}/${n}.png -crop 1280x568+0+0 ${png_path}/a.png
            mv ${png_path}/a.png ${png_path}/$n.png
            count=$(($count + 1))
        fi
        mv mk.bak Makefile
    fi
done

cd ${png_path}

#rename *-0.png to *.png (if they exist)
for f in `ls -1 *-0.png`; do
    mv $f `echo $f | sed 's/-0//'`
done
rm *-1.png
cd ..

ffmpeg -r 10 -i ${png_path}/%03d.png -vcodec libx264 -pix_fmt yuv420p -b 8000k movie.mov


