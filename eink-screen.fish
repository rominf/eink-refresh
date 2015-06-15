#!/usr/bin/env fish

if [ $argv[1] = refresh ]
  python3 (dirname (status --current-filename))/eink-refresh.py
else
  ssh router /usr/sbin/wl radio $argv[1] &
  fish (dirname (status --current-filename))/x11vnc.fish $argv[1] >/dev/null ^/dev/null &
end
