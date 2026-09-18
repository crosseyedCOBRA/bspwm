#!/bin/sh
# Terminate already running polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch a bar on every connected monitor
if command -v polybar >/dev/null; then
    if type "xrandr" >/dev/null 2>&1; then
        for m in $(polybar --list-monitors | cut -d: -f1); do
            MONITOR=$m polybar --reload main &
        done
    else
        polybar --reload main &
    fi
fi
