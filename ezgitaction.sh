#! /bin/bash
set -e
project_dir=""
git_url=""
run_script=""
git_branch=""
sleep_time="300" # 5 * 60 = 5mins

source ./functions.sh
source ./operations.sh

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
    if [[ $(is_git_directory) == "false" ]]; then
	handle_new_directory
    else
	handle_existing_directory
    fi
}

while true; do
    main
    sleep "$sleep_time"
done

info run completed successfully
