#!/bin/bash
# python_setup.sh - Basic Python setup on Linux
sudo apt update
sudo apt install -y python3 python3-pip python3-venv
python3 --version
pip3 --version


echo "Python setup complete. Activate venv with: source myenv/bin/activate"
