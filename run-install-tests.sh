#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <revision>"
    exit 1
fi
rev=$1
yum install -y docker
systemctl start docker
mkdir -p /opt/gridware-ci
cd /opt/gridware-ci
git clone https://github.com/alces-software/gridware-packages-main
cd gridware-packages-main
git checkout $rev
git clone https://github.com/alces-software/gridware-ci .gridware-ci
docker build --build-arg treeish=$rev --build-arg repo_slug=alces-software/gridware-packages-main \
       -t "gridware-ci" \
       .gridware-ci/el7-1.5-main
export baseimg="gridware-ci"
patterns="[a-bA-B] [c-fC-F] [gG] [h-kH-K] [lL] [mM][a-eA-E]"
patterns="$patterns [mM][f-z][F-Z] [nN] [pP][a-xA-X] [pP][y-zY-Z]"
patterns="$patterns [qQ] [rR] [sS][a-eA-E] [sS][f-zF-Z] [tT] [u-zU-ZoO]"
set -o pipefail
mkdir -p $HOME/logs
for pattern in $patterns; do
    export pattern
    .gridware-ci/install-each-package.sh | tee -a $HOME/logs/builds-$(echo $pattern | tr -d '[]').log
    if [ $? -gt 0 ]; then
        echo "FAILURES during $pattern :-("
        echo "$pattern" >> $HOME/logs/failures.log
    fi
done

cat <<EOF



=============================================================
 DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE
=============================================================
Refer to logs regarding any failures shown:
EOF
cat $HOME/logs/failures.log
