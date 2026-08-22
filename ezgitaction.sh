#! /bin/bash

project_dir=""
git_url=""
run_script=""

source ./functions.sh

while getopts "p:g:r:" flag; do
    case "$flag" in
	p) project_dir="$OPTARG" ;;
	g) git_url="$OPTARG" ;;
	r) run_script="$OPTARG" ;;
    esac
done

not_empty "$project_dir" "project dir"
not_empty "$git_url" "git url"
not_empty "$run_script" "run script"

# need to move to the project directory
# need to pull the git url
# need to run the script
