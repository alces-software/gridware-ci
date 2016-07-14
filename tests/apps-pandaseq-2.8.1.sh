#wget http://neufeldserver.uwaterloo.ca/~apmasell/pandaseq_sampledata.tar
#tar -xvf pandaseq_sampledata.tar
#pandaseq -f mcbath_1.fastq.bz2 -r mcbath_2.fastq.bz2 2&> pandaseq.out
pandaseq -h 2>&1 | grep "^pandaseq 2.8"
