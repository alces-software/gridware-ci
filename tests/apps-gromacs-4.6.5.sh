if [[ ":$CW_DOCPATH" == *":$GROMACSDIR"* ]]; then

  alces template prepare gromacs

  alces template copy gromacs ~/gromacs.sh

  /bin/bash -e -l ~/gromacs.sh

else
  g_clustsize -version
fi
