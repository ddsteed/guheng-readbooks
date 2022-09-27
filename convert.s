#!/usr/bin/env bash

# This script is to convert 顾衡好书榜 to different ebook formats.

function substitute () {
    file=$1
    
    echo " - replace special characters ... "

    sed -e '8,$s/\([^\#]|[^\.]|[^a-z]|[^\-]|[^\>]\) /\1/g' \
        -e '8,$s/,/，/g' \
        -e '8,$s/．/./g' \
        -e '8,$s/⋯⋯/....../g' \
        -e '8,$s/⋯/....../g' \
        -e '8,$s/•/./g' \
        -e '8,$s/;/；/g' \
        -e '8,$s/?/？/g' \
        -e '8,$s/!/！/g' \
        -e '8,$s/——/---/g' \
        $file.md > $file_tmp.md

    # That *_tmp.md is empty means replacing special characters is NOT right.
    if [ -s $file_tmp.md ]; then
        mv $file_tmp.md  $file.md
    else
        echo "NOT succeed in replacing $file.md"
        exit
    fi
}

function m2e () {
    echo " - transform to epub ..."

    pandoc -s --toc --toc-depth=2 \
           --epub-cover-image=./fig/cover.png \
           $file.md -f markdown -o $file.epub
}

function m2p () {
    echo " - transform to pdf ..."

    pandoc --pdf-engine=xelatex \
           --toc -N \
           -V colorlinks -V urlcolor=NavyBlue \
           --highlight-style zenburn \
           $file.md -o $file.pdf
}

# ------------------------------------------------------------
# main function

if [[ $1 == "" ]]; then
    titles=(顾衡读好书 发刊词 纸的文化史 文明的崩塌)
else
    titles=($1)
fi

for title in ${titles[@]}; do
    content=()
    case $title in
        顾衡读好书)
            content=(${content[@]} 发刊词)
            content=(${content[@]} 纸的文化史)
            content=(${content[@]} 文明的崩塌)
           ;;
        发刊词)
            content=(${content[@]} 发刊词)
            ;;
        纸的文化史)
            content=(${content[@]} 纸的文化史)
            ;;
        文明的崩塌)
            content=(${content[@]} 文明的崩塌)
            ;;
   esac

    echo
    echo "*** To convert $title to different ebook formats *** "
    echo

    cp ./title/$title.md .

    for chapter in ${content[@]}; do
        cat md/$chapter.md >> $title.md
    done

    substitute $title
    m2e $title && mv $title.epub epub/.
    m2p $title && mv $title.pdf  pdf/.

    rm $title.md

done
