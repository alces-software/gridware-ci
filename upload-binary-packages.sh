#!/bin/bash -l
module load services/s3cmd
if [ -z "$AWS_SECRET_ACCESS_KEY" -o -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY first pls."
    exit 1
fi
for a in $HOME/dist/*.tar.gz; do
    s3cmd put -P $a 's3://packages.alces-software.com/gridware/$dist/'$(basename $a)
done
