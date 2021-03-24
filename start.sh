#!/bin/bash

set -e

INPUT_AUTHOR=${INPUT_AUTHOR:-'EagleTRT Team'}
INPUT_PROJECT=${INPUT_PROJECT:-'EagleTRT Project'}
INPUT_ROOTFILE=${INPUT_ROOTFILE:-'EagleTRT Title'}
INPUT_FOLDERS=${INPUT_FOLDERS:-'../utils'}
INPUT_VERSION=${INPUT_VERSION:-'1.0.0'}
INPUT_RELEASE=${INPUT_RELEASE:-'1.0.0'}
INPUT_LANGUAGE=${INPUT_LANGUAGE:-'c'}

DIR="$(dirname "${BASH_SOURCE[0]}")"

echo "Action directory: $DIR"
ls -al "$DIR/docs"

cp -R "$DIR/docs" "$GITHUB_WORKSPACE/docs"

sudo apt-get install doxygen python3-sphinx
pip3 install "breathe==4.12.0" exhale sphinx_rtd_theme

cd docs

sed -i "s/{{AUTHOR}}/$INPUT_AUTHOR/" conf.py
sed -i "s/{{PROJECT}}/$INPUT_PROJECT/" conf.py
sed -i "s/{{ROOTFILETITLE}}/$INPUT_ROOTFILE/" conf.py
sed -i "s+{{FOLDERS}}+$INPUT_FOLDERS+" conf.py
sed -i "s/{{VERSION}}/$INPUT_VERSION/" conf.py
sed -i "s/{{RELEASE}}/$INPUT_RELEASE/" conf.py
sed -i "s/{{LANGUAGE}}/$INPUT_LANGUAGE/" conf.py

sphinx-build --version
sphinx-build -b html ../docs ../docs/_build

cd -

sudo apt install graphviz
doxygen -g
sed -i "s+HAVE_DOT               = NO+HAVE_DOT               = YES+" Doxyfile
sed -i "s+RECURSIVE              = NO+RECURSIVE              = YES+" Doxyfile
sed -i "s+EXTRACT_ALL            = NO+EXTRACT_ALL            = YES+" Doxyfile
doxygen Doxyfile

cp -R **/*.png "html" "docs/_build/api"

ls -R utils

value="../utils"
end=1;
while [[ $end -ne 0 ]]
do
    val1=${value%% *}
    valP=${val1#*/}
    if [ $val1 == "../$valP" ] || [ $val1 == "./$valP" ] || [ $val1 == "/$valP" ] ;
    then
        val1=${val1#*/}
    fi

    val2=${value#* }
    if [[ $val2 != $value ]]
    then
        value=$val2
    else
        let "end = 0"
    fi
    echo "$val1"
    a=0
    filenames=$(ls -R $val1)   
    for f in $filenames */
    do
        
        boolDir=${f%:*}
        if [ $a -eq 0 ];
        then
            if [ $f != ${f%.*} ];
            then
                dir=${f%/*}
                if [ $dir == $f ];
                then
                    dir="";
                else
                    dirM=${dir/"/"/"_"}
                    while [[ $dirM != $dir ]]
                    do
                        dir=$dirM
                        dirM=${dirM/"/"/"_"}
                    done  
                    dir="_$dir"
                fi
            fi
        fi
        a=1
        if [[ $boolDir != $f ]]
        then
            dir=$boolDir
            dirM=${dir/"/"/"_"}
            while [[ $dirM != $dir ]]
            do
                dir=$dirM
                dirM=${dirM/"/"/"_"}
            done  
            dir="_$dir"                        
        fi
        ext=${f##*.}
        if [[ $ext != $f ]]
        then
            file=${f##*/}
            file=${file%.*}
            html="file$dir"_"$file"."$ext.html"
            filepng=${file/"_"/"__"}
            png="html/$filepng"_"8$ext"__"dep__incl.png"
            cd docs/_build/api
            echo "$html"
            #sed -i "s+<div class=\"wy-nav-content\">+<div class=\"libGraph\"><img src=\"$png\" alt=\"prova\"></div><div class=\"wy-nav-content\">+" $html
            cd - &> /dev/null
        fi    
    done   
done
