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
if [ -d "gridware-packages-main" ]; then
    echo "Remove old /opt/gridware-ci/gridware-packages-main directory first."
    exit 1
fi
if ! git clone https://github.com/alces-software/gridware-packages-main; then
    echo "Unable to clone gridware-packages-main."
    exit 1
fi
cd gridware-packages-main
if ! git checkout $rev; then
    echo "Unable to find specified revision: $rev"
    exit 1
fi
git clone https://github.com/alces-software/gridware-ci .gridware-ci
docker build --build-arg treeish=$rev --build-arg repo_slug=alces-software/gridware-packages-main \
       -t "gridware-ci" \
       .gridware-ci/el7-1.9-main
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
EOF
if [ -f $HOME/logs/failures.log ]; then
    cat <<EOF

SO FAIL. CRY.

Refer to these logs regarding failures:
EOF
    cat $HOME/logs/failures.log
else
    cat <<EOF

SUCH SUCCESS! AMAZE!
EOF
fi
