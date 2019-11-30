#!/bin/sh

sudo -S su -l postgres

initdb -D /var/lib/postgres/data

exit

sudo -S systemctl enable --now postgresql
