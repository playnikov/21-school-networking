#!/bin/bash

if [[ $1 =~ ^-?[0-9]+$ ]]; then
  echo "Введите текстовый параметр!"
  exit 1
fi