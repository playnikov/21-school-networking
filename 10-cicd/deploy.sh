#!/bin/bash

if scp cat/s21_cat nataliam@10.20.0.10:~/ && scp grep/s21_grep nataliam@10.20.0.10:~/ ; then
  ssh nataliam@10.20.0.10 "sudo mv s21_cat s21_grep /usr/local/bin/"
  printf "\033[0;32mSUCCESS"
else
  printf "\033[0;31mFAILED COPY"
  exit 1
fi