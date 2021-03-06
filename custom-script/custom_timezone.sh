#!/usr/bin/env bash
# Timezone to be used in vacuum

LIST_CUSTOM_PRINT_USAGE+=("custom_print_usage_01_timezone")
LIST_CUSTOM_PRINT_HELP+=("custom_print_help_01_timezone")
LIST_CUSTOM_PARSE_ARGS+=("custom_parse_args_01_timezone")
LIST_CUSTOM_FUNCTION+=("custom_function_01_timezone")

function custom_print_usage_01_timezone() {
    cat << EOF

Custom parameters for '${BASH_SOURCE[0]}':
[--timezone=Europe/Berlin]
EOF
}

function custom_print_help_01_timezone() {
    cat << EOF

Custom options for '${BASH_SOURCE[0]}':
  -t, --timezone             Timezone to be used in vacuum
EOF
}

function custom_parse_args_01_timezone() {
    case ${PARAM} in
        *-timezone|-t)
            TIMEZONE="$ARG"
            CUSTOM_SHIFT=1
            ;;
        -*)
            return 1
            ;;
    esac
}

function custom_function_01_timezone() {
    TIMEZONE=${TIMEZONE:-"Europe/Berlin"}
    echo "+ Replacing timezone"
    echo "$TIMEZONE" > "${IMG_DIR}/etc/timezone"

    if [ ! -r "${IMG_DIR}/etc/localtime" -a "${IMG_DIR}/usr/share/zoneinfo/${TIMEZONE}" ]; then
		ln -sr "${IMG_DIR}/usr/share/zoneinfo/${TIMEZONE}" "${IMG_DIR}/etc/localtime"
	fi
}
