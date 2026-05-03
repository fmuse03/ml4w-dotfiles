#!/usr/bin/env zsh
[[ -z "$1" ]] && exit 1
search_pid="$1"

alias rg1='rg -a -m 1 --no-messages'
alias fd_cmdline='fd -d 1 -t f -p '"'"'^/proc/\d+/cmdline$'"'"' /proc/*/'
alias sed_pid='sed '"'"'s=/proc/\(.\+\)/cmdline=\1='"'"
function SubSearchPid {
	search_cmdline='/proc/'"$search_pid"'/cmdline'
	bin_prefix='^/([A-Za-z0-9-@-]+/)*'

	match_vivaldi="$(rg1 -c "$bin_prefix"'vivaldi' "$search_cmdline")"
	if [[ "$match_vivaldi" == '1' ]]; then
    search_pid="$(rg1 -l "$bin_prefix"'vivaldi.* --utility-sub-type=audio' $(fd_cmdline) | sed_pid)"
    return 0
	fi
}

SubSearchPid

for sink_input in ${(s:Sink Input #:)"$(pactl list sink-inputs)"}; do
	sink_id="$(sed -n '1p' <<< "$sink_input")"
	sink_pid="$(rg -P --only-matching '(?<=application.process.id = ").+(?="$)' <<< "$sink_input")"

	if [[ "$search_pid" == "$sink_pid" ]]; then
	  echo "$sink_id"
	  break
	fi
done
