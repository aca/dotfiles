#!/bin/bash 

new_sink=$(pacmd list-sinks | grep index | tee /dev/stdout | grep -m1 -A1 "* index" | tail -1 | cut -c12-)

echo "Setting default sink to: $new_sink";
pacmd set-default-sink $new_sink
pacmd list-sink-inputs | grep index | while read line
do
echo "Moving input: ";
echo $line | cut -f2 -d' ';
echo "to sink: $new_sink";
pacmd move-sink-input `echo $line | cut -f2 -d' '` $new_sink

done
