#!/bin/zsh

function path_loader () {
    local acc=""
    for p in "$@"; do
        if [ -d $p ]; then
            acc="$acc:$p"
        fi
    done
    export PATH="$PATH:$acc"
}
