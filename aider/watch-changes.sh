#!/bin/sh

inotifywait -m -r -e modify,create,delete,move "${1:-.}"
