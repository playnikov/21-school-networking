#!/bin/bash

if [[ $# -ne 4 ]]; then
  echo "Необходимо ввести 4 параметра"
  echo "Параметры числовые. От 1 до 6, например:"
  echo "main.sh 1 3 4 5"
  echo "Обозначения цветов: (1 — white, 2 — red, 3 — green, 4 — blue, 5 – purple, 6 — black)"
  exit 1
else
  . ./info.sh
fi
