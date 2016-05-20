#!/bin/bash

set -ex

OUTPUT_DIR="$(realpath ${1:-build})"
REVISION="${2:-master}"
VERSION="$(echo ${REVISION} | sed 's/^v//')"

unset GIT_DIR GIT_WORK_TREE

if [[ -d balde ]]; then
    pushd balde &> /dev/null
    git fetch -p
    popd &> /dev/null
else
    git clone https://github.com/balde/balde.git balde
fi

pushd balde &> /dev/null

git -c advice.detachedHead=false checkout "${REVISION}"

sed \
    -e 's/@PACKAGE_NAME@/balde/g' \
    -e "s/@PACKAGE_VERSION@/${VERSION}/g" \
    -e 's/@top_srcdir@/./g' \
    -e "s,^OUTPUT_DIRECTORY.*$,OUTPUT_DIRECTORY = ${OUTPUT_DIR}," \
    -e 's/^HTML_OUTPUT.*$/HTML_OUTPUT = doc/' \
    -e 's/^GENERATE_LATEX.*/GENERATE_LATEX = NO/' \
    Doxyfile.in > Doxyfile

doxygen Doxyfile

popd &> /dev/null
