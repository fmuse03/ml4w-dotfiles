#!/usr/bin/env zsh
HYPRSCRIPTS="${0:a:h}"
active_pid="$1"
active_sid="$("$HYPRSCRIPTS"'/pid-sink.zsh' "$active_pid")"

if [[ ! -z "$active_sid" ]]; then
  default_sink="$(pactl get-default-sink)"
  pactl move-sink-input "$active_sid" "$default_sink"
  echo "$active_pid"' (#'"$active_sid"') -> '"$default_sink"
fi
