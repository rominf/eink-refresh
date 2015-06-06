#!/usr/bin/env fish
set eink_refresh $argv[1]
dbus-monitor --session "type='signal',interface='org.freedesktop.ScreenSaver',member='ActiveChanged'" | while read line
  if echo $line | grep -q 'boolean true'
    sleep 1
    qdbus org.kde.screensaver /ScreenSaver SimulateUserActivity
    qdbus (qdbus | grep kscreenlocker_greet | sed 's/ //g') /MainApplication quit
    python3 /data/romas/projects/eink-refresh/eink-refresh.py
  end
end
