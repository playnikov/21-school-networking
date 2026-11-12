#!/bin/bash

if [[ $# -ne 0 ]]; then
  echo "Слишком много аргументов"
  exit 1
else
  . ./info.sh
fi

read -p "Сохранить данную информацию в файл? (Y/n) " answer
case $answer in
  y | Y)
      . ./write.sh
    ;;
esac