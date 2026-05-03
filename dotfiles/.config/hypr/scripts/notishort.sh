#!/usr/bin/env bash

tmpf='/tmp/ml4w-noti-'"$1"
replace_id=`[ -s "$tmpf" ] && cat "$tmpf" || echo 0`
notify-send -e -p -r "$replace_id" -t 1000 "$2" > "$tmpf"
