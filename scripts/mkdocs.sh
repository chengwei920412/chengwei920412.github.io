#!/bin/bash

cd "$(dirname "$0")"
THIS_FILE_PATH="$(pwd)"

install() {
    pip install mkdocs mkdocs-gitbook
    mkdocs --version
}

generate() {
    pushd $THIS_FILE_PATH/..//docs > /dev/null
    mkdocs build
    popd > /dev/null
}

serve() {
    pushd $THIS_FILE_PATH/..//docs > /dev/null
    mkdocs serve
    popd > /dev/null
}


usage() {
    cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --install     Install mkdocs and the mkdocs-gitbook theme (pip)
  --generate    Build static HTML from markdown sources
  --serve       Start the live-reload dev server (http://127.0.0.1:8000)
  --help        Show this message
EOF
}

if [[ $# -eq 0 ]]; then
    usage
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        --install)  install;  shift ;;
        --generate) generate; shift ;;
        --serve)    serve;    shift ;;
        --help)     usage;    exit 0 ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done
