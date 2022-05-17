#!/usr/bin/env bash

docker run --rm -v "$(pwd)":/data bosa/writing_doc concat --format slideshow --output readme.md
