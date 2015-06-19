#!/usr/bin/env fish

if [ (count $argv) -eq 0 ]
  set argv on off
end

switch $argv[1]
  case refresh
    python3 (dirname (status --current-filename))/eink-refresh.py
  case off
    ssh router /usr/sbin/wl radio off &
  case on
    ssh router /usr/sbin/wl radio on &
    ssh router /usr/sbin/wl radio off &
    fish (dirname (status --current-filename))/x11vnc.fish $argv[1] >/dev/null ^/dev/null &
end
