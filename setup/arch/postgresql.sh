#!/bin/sh

sudo su -l postgres

initdb -D /var/lib/postgres/data

exit

sudo systemctl enable --now postgresql
