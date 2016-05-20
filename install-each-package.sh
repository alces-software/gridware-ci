#!/bin/bash
img="alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}"
docker tag $img $img:base
packages=$(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/{apps,libs,compilers,mpi}/${pattern}*")
failed=()
for a in ${packages}; do
    nicename="$(echo "$a" | tr '/' '-')"
    log_output="$HOME/logs/build-${TRAVIS_BUILD_NUMBER}/${TRAVIS_JOB_NUMBER}/${nicename}"
    # determine variants
    variants="$(docker run --rm ${img}:base /bin/bash -l -c "alces gridware install ${a} --variant INVALID")"
    if [[ "$variants" != *'no variants'* ]]; then
        variants="$(echo "$variants" | tail -n+2 | sed "s/.*choose from: \(.*\)/\1/g" | tr -d ',')"
    else
        variants=""
    fi
    if [ "$variants" ]; then
        for v in ${variants}; do
            mkdir -p "${log_output}-${v}"
            install_args="--variant=$v"
            docker run ${img}:base /bin/bash -l -c "alces gridware install --yes --non-interactive --binary ${a} ${install_args}"
            if [ $? -gt 0 ]; then
                failed+=(${a}_${v})
            fi
            ctr=$(docker ps -alq)
            docker cp ${ctr}:/var/log/gridware "${log_output}-${v}"
            docker rm ${ctr}
        done
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
done
if [ "${failed[*]}" ]; then
    echo "Failed to install: ${failed[*]}"
    exit 1
fi
