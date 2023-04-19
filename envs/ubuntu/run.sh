#!/bin/bash
set -e
ansible-playbook -i hosts playbook.yaml -K
