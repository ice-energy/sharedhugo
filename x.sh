#!/bin/bash


rm -rf ./docs

hugo -c "./content" -d "./docs"

mv ./docs/img/README.txt ./docs/README.md


