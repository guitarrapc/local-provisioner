#!/bin/bash
set -euo pipefail

while [ $# -gt 0 ]; do
    case $1 in
        --dry-run) _DRYRUN=true; shift 1; ;;
        *) shift ;;
    esac
done

if [[ "${_DRYRUN:=false}" == "true" ]]; then
  ansible_args="--check --diff"
fi

ansible-playbook -v -i hosts playbook.yaml -K ${ansible_args:=""}
