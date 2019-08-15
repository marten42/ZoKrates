#!/bin/bash

set -e

OPTS="all | compile | compute-witness | setup | generate-proof | export-verifier | output"

function usage() {
    echo "Usage: docker run -it -n [Name of the Zokrates container] 
    -v [/path/to/local_output_dir]:/home/zokrates/output
    [$OPTS].
    By default, /home/zokrates/examples in the container contains sample example files to compile on Zok. 
    To mount local dir to the container, use -v [/path/to/local_zok_code:/home/zokrates/zok_code].
    zok_code is a directory created within the image."
}

function zokrates-compile () {
    echo "Use local directory path within the container [examples/code_file.code] or [zok-code/code_file.code]. 
    See help for details."
    ./zokrates compile -i $1
}

function zokrates-compute-witness () {
    for arg in "$@"
        do
            var=$var$arg
        done
    list=$(echo $var | sed 's/./& /g')
    ./zokrates compute-witness -a $list
}

function zokrates-export-verifier () {
    ./zokrates export-verifier
}

function zokrates-generate-proof () {
    ./zokrates generate-proof
}

function zokrates-output () {
    mv out out.code proving.key verification.key verifier.sol witness proof.json /home/zokrates/output
    echo "Output files copied to local directory in the container.
    Mount local volume to replicate the files to local storage."
}

function zokrates-setup () {
    ./zokrates setup
}

case "$1" in
    "all")
         echo "Enter path to code file (see help for details):"
         read compile_file_path
         zokrates-compile $compile_file_path
         echo "Enter witness variables (space delimited):"
         read witness_var
         zokrates-compute-witness $witness_var
         zokrates-setup
         zokrates-generate-proof
         zokrates-export-verifier
         zokrates-output
         usage
         ;;
    "help")
            usage
            ;;
    "compile")
            shift
            zokrates-compile $1
            ;;
    "compute-witness")
            shift
            zokrates-compute-witness $@
            ;;
    "export-verifier")
            zokrates-export-verifier
            ;;
    "generate-proof")
            zokrates-generate-proof
            ;;
    "output")
            zokrates-output
            ;;
    "setup")
            zokrates-setup
            ;;
    
    *)
esac