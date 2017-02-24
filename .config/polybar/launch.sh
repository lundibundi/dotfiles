#!/usr/bin/env sh

# Terminate already running bar instances
killall -9 -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

if [ $(cat /sys/class/drm/card0-HDMI-A-1/status) == "connected" ] ; then
    MONITOR=HDMI1 polybar top &
    MONITOR=HDMI1 polybar bottom &
    polybar external_bottom &
else
    polybar top &
    polybar bottom &
fi

