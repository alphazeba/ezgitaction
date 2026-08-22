source ./operations.sh

test_input="C:/Users/arnho/Projects/ezgitaction"
output=$(translate_windows_stupid_format "$test_input")
echo "$test_input -> $output"
echo the pwd $(pwd)
echo the git dir $(git rev-parse --show-toplevel)
answer=$(is_git_directory)
if [[ "$answer" == "true" ]]; then
	echo success
else
	echo FIAL
fi
