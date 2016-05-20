#!/bin/bash
TRAVIS_COMMIT_RANGE="${TRAVIS_COMMIT_RANGE:-${TRAVIS_COMMIT}^..${TRAVIS_COMMIT}}"
packages=$(git diff --name-only ${TRAVIS_COMMIT_RANGE} | grep metadata.yml | cut -f1-3 -d'/')
if [ -f .gridware-ci/packages.rc ]; then
    . .gridware-ci/packages.rc
fi
if [ -n "${packages}" -o -n "${force_packages}" ]; then
    echo "Changed packages within ${TRAVIS_COMMIT_RANGE}: ${packages}"
    failed=()
    img="alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}"
    for a in ${packages} ${force_packages}; do
        docker tag $img $img:build
        nicename="$(echo "$a" | tr '/' '-')"
        unset ci_skip export_args export_skip install_args export_packages
        if [ -f .gridware-ci/tweaks/${nicename}.sh ]; then
            . .gridware-ci/tweaks/${nicename}.sh
        fi
        if [[ "$a" == ext/* ]]; then
            echo "Skipping external package: ${a}"
        elif [ -z "$ci_skip" ]; then
            log_output="$HOME/logs/volatile-${TRAVIS_BUILD_NUMBER}/${TRAVIS_JOB_NUMBER}/${nicename}"
            build_output="$HOME"/'$dist'
            mkdir -p "${log_output}" "${build_output}"
            if [ "${cw_VERSION}" != "1.4.0" ]; then
                docker run ${img}:build /bin/bash -l -c "alces gridware install --yes --non-interactive --binary-depends ${a} ${install_args}"
            else
                docker run ${img}:build /bin/bash -l -c "alces gridware install ${a} ${install_args}"
            fi
            if [ $? -gt 0 ]; then
                failed+=(${a})
            elif [ -z "$export_skip" ]; then
                for b in ${export_packages:-${a}}; do
                    docker commit $(docker ps -alq) $img:installed
                    if [ "${cw_VERSION}" != "1.4.0" ]; then
                        docker run ${img}:installed /bin/bash -l -c "alces gridware export --non-interactive --accept-elf ${export_args} ${b}"
                    else
                        docker run ${img}:installed /bin/bash -l -c "alces gridware export ${export_args} ${b}"
                    fi
                    if [ $? -gt 0 ]; then
                        failed+=(${b})
                    fi
                done
            fi
            ctr=$(docker ps -alq)
            docker cp ${ctr}:/var/log/gridware "${log_output}"
            docker cp ${ctr}:/root/.cpanm/build.log "${log_output}"/cpanm-build.log.$(date +%Y%m%d%H%M%S)
            for b in ${export_packages:-${a}}; do
                nicename="$(echo "$b" | tr '/' '-')"
                docker cp ${ctr}:/tmp/${nicename}-${cw_DIST}.tar.gz "${build_output}"
            done
        else
            echo "Skipping blacklisted package: ${a}"
        fi
    done
    if [ "${failed[*]}" ]; then
        echo "Failed to build: ${failed[*]}"
        exit 1
    fi
else
    echo "No package changes detected within ${TRAVIS_COMMIT_RANGE}"
fi
