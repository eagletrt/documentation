#!/bin/bash

set -e

INPUT_AUTHOR=${INPUT_AUTHOR:-'EagleTRT Team'}
PROJECT_NAME=${PROJECT_NAME:-'EagleTRT Project'}
CAR=${CAR:-'CIAOOO'}
BAU=${BAU:-'INPUT= ../utils'}

DIR="$(dirname "${BASH_SOURCE[0]}")"

echo "Action directory: $DIR"
ls -al "$DIR/docs"

cp -R "$DIR/docs" "$GITHUB_WORKSPACE/docs"

sudo apt-get install doxygen python3-sphinx
pip3 install "breathe==4.12.0" exhale sphinx_rtd_theme

cd docs

sed -i "s/{{AUTHOR}}/$INPUT_AUTHOR/" conf.py
sed -i "s/{{PROJECT}}/$PROJECT_NAME/" conf.py
sed -i "s/{{VAL}}/$CAR/" conf.py
sed -i "s/{{MIAO}}/$BAU/" conf.py

sphinx-build --version
sphinx-build -b html ../docs ../docs/_build
