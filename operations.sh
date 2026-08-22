function handle_new_directory() {
    git clone -b "$git_branch" "$git_url" .
    run_provided_script
}

function handle_existing_directory() {
    nuke_local_git_changes
    current_hash=$(local_git_hash)
    info local hash $current_hash
    remote_hash=$(remote_git_hash $git_branch)
    info remote hash $remote_hash

    if [[ "$current_hash" == "$remote_hash" ]]; then
	info project is up to date, nothing to do
    else
	git pull
	info project has been updated, building
	run_provided_script
    fi
}

function run_provided_script() {
    info "current working directory $(pwd)"
    $run_script
    info "completed run script"
}

function translate_windows_stupid_format() {
    local -r from_str=$1
    echo ${from_str/C:\//\/c\/}
}

function is_git_directory() {
    local -r current_dir=$(pwd)
    local -r git_dir=$(git rev-parse --show-toplevel)
    local -r output=$(translate_windows_stupid_format $git_dir)
    if [[ "$current_dir" == "$output" ]]; then 
	echo "true"
    else
	echo "false"
    fi
}
function nuke_local_git_changes() {
    info "nuking working directory at $(pwd)"
    git restore .
    git clean -f
    git clean -fd
}

function local_git_hash() {
    echo $(git rev-parse HEAD)
}

function remote_git_hash() {
    local -r branch=$1
    echo $(git ls-remote | grep ${branch} | cut -f 1)
}
