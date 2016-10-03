#!/bin/bash
img="${baseimg:-alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}}"
docker tag $img $img:base
packages="$(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/apps/${pattern}* | grep '^main/'")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/libs/${pattern}*")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/compilers/${pattern}*")"
packages="$packages $(docker run --rm ${img}:base /bin/bash -l -c "alces gridware list main/mpi/${pattern}*")"
if [ -f .gridware-ci/packages.rc ]; then
    . .gridware-ci/packages.rc
fi
failed=()

create_smoketest() {
    local pkg nicename
    pkg="$1"
    if [[ "${pkg}" == *":"* ]]; then
        variant="${pkg##*:}"
    fi
    module_parts=($(echo "${pkg%:*}" | cut -f2- -d"/" --output-delimiter=" "))
    if [ -n "${variant}" -a "${variant}" != "default" ]; then
        module_parts[1]="${module_parts[1]}_${variant}"
        nicename="$(echo "${pkg#*/}" | tr '/:' '-')"
    else
        nicename="$(y="${pkg#*/}"; echo ${y%:*} | tr '/:' '-')"
    fi
    testfile=$(mktemp /tmp/smoketest.XXXXXXXX)
    cat <<EOF > ${testfile}
#!/bin/bash -l
set -e
export cw_MODULES_VERBOSE=1
module=$(IFS="/"; echo "${module_parts[*]}")
echo "Module is: \${module}"
module show "\${module}" 2>&1
module load "\${module}" 2>&1
module list 2>&1
EOF
    if [ -f .gridware-ci/tests/${nicename}.sh ]; then
        cat .gridware-ci/tests/${nicename}.sh >> ${testfile}
    fi
    chmod 755 "${testfile}"
    echo "${testfile}"
}

import_pkg() {
    local pkg log_output install_args
    pkg="$1"
    log_output="$2"
    install_args="$3"
    if [[ " ${skip_install} " == *" $pkg "* ]]; then
        echo "NOTICE: skipping: ${pkg}"
    else
        mkdir -p "${log_output}"
        docker run ${img}:base /bin/bash -l -c "alces gridware install --yes --non-interactive --binary ${install_args}"
        if [ $? -gt 0 ]; then
            failed+=("${pkg}")
            pkg_ctr=$(docker ps -alq)
            docker cp ${pkg_ctr}:/var/log/gridware "${log_output}"
            docker rm ${pkg_ctr}
        else
            pkg_ctr=$(docker ps -alq)
            docker cp $(create_smoketest "${pkg}") ${pkg_ctr}:/root/smoketest.sh
            docker commit ${pkg_ctr} $img:pkg
            docker rm ${pkg_ctr}
            set -o pipefail
            docker run ${img}:pkg /root/smoketest.sh 2>&1 | tee -a "${log_output}"/test.log
            if [ $? -gt 0 ]; then
                failed+=("${pkg}")
            fi
            set +o pipefail
            test_ctr=$(docker ps -alq)
            docker cp ${test_ctr}:/var/log/gridware "${log_output}"
            docker rm ${test_ctr}
            docker rmi $img:pkg
        fi
    fi
}

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
            import_pkg "$a:$v" "${log_output}-${v}" "${a} --variant=$v"
            echo "----------------------------------------"
            echo ""
        done
    else
        import_pkg "$a" "${log_output}" "$a"
    fi
    echo "========================================"
    echo ""
done
if [ "${failed[*]}" ]; then
    echo "Failed to install: ${failed[*]}"
    exit 1
fi
