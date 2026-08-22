# general functions for the program
function log() {
    echo $(date '+%F %T') $@
}
function info() {
    log INFO $@
}
function error() {
    log ERROR $@
    exit 1
}
function not_empty() {
    local -r arg=$1
    local -r name=$2
    if [[ -z "$arg" ]]; then
	error $name be provided
    else
	info ${name}: ${arg}
    fi
}

