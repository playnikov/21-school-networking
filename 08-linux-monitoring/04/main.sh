#!/bin/bash

CONFIG_FILE="color.conf"
DEFAULT_CONFIG="color_default.conf"

clean_value() {
    echo "$1" | tr -d '[:space:]'
}

get_config_value() {
    local key=$1
    local config_file=$2
    if [ -f "$config_file" ]; then
        grep -E "^$key=" "$config_file" | cut -d'=' -f2
    else
        echo ""
    fi
}

get_config_value_with_default() {
    local key=$1
    local config_file=$2
    local default_config=$3
    local value
    local is_default=false

    value=$(get_config_value "$key" "$config_file")
    value=$(clean_value "$value") 
    if [ -z "$value" ]; then
        value=$(get_config_value "$key" "$default_config")
        value=$(clean_value "$value") 
        is_default=true
    fi
    echo "$value $is_default" 
}

column1_background=$(get_config_value_with_default "column1_background" "$CONFIG_FILE" "$DEFAULT_CONFIG")
column1_font_color=$(get_config_value_with_default "column1_font_color" "$CONFIG_FILE" "$DEFAULT_CONFIG")
column2_background=$(get_config_value_with_default "column2_background" "$CONFIG_FILE" "$DEFAULT_CONFIG")
column2_font_color=$(get_config_value_with_default "column2_font_color" "$CONFIG_FILE" "$DEFAULT_CONFIG")

column1_background_value=$(echo "$column1_background" | awk '{print $1}')
column1_background_default=$(echo "$column1_background" | awk '{print $2}')
column1_font_color_value=$(echo "$column1_font_color" | awk '{print $1}')
column1_font_color_default=$(echo "$column1_font_color" | awk '{print $2}')
column2_background_value=$(echo "$column2_background" | awk '{print $1}')
column2_background_default=$(echo "$column2_background" | awk '{print $2}')
column2_font_color_value=$(echo "$column2_font_color" | awk '{print $1}')
column2_font_color_default=$(echo "$column2_font_color" | awk '{print $2}')

. ./info.sh "$column1_background_value" "$column1_font_color_value" "$column2_background_value" "$column2_font_color_value"

get_color_name() {
    case $1 in
    1) echo "white";;
    2) echo "red";;
    3) echo "green";;
    4) echo "blue";;
    5) echo "purple";;
    6) echo "black";;
    *) echo "unknown";;
    esac
}

echo "Column 1 background = $(get_color_name $column1_background_value) ($column1_background_value) $( [ "$column1_background_default" = "true" ] && echo "(default)" )"
echo "Column 1 font color = $(get_color_name $column1_font_color_value) ($column1_font_color_value) $( [ "$column1_font_color_default" = "true" ] && echo "(default)" )"
echo "Column 2 background = $(get_color_name $column2_background_value) ($column2_background_value) $( [ "$column2_background_default" = "true" ] && echo "(default)" )"
echo "Column 2 font color = $(get_color_name $column2_font_color_value) ($column2_font_color_value) $( [ "$column2_font_color_default" = "true" ] && echo "(default)" )"