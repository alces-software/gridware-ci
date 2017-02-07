if [[ ":$CW_DOCPATH" == *":$VCFTOOLSDIR"* ]]; then

  alces template copy vcftools ~/vcftools.sh

  /bin/bash -e -l ~/vcftools.sh

else
  vcftools
fi
