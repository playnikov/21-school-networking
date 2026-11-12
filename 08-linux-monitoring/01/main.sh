#!/bin/bash


if [[ $# -eq 1 ]]; then
  . ./error.sh
  echo $1
else
  echo "Введите один параметр!"
fi
