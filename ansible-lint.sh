#!/bin/bash
set -eo pipefail

ansible-lint ./envs/ubuntu/playbook.yaml
ansible-lint ./envs/macos/playbook.yaml
