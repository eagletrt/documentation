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



value=$INPUT_FOLDERS
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
        end=$(( end - 1 ));
    fi
    dir=""
    filenames=$(ls -R $val1)   
    for f in $filenames */
    do
        f=${f%%:*}
        echo $f;
        if [[ -d $f || -d $val1"/"$f ]]; 
        then
            dir=${f/"/"/"_"}
            dir="_$dir"
        else
            ext=${f##*.}
            case $ext in
                c | cpp | h | hpp| py | js | java)
                    file=${f%%.*}
                    html="file$dir"_"$file"."$ext.html"
                    filepng=${file/"_"/"__"}
                    if [ $ext = "h" ];
                    then
                        png="html/$filepng"_"8$ext"__"dep__incl.png"
                    else
                        png="html/$filepng"_"8$ext""__incl.png"
                    fi
                    cd docs/_build/api
                    echo "Add dependencies graph to $html"
                    sed -i "s+<div role=\"main\" class=\"document\"+<div class=\"libGraph\"><img src=\"$png\" alt=\"depGraph\" style=\"position:relative;left: 5%;\"></div><div role=\"main\" class=\"document\"+" $html
                    cd - &> /dev/null
                    ;;
                *)
                    echo "$ext files not documented"
                    ;;
            esac 
        fi
    done
done
