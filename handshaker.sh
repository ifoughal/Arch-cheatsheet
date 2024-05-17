#!/bin/bash

unset knows_hosts_file
unset hosts
############################################################
# source check
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]
  then
    echo "[INFO]: script ${BASH_SOURCE[0]} is being sourced ..."
else
  echo "[ERROR]: > You have to run the script as source: 'source ${BASH_SOURCE[0]} 5.7.1'"
  return
fi
############################################################

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      echo "
######################################################################################
                  ${BASH_SOURCE[0]} - certificates handler
######################################################################################
HELP:
  [ -h/--help ]:       outputs this helper.
  [ -H/--hosts_file ]: ~/.ssh/known_hosts
  [ arg* ]:            list of hostnames: 10.10.10.1:2022 192.168.0.1 127.0.0.1:10023
EXAMPLE:
  You can run the script as:
    'source ${BASH_SOURCE[0]} -H  ~/.ssh/known_hosts 127.0.0.1:10022 127.0.0.1:10023'
######################################################################################
"
      return
      ;;
    -H|--hosts_file)
      knows_hosts_file="$2"
      shift
      shift
      ;;
    -*|--*)
      echo "ERROR: unknown argument $1"
      return
      ;;
    *)
      hosts+=("$1")
      shift
      ;;
  esac
done

# echo ${#hosts[@]}
echo "[INFO]: knows_hosts_file at: $knows_hosts_file"

if [[ -f "${knows_hosts_file}" ]]; then
    echo "[INFO]: known_hosts file was found, appending fingerprints at location..."
else

    full_path=(${knows_hosts_file//[\/]/ })
    dir_path=""
    known_hosts_file="known_hosts"
    for ((i=0; i<${#full_path[@]}; i+=1)); do
        if [ $i -lt $(( ${#full_path[*]} - 1 )) ]; then
            dir_path="${dir_path}/${full_path[$i]}"
        else
            known_hosts_file="${full_path[$i]}"
        fi

    done
    echo "[INFO]: creating known_hosts at selected location: '${dir_path}/${known_hosts_file}'"
    mkdir -m 700 -p ${dir_path}
    chmod 644 "${dir_path}/${known_hosts_file}">>"${dir_path}/${known_hosts_file}"
fi


############################################################
for host in "${hosts[@]}"; do
    echo "[INFO]: adding host: $host to known_hosts file"
    host=(${host//[:]/ })
    if [ ${#host[@]} -eq 1 ]; then
        ssh-keyscan ${host} >> ${knows_hosts_file}
    else
        ssh-keyscan -p ${host[1]} ${host[0]} >> ${knows_hosts_file}
    fi
done

# generate certs, then ssh-copy-id

unset knows_hosts_file
unset hosts
