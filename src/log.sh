#!/usr/bin/env bash

# @file Log
# @brief Functions to facilitate logging in the script.

# @internal
# @description Terminal color for error messages.
_color_error=${_color_error:-"\e[0;91m"}

# @internal
# @description Terminal color for warning messages.
_color_warning=${_color_warning:-"\e[0;93m"}

# @internal
# @description Terminal color for highlight messages.
_color_highlight=${_color_highlight:-"\e[1;32m"}

# @internal
# @description Terminal color for informational messages.
_color_info=${_color_info:-"\e[0m"}

# @internal
# @description Terminal color for successful messages.
_color_success=${_color_success:-"\e[1;32m"}

# @internal
# @description Reset terminal color.
_color_reset=${_color_reset:-"\e[0m"}

# @description Print provided error message.
#
# @example
#   log::error An error occured
#
# @arg ... message to be printed.
#
# @stdout error message.
log::error() {
    echo -e "${_color_error}$@${_color_reset}"
}

# @description Print provided a success message.
#
# @example
#   log::success Something important succeeded
#
# @arg ... message to be printed.
#
# @stdout success message.
log::success() {
    echo -e "${_color_success}$@${_color_reset}"
}

# @description Print a warning message.
#
# @example
#   log::highlight Watch out, this is a warning
#
# @arg ... message to be printed.
#
# @stdout warning message.
log::warn() {
    echo -e "${_color_warning}$@${_color_reset}"
}

# @description Print a highlight message.
#
# @example
#   log::highlight Highlight this message
#
# @arg ... message to be printed.
#
# @stdout highlight message.
log::highlight() {
    echo -e "${_color_highlight}$@${_color_reset}"
}

# @description Print a informational message.
#
# @example
#   log::info An informational message
#
# @arg ... message to be printed.
#
# @stdout info message
log::info() {
    echo -e "${_color_info}$@${_color_reset}"
}

# @description Print provided error message with stack trace and
#              exit script with error code 1.
#
# @example
#   log::die "Unexpected and not handable error occured"
#
# @arg ... string variable name for the error message.
#
# @exitcode 1  Exit application in any case.
#
# @stdout error message and script stack trace
log::die() {
    log::error $@

    # build and print stacktrace with caller
    local cur_call=(${LINENO} ${FUNCNAME[0]} ${BASH_SOURCE[0]})
    local i=0
    while [[ ! -z "${cur_call[@]}" ]]; do
        echo -e "${_color_error}   ${cur_call[2]}:${cur_call[0]} - ${cur_call[1]}${_color_reset}"

        cur_call=($(caller $i))
        i=$((i+1))
    done
    exit 1
}

