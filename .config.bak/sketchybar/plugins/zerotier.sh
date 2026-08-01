#!/bin/bash

STATUS=$(ssh -o ConnectTimeout=5 orb "sudo zerotier-cli status 2>/dev/null" 2>/dev/null)

if echo "$STATUS" | grep -q "ONLINE"; then
  sketchybar --set $NAME label="ZT" label.color=0xffffffff
else
  sketchybar --set $NAME label="ZT" label.color=0xffcc4444
fi
