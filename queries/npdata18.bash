#!/bin/bash

start_date="2018-01-01"

if [ $# -ne 3 ]; then
    start_week=1
    end_week=52
    output_dir="data"
else
    start_week=$1
    end_week=$2
    output_dir=$3
fi

echo "Retrieving weekly raw ANPR data for weeks $start_week:$end_week and writing to $output_dir"

# with "until"
i=$start_week

until [[ $i -gt $end_week ]]; do
    w1=$(date -I -d "$start_date + $((i-1)) week")
    w2=$(date -I -d "$start_date + $i week")
    filename="anpr18_week$i.csv"
    output="$output_dir/$filename"

    echo "Retrieving npdata for week $i: $w1 -> $w2 and writing to $filename"
    
    client query -i raw_npdata.sql \
    	         -k start $w1              \
    		 -k end   $w2              \
		 -o $output && echo "OK!" || echo "FAILED!"

    i=$((i+1))
done
