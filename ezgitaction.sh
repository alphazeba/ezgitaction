#! /bin/bash
set -e
project_dir=""
git_url=""
run_script=""
git_branch=""
sleep_time="300" # 5 * 60 = 5mins


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source ${SCRIPT_DIR}/functions.sh
source ${SCRIPT_DIR}/operations.sh

while getopts "p:g:r:b:m:" flag; do
    case "$flag" in
	p) project_dir="$OPTARG" ;;
	g) git_url="$OPTARG" ;;
	r) run_script="$OPTARG" ;;
	b) git_branch="$OPTARG" ;;
	t) sleep_time="$OPTARG" ;;
    esac
done

not_empty "$project_dir" "project dir"
not_empty "$git_url" "git url"
not_empty "$run_script" "run script"
not_empty "$git_branch" "git branch"

mkdir -p "$project_dir"
cd "$project_dir"
# update project dir so it is no longer relative if it was
project_dir=$(pwd)

function main() {
    echo working directory $(pwd)
    if is_git_directory; then
	info "handling as new directory"
	handle_new_directory
    else
	info "handling as existing directory"
	handle_existing_directory
    fi
}

while true; do
    main
    info "sleeping for ${sleep_time}"
    sleep "$sleep_time"
done

info run completed successfully
