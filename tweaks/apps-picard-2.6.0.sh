wget https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24test/test1.bam
picard AddCommentsToBam I=test1.bam O=output.bam C="comment"
