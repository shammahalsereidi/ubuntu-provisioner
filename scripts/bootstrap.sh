#!/usr/bin/env bash
#
# bootstrap.sh
# Installs Ansible on a fresh Ubuntu 24.04 machine so the playbook can run.
# Usage: ./scripts/bootstrap.sh
set -euo pipefail

echo "[bootstrap] Updating apt cache..."
sudo apt-get update -y

echo "[bootstrap] Installing prerequisites (software-properties-common, python3-pip)..."
sudo apt-get install -y software-properties-common python3 python3-pip

if ! command -v ansible >/dev/null 2>&1; then
    echo "[bootstrap] Installing Ansible via apt (ansible PPA)..."
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible
else
    echo "[bootstrap] Ansible already installed: $(ansible --version | head -n1)"
fi

echo "[bootstrap] Done. Ansible version:"
ansible --version | head -n1

echo
echo "Next step:"
echo "  ansible-playbook -i inventory.ini playbook.yml --ask-become-pass"
