#!/bin/sh
#
# $ vid.res video.mp4
# 
# {
#   "width": 1082,
#   "height": 1080
# }
 
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of json "$1" | jq .streams[0]
