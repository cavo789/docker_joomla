#!/usr/bin/env bash

docker run --rm -v "$(pwd)":/data bosa/writing_doc slideshow --input readme.md
