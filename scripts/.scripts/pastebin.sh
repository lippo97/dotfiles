#!/bin/bash

usage() {
	echo "Usage: pastebin <file>"
}

if [[ -f $1 ]]; then
	curl -F c=@- https://ptpb.pw 2>/dev/null < $1 | yq .url | sed -e 's/^"//' -e 's/"$//' | xclip -selection c
else
	usage
fi
