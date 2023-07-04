#!/bin/sh
echo"start of the postgres_setting_pg_source.sh script"
export source_IP="172.31.14.133"
export client_IP="172.31.37.216"
echo " Enable remote login so you can connect from a particular IP"
grep listen /etc/postgresql/15/main/postgresql.conf
sed -i 's/localhost/*/' /etc/postgresql/15/main/postgresql.conf
sed -i 's/#listen_addresses/listen_addresses/' /etc/postgresql/15/main/postgresql.conf
grep listen /etc/postgresql/15/main/postgresql.conf

cat /etc/postgresql/15/main/pg_hba.conf

sudo systemctl restart postgresql.service
echo "Update the hba.conf file "

psql -c "alter USER postgres PASSWORD 'postgres';"

psql -c "create role client_user with login password 'password' ;"

echo "host    all     all     $source_IP/32        md5" >> /etc/postgresql/15/main/pg_hba.conf
echo "host    all     all     $client_IP/32        md5" >> /etc/postgresql/15/main/pg_hba.conf
psql -c "SELECT pg_reload_conf();"


sudo systemctl restart postgresql
psql -c "SELECT pg_reload_conf();"
echo "End of script /tmp/postgres_setting_pg_source.sh"

