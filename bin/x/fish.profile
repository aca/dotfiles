#!/usr/bin/env sh
fish --profile /tmp/profile -c fish_prompt; sort -nk2 /tmp/profile

# 02:34 Mon 11/30/2020
# time fish -c "exit"
# Executed in   56.05 millis    fish           external
#    usr time   55.18 millis  1255.00 micros   53.92 millis
#    sys time   33.05 millis  379.00 micros   32.67 millis
