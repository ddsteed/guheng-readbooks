#!/usr/bin/env bash

# This script is to convert 顾衡好书榜 to different ebook formats.

function substitute () {
    file=$1
    
    echo " - replace special characters ... "

    sed -e '8,$s/\([^\#]|[^\.]|[^a-z]|[^\-]|[^\>]\) /\1/g' \
        -e '8,$s/,/，/g' \
        -e '8,$s/．/·/g' \
        -e '8,$s/⋯⋯/....../g' \
        -e '8,$s/⋯/....../g' \
        -e '8,$s/•/·/g' \
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
    titles=(顾衡读好书 雄性衰落)
#   titles=(顾衡读好书 雄性衰落 超级社会 自由的法 追逐荣耀 七年战争 查理五世 罗马帝国史 奥古斯都 恺撒 罗马共和国 历史的针脚 制造消费者 物流改变世界历史 了不起的面包 卡路里与束身衣 美国大萧条 议事的科学 元旦特辑 两个幸运的人 2022考试季 第三帝国 托克维尔回忆录 作茧自缚 儒家理想的信徒 不让生育的社会 上帝之饮 拜占庭的赠礼 丝绸之路 江户时代 人造肉 文明的崩塌 纸的文化史 发刊词)
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
            content=(${content[@]} 人造肉)
            content=(${content[@]} 江户时代)
            content=(${content[@]} 丝绸之路)
            content=(${content[@]} 拜占庭的赠礼)
            content=(${content[@]} 上帝之饮)
            content=(${content[@]} 不让生育的社会)
            content=(${content[@]} 儒家理想的信徒)
            content=(${content[@]} 作茧自缚)
            content=(${content[@]} 托克维尔回忆录)
            content=(${content[@]} 第三帝国)
            content=(${content[@]} 2022考试季)
            content=(${content[@]} 两个幸运的人)
            content=(${content[@]} 元旦特辑)
            content=(${content[@]} 议事的科学)
            content=(${content[@]} 美国大萧条)
            content=(${content[@]} 卡路里与束身衣)
            content=(${content[@]} 了不起的面包)
            content=(${content[@]} 物流改变世界历史)
            content=(${content[@]} 制造消费者)
            content=(${content[@]} 历史的针脚)
            content=(${content[@]} 罗马共和国)
            content=(${content[@]} 恺撒)
            content=(${content[@]} 奥古斯都)
            content=(${content[@]} 罗马帝国史)
            content=(${content[@]} 查理五世)
            content=(${content[@]} 七年战争)
            content=(${content[@]} 追逐荣耀)
            content=(${content[@]} 雅各布斯)
            content=(${content[@]} 自由的法)
            content=(${content[@]} 超级社会)
            content=(${content[@]} 雄性衰落)
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
        人造肉)
            content=(${content[@]} 人造肉)
            ;;
        江户时代)
            content=(${content[@]} 江户时代)
            ;;
        丝绸之路)
            content=(${content[@]} 丝绸之路)
            ;;
        拜占庭的赠礼)
            content=(${content[@]} 拜占庭的赠礼)
            ;;
        上帝之饮)
            content=(${content[@]} 上帝之饮)
            ;;
        不让生育的社会)
            content=(${content[@]} 不让生育的社会)
            ;;
        儒家理想的信徒)
            content=(${content[@]} 儒家理想的信徒)
            ;;
        作茧自缚)
            content=(${content[@]} 作茧自缚)
            ;;
        托克维尔回忆录)
            content=(${content[@]} 托克维尔回忆录)
            ;;
        第三帝国)
            content=(${content[@]} 第三帝国)
            ;;
        2022考试季)
            content=(${content[@]} 2022考试季)
            ;;
        两个幸运的人)
            content=(${content[@]} 两个幸运的人)
            ;;
        元旦特辑)
            content=(${content[@]} 元旦特辑)
            ;;
        议事的科学)
            content=(${content[@]} 议事的科学)
            ;;
        美国大萧条)
            content=(${content[@]} 美国大萧条)
            ;;
        卡路里与束身衣)
            content=(${content[@]} 卡路里与束身衣)
            ;;
        了不起的面包)
            content=(${content[@]} 了不起的面包)
            ;;
        物流改变世界历史)
            content=(${content[@]} 物流改变世界历史)
            ;;
        制造消费者)
            content=(${content[@]} 制造消费者)
            ;;
        历史的针脚)
            content=(${content[@]} 历史的针脚)
            ;;
        罗马共和国)
            content=(${content[@]} 罗马共和国)
            ;;
        恺撒)
            content=(${content[@]} 恺撒)
            ;;
        奥古斯都)
            content=(${content[@]} 奥古斯都)
            ;;
        罗马帝国史)
            content=(${content[@]} 罗马帝国史)
            ;;
        查理五世)
            content=(${content[@]} 查理五世)
            ;;
        七年战争)
            content=(${content[@]} 七年战争)
            ;;
        追逐荣耀)
            content=(${content[@]} 追逐荣耀)
            ;;
        雅各布斯)
            content=(${content[@]} 雅各布斯)
            ;;
        自由的法)
            content=(${content[@]} 自由的法)
            ;;
        超级社会)
            content=(${content[@]} 超级社会)
            ;;
        雄性衰落)
            content=(${content[@]} 雄性衰落)
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
