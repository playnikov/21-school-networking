#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Необходимо ввести 1 аргумент";
    exit 1;
fi

if [[ "$1" != */ ]]; then
    echo "Необходимо ввести путь к каталогу";
    exit 1;
fi

directory="$1"
. ./script05.sh $1