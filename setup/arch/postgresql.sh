#!/bin/sh

sudo -S su -l postgres

initdb --locale=en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data

exit

sudo -S systemctl enable --now postgresql
