#!/bin/bash
img="alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}"
docker tag $img $img:base
packages="$(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/apps/${pattern}*")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/libs/${pattern}*")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/compilers/${pattern}*")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/mpi/${pattern}*")"
if [ -f .gridware-ci/packages.rc ]; then
    . .gridware-ci/packages.rc
fi
failed=()
for a in ${packages}; do
    nicename="$(echo "$a" | tr '/' '-')"
    log_output="$HOME/logs/main-${TRAVIS_BUILD_NUMBER}/${TRAVIS_JOB_NUMBER}/${nicename}"
    # determine variants
    variants="$(docker run --rm ${img}:base /bin/bash -l -c "alces gridware install ${a} --variant INVALID")"
    if [[ "$variants" != *'no variants'* ]]; then
        variants="$(echo "$variants" | tail -n+2 | sed "s/.*choose from: \(.*\)/\1/g" | tr -d ',')"
    else
        variants=""
    fi
    # XXX - should detect "NOTICE" and/or refuse to import during install somehow
    # XXX - should be able to explicitly specify "no compile only import"
    # XXX - perform smoke tests
    echo ""
    echo "========================================"
    echo "  >> ${a}"
    echo "========================================"
    if [ "$variants" ]; then
        for v in ${variants}; do
            echo ""
            echo "----------------------------------------"
            echo "  >> ${a} (${v})"
            echo "----------------------------------------"
            if [[ " ${skip_install} " == *" $a:$v "* ]]; then
                echo "NOTICE: skipping: ${a}:${v}"
            else
                mkdir -p "${log_output}-${v}"
                install_args="--variant=$v"
                docker run ${img}:base /bin/bash -l -c "alces gridware install --yes --non-interactive --binary ${a} ${install_args}"
                if [ $? -gt 0 ]; then
                    failed+=("${a} (${v})")
                fi
                ctr=$(docker ps -alq)
                docker cp ${ctr}:/var/log/gridware "${log_output}-${v}"
                docker rm ${ctr}
            fi
            echo "----------------------------------------"
            echo ""
        done
    else
        if [[ " ${skip_install} " == *" $a "* ]]; then
            echo "NOTICE: skipping: ${a}"
        else
            mkdir -p "${log_output}"
            docker run ${img}:base /bin/bash -l -c "alces gridware install --yes --non-interactive --binary ${a}"
            if [ $? -gt 0 ]; then
                failed+=(${a})
            fi
            ctr=$(docker ps -alq)
            docker cp ${ctr}:/var/log/gridware "${log_output}"
            docker rm ${ctr}
        fi
    fi
    echo "========================================"
    echo ""
done
if [ "${failed[*]}" ]; then
    echo "Failed to install: ${failed[*]}"
    exit 1
fi
