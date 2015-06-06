#!/usr/bin/env fish
set eink_refresh $argv[1]
set last (date +%s)
dbus-monitor --session "type='signal',interface='org.freedesktop.ScreenSaver',member='ActiveChanged'" | while read line
  # check is screensaver enabled
  if echo $line | grep -q 'boolean true'
    # to ignore double triggering
    if [ (expr (date +%s) - $last) -ge 5 ]
      set last (date +%s)
      sleep 1
      qdbus org.kde.screensaver /ScreenSaver SimulateUserActivity
      qdbus (qdbus | grep kscreenlocker_greet | sed 's/ //g') /MainApplication quit
      python3 /data/romas/projects/eink-refresh/eink-refresh.py
    end
  end
end
