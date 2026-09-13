#!/usr/bin/env bash
# Build files/CV.pdf from cv.typ. Needs typst on the PATH.
set -euo pipefail
cd "$(dirname "$0")"
typst compile --font-path fonts cv.typ ../files/CV.pdf
echo "wrote files/CV.pdf"
