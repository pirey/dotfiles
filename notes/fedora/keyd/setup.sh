#!/usr/bin/env bash

sudo dnf copr enable -y fmonteghetti/keyd
sudo dnf install -y keyd --refresh
sudo systemctl enable keyd
sudo systemctl start keyd

sudo mkdir -p /etc/keyd
sudo cp ./default.conf /etc/keyd/default.conf
