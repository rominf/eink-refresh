#!/usr/bin/env fish


if [ (count $argv) -eq 0 ]
  set argv on off
end

set current_dir (dirname (status --current-filename))

switch $argv[1]
  case refresh
    python3 $current_dir/eink-refresh.py
  case off
    wifi off
  case on
    wifi off
    wifi on
    fish $current_dir/x11vnc.fish $argv[1] >/dev/null ^/dev/null &
end
