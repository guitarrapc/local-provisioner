#!/bin/bash
ansible-playbook -v -i hosts playbook.yaml --ask-become-pass
