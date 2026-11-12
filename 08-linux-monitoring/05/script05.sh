#!/bin/bash

START_TIME=$(date +%s)

TOTAL_FOLDERS=$(find "$1" -type d | wc -l)
echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -sb "$1"/* 2>/dev/null | sort -hr | head -n 5 | awk '{printf "%d - %s, %.3f MB\n", NR, $2, $1/1024/1024}'

TOTAL_FILES=$(find "$1" -type f | wc -l)
echo "Total number of files = $TOTAL_FILES"

CONF_FILES=$(find "$1" -type f -name "*.conf" | wc -l)
TEXT_FILES=$(find "$1" -type f -exec file {} \; | grep -i "text" | wc -l)
EXEC_FILES=$(find "$1" -type f -executable | wc -l)
LOG_FILES=$(find "$1" -type f -name "*.log" | wc -l)
ARCHIVE_FILES=$(find "$1" -type f -regex '.*\.\(zip\|tar\|gz\|bz2\)' | wc -l)
SYMLINKS=$(find "$1" -type l | wc -l)

echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONF_FILES"
echo "Text files = $TEXT_FILES"
echo "Executable files = $EXEC_FILES"
echo "Log files (with the extension .log) = $LOG_FILES"
echo "Archive files = $ARCHIVE_FILES"
echo "Symbolic links = $SYMLINKS"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find "$1" -type f -exec du -sb {} + 2>/dev/null | sort -hr | head -n 10 | awk '{printf "%d - %s, %.3f MB\n", NR, $2, $1/1024/1024}' | while read -r line; do
    FILE_PATH=$(echo "$line" | awk '{print $3}' | sed 's/,//g')
    if [ -e "$FILE_PATH" ]; then
        FILE_TYPE=$(file -b --mime-type "$FILE_PATH" 2>/dev/null)
        echo "$line, $FILE_TYPE"
    else
        echo "$FILE_PATH, file not found"
    fi
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
find "$1" -type f -executable -exec du -sb {} + 2>/dev/null | sort -hr | head -n 10 | awk '{printf "%d - %s, %.3f MB\n", NR, $2, $1/1024/1024}' | while read -r line; do
    FILE_PATH=$(echo "$line" | awk '{print $3}' | sed 's/,//g')
    if [ -e "$FILE_PATH" ]; then
        MD5_HASH=$(md5sum "$FILE_PATH" 2>/dev/null | awk '{print $1}')
        echo "$line, $MD5_HASH"
    else
        echo "$line, file not found"
    fi
done

END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
echo "Script execution time (in seconds) = $ELAPSED_TIME"