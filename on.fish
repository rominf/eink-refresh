#!/usr/bin/env fish

ssh router /usr/sbin/wl radio on &
fish (dirname (status --current-filename))/x11vnc.fish on >/dev/null ^/dev/null &
