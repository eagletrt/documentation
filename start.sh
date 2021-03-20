#!/bin/bash

set -e

INPUT_AUTHOR=${INPUT_AUTHOR:-'EagleTRT Team'}
INPUT_PROJECT=${INPUT_PROJECT:-'EagleTRT Project'}
INPUT_ROOTFILE=${INPUT_ROOTFILE:-'EagleTRT Title'}
INPUT_FOLDERS=${INPUT_FOLDERS:-'../utils'}
INPUT_VERSION=${INPUT_VERSION:-'EagleTRT Team'}
INPUT_RELEASE=${INPUT_RELEASE:-'EagleTRT Team'}
INPUT_LANGUAGE=${INPUT_LANGUAGE:-'EagleTRT Team'}

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
