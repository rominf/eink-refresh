#!/usr/bin/env fish

if [ (count $argv) -eq 0 ]
  set argv off on
end
if contains off $argv
  kill (pgrep -f ".*x11vnc.*" | grep -v %self)
end
if contains on $argv
  while true
    x11vnc -nolookup -nopw -display :0
  end
end
