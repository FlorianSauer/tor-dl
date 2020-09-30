#!/usr/bin/env bash

# check if parameter was passed
if [ -z "$1" ]
then
    config_file="link_list.txt"
else
    config_file=$1
fi

#for line in $(cat $config_file); do
while IFS='' read -r line || [ -n "${line}" ]; do
    # check if line is a file or a dir
    if [[ $line == \#* ]] || [[ $line == \;* ]] ; then
        echo "skipping" $line
        continue
    elif [[ $line == "" ]]; then
        continue
    fi
    random_sleep_seconds=$(python -S -c "import random; print random.randrange(60,300)")
    random_sleep_humanreadable=$(date -d@$random_sleep_seconds -u +%M:%S)
    echo "waiting" $random_sleep_humanreadable "Minutes for the next download" $random_sleep_seconds
    read -t $random_sleep_seconds -n 1 -p "Press any Key to skip the waiting time... " </dev/tty
    echo
    echo "downloading" $line
    docker-compose run --rm tor-dl bash -c "tor-dl-test && tor-dl-download-best $line" </dev/null
    echo "downloaded" $line

done < $config_file

echo "done downloading"