#!/usr/bin/env bash

docker run --rm -v "$(pwd)":/data bosa/writing_doc decktape --input slides.md --output slides.pdf
