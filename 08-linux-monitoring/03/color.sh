#!/bin/bash

fwhite="\033[97m"
fred="\033[91m"
fgreen="\033[92m"
fblue="\033[94m"
fpurple="\033[95m"
fblack="\033[30m"

bwhite="\033[107m"
bred="\033[101m"
bgreen="\033[102m"
bblue="\033[104m"
bpurple="\033[105m"
bblack="\033[40m"

end="\033[0;39m"

if [[ $1 == $2 || $3 == $4 ]]; then
  echo "Цвета шрифта и фона одного столбца не должны совпадать. Попробуй еще раз!"
  exit 1
fi

case $1 in
1) background_name=${fwhite};;
2) background_name=${fred};;
3) background_name=${fgreen};;
4) background_name=${fblue};;
5) background_name=${fpurple};;
6) background_name=${fblack};;
esac

case $2 in
1) font_name=${bwhite};;
2) font_name=${bred};;
3) font_name=${bgreen};;
4) font_name=${bblue};;
5) font_name=${bpurple};;
6) font_name=${bblack};;
esac

case $3 in
1) background_value=${fwhite};;
2) background_value=${fred};;
3) background_value=${fgreen};;
4) background_value=${fblue};;
5) background_value=${fpurple};;
6) background_value=${fblack};;
esac

case $4 in
1) font_value=${bwhite};;
2) font_value=${bred};;
3) font_value=${bgreen};;
4) font_value=${bblue};;
5) font_value=${bpurple};;
6) font_value=${bblack};;
esac