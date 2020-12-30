#! /bin/bash

set -e

echo "YAML Lint"
yamllint .

echo "Ansible Lint"
ansible-lint

echo ""
echo "All linters passed without errors"
