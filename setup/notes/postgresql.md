# setup new superuser

sudo su postgres

psql

## inside psql console

create user <username> with encrypted password '<password>';

alter user <username> with superuser;


