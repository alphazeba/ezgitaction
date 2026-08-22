#! /bin/bash
set -e
project_dir=""
git_url=""
run_script=""
git_branch=""

source ./functions.sh
source ./operations.sh

while getopts "p:g:r:b:" flag; do
    case "$flag" in
	p) project_dir="$OPTARG" ;;
	g) git_url="$OPTARG" ;;
	r) run_script="$OPTARG" ;;
	b) git_branch="$OPTARG" ;;
    esac
done

not_empty "$project_dir" "project dir"
not_empty "$git_url" "git url"
not_empty "$run_script" "run script"
not_empty "$git_branch" "git branch"

mkdir -p "$project_dir"
cd "$project_dir"

if [[ $(is_git_directory) == "false" ]]; then
    handle_new_directory
else
    handle_existing_directory
fi

info run completed succesfully
