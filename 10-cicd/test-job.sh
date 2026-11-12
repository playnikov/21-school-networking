#!/bin/bash

# cat
cd cat/
make -s tests 2>/dev/null 1>../cat_test.txt

#grep
cd ../grep/
make -s tests 2>/dev/null 1>../grep_test.txt
cd ../



if ! grep -q "FAIL: 0" cat_test.txt || ! grep -q "FAIL_FUNC: 0" grep_test.txt || ! grep -q "FAIL_VALGRIND: 0" grep_test.txt; then
  grep -e 'FAILED' cat_test.txt
  grep -e 'FAILED' grep_test.txt
  exit 1;
fi

printf "test CAT:\n"
cat cat_test.txt

printf "\n\ntest GREP:\n"
cat grep_test.txt