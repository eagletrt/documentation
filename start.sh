#!/bin/bash

set -e

INPUT_AUTHOR=${INPUT_AUTHOR:-'EagleTRT Team'}
INPUT_PROJECT=${INPUT_PROJECT:-'EagleTRT Project'}
INPUT_ROOTFILE=${INPUT_ROOTFILE:-'EagleTRT Title'}
INPUT_FOLDERS=${INPUT_FOLDERS:-'INPUT = ../utils'}

DIR="$(dirname "${BASH_SOURCE[0]}")"

echo "Action directory: $DIR"
ls -al "$DIR/docs"

cp -R "$DIR/docs" "$GITHUB_WORKSPACE/docs"
#cp "$DIR/docs/index.rst" "$GITHUB_WORKSPACE/docs"
#cp "$DIR/docs/Makefile" "$GITHUB_WORKSPACE/docs"
#cp "$DIR/docs/make.bat" "$GITHUB_WORKSPACE/docs"

sudo apt-get install doxygen python3-sphinx
pip3 install "breathe==4.12.0" exhale sphinx_rtd_theme

cd docs

sed -i "s/{{AUTHOR}}/$INPUT_AUTHOR/" conf.py
sed -i "s/{{PROJECT}}/$INPUT_PROJECT/" conf.py
sed -i "s/{{ROOTFILETITLE}}/$INPUT_ROOTFILE/" conf.py
sed -i "s+{{FOLDERS}}+$INPUT_FOLDERS+" conf.py


sphinx-build --version
sphinx-build -b html ../docs ../docs/_build
