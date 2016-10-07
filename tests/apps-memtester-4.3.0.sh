if [ -z "$CW_DOCPATH" ]; then
  memtester 1M 1
else
  alces template copy memtester ~/memtester.sh
  bash -e -l ~/memtester.sh
fi
