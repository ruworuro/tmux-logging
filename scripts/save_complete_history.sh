#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"

main() {
	if supported_tmux_version_ok; then
		local file
		local history_limit
		file=$(expand_tmux_format_path "${save_complete_history_full_filename}")
		history_limit="$(tmux display-message -p -F "#{history_limit}")"
		tmux capture-pane -J -S "-" -p -e > "${file}"
		remove_empty_lines_from_end_of_file "${file}"
		display_message "History saved to ${file}"
	fi
}
main
