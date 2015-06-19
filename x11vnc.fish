#!/usr/bin/env fish

set mode_name "1200x825_3.00"

function display_off
  xrandr --rmmode $mode_name ^/dev/null >/dev/null
  xrandr --output VIRTUAL1 --mode $mode_name --off
end

function display_on
  xrandr --newmode $mode_name 3.50 1200 1232 1344 1488 825 828 838 841 -hsync +vsync
  xrandr --addmode VIRTUAL1 $mode_name
  xrandr --output VIRTUAL1 --mode $mode_name
end

function vnc_off
  kill (pgrep -f ".*x11vnc.*" | grep -v %self)
end

function vnc_on
  while true
    x11vnc -nolookup -nopw -display :0
  end
end

if [ (count $argv) -eq 0 ]
  set argv off on
end
if contains off $argv
  display_off
  vnc_off
end
if contains on $argv
  display_on
  vnc_on
end
