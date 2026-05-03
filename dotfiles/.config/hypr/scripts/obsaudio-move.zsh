#!/usr/bin/env zsh
HYPRSCRIPTS="${0:a:h}"
active_pid="$1"
active_sid="$("$HYPRSCRIPTS"'/pid-sink.zsh' "$active_pid")"

if [[ ! -z "$active_sid" ]]; then
  sink_name='obsaudio'
  pactl move-sink-input "$active_sid" "$sink_name"
  echo "$active_pid"' (#'"$active_sid"') -> '"$sink_name"'.monitor'
fi
