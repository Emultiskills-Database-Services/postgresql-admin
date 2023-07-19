echo "Load some data to create some wal logs "
echo "Setting up the shared_preload_libraries = 'pg_stat_statements' # (change requires restart)"
psql -c " show shared_preload_libraries;"
psql -c " alter system set shared_preload_libraries = 'pg_stat_statements' ;"
sudo systemctl restart postgresql
psql -c " show shared_preload_libraries;"
psql -c " alter system set pg_stat_statements.track = 'all';"
psql -c " alter system set pg_stat_statements.max = '10000';"
psql -c " alter system set pg_stat_statements.track = 'all';"
psql -c " alter system set pg_stat_statements.track_utility = 'off';"
psql -c " alter system set pg_stat_statements.save = 'on';"
psql -c " alter system set track_io_timing = 'on';"
psql -c " alter system set track_activity_query_size = '2048';"

sudo systemctl restart postgresql

psql -c " create extension pg_stat_statements;"

psql -c " select name,setting,unit from pg_settings where name in ('log_checkpoints','log_connections','log_disconnections','log_lock_waits','log_temp_files','log_autovacuum_min_duration','log_error_verbosity','log_min_duration_statement','log_min_duration_statement','lc_messages');"


echo "Load the Data"

 psql -c "CREATE DATABASE bench1;"
pgbench -i bench1
 pgbench -c50 -t100 bench1

echo " Load some more data "
echo " Generate some data/ Load Sample Data on VM "


echo " create a role and database "
psql -c  "create role migrationuser with LOGIN SUPERUSER PASSWORD 'secret_password'; "
psql -c "CREATE DATABASE migrationdb WITH OWNER migrationuser;"

export PGPASSWORD=secret_password
psql -h localhost -U migrationuser  -d migrationdb -c  "create table one_millions_rows as SELECT * FROM generate_series(1,1000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE one_millions_rows ADD CONSTRAINT generate_series_pk PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table two_millions_rows as SELECT * FROM generate_series(1,2000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE two_millions_rows ADD CONSTRAINT generate_series_pk2 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c"create table three_millions_rows as SELECT * FROM generate_series(1,3000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table four_millions_rows as SELECT * FROM generate_series(1,4000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table five_millions_rows as SELECT * FROM generate_series(1,5000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table six_millions_rows as SELECT * FROM generate_series(1,6000000);"
psql -h localhost -U migrationuser  -d migrationdb -c"create table seven_millions_rows as SELECT * FROM generate_series(1,7000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table eight_millions_rows as SELECT * FROM generate_series(1,800000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table nine_millions_rows as SELECT * FROM generate_series(1,900000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table ten_millions_rows as SELECT * FROM generate_series(1,1000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE three_millions_rows ADD CONSTRAINT generate_series_pk3 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE four_millions_rows ADD CONSTRAINT generate_series_pk4 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE five_millions_rows ADD CONSTRAINT generate_series_pk5 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE six_millions_rows ADD CONSTRAINT generate_series_pk6 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE seven_millions_rows ADD CONSTRAINT generate_series_pk7 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE eight_millions_rows ADD CONSTRAINT generate_series_pk8 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE nine_millions_rows ADD CONSTRAINT generate_series_pk9 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE ten_millions_rows ADD CONSTRAINT generate_series_pk10 PRIMARY KEY (generate_series);"
export PGPASSWORD=secret_password
psql -h localhost -U migrationuser  -d migrationdb -c "\dt+"
psql -h localhost -U migrationuser  -d migrationdb -c "\di+"
psql -h localhost -U migrationuser  -d migrationdb -c " create extension pg_stat_statements;"
psql -c "CREATE DATABASE bench2;"
pgbench -i bench2

pgbench -c50 -t1000 bench2

echo " delete rows "

export PGPASSWORD=secret_password
psql -h localhost -U migrationuser  -d migrationdb -c  "create table elevan_millions_rows as SELECT * FROM generate_series(1,1000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE elevan_millions_rows ADD CONSTRAINT generate_series_pk PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table twelve_millions_rows as SELECT * FROM generate_series(1,2000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE twelve_millions_rows ADD CONSTRAINT generate_series_pk2 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c"create table thirteen_millions_rows  as SELECT * FROM generate_series(1,3000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table forteen_millions_rows  as SELECT * FROM generate_series(1,4000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table fifteen_millions_rows  as SELECT * FROM generate_series(1,5000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table sixteen_millions_rows  as SELECT * FROM generate_series(1,6000000);"
psql -h localhost -U migrationuser  -d migrationdb -c"create table seventeen_millions_rows  as SELECT * FROM generate_series(1,7000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table eighteen_millions_rows  as SELECT * FROM generate_series(1,800000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table nineteen_millions_rows as SELECT * FROM generate_series(1,900000);"
psql -h localhost -U migrationuser  -d migrationdb -c "create table twenty_millions_rows as SELECT * FROM generate_series(1,1000000);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE thirteen_millions_rows  ADD CONSTRAINT generate_series_pk3 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE forteen_millions_rows  ADD CONSTRAINT generate_series_pk4 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE fifteen_millions_rows  ADD CONSTRAINT generate_series_pk5 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE sixteen_millions_rows  ADD CONSTRAINT generate_series_pk6 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE seventeen_millions_rows  ADD CONSTRAINT generate_series_pk7 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE eighteen_millions_rows  ADD CONSTRAINT generate_series_pk8 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE nineteen_millions_rows ADD CONSTRAINT generate_series_pk9 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c "ALTER TABLE twenty_millions_rows ADD CONSTRAINT generate_series_pk10 PRIMARY KEY (generate_series);"
psql -h localhost -U migrationuser  -d migrationdb -c  "delete from  elevan_millions_rows where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from twelve_millions_rows where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c"delete from thirteen_millions_rows   where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from forteen_millions_rows  where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from fifteen_millions_rows  where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from sixteen_millions_rows  where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c"delete from seventeen_millions_rows  where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from eighteen_millions_rows  where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from nineteen_millions_rows where  generate_series > 1000;"
psql -h localhost -U migrationuser  -d migrationdb -c "delete from twenty_millions_rows where  generate_series > 1000;"
echo " count rows "

export PGPASSWORD=secret_password
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  one_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  two_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  three_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  four_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  five_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  six_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  seven_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  eight_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  nine_millions_rows ;"
psql -h localhost -U migrationuser  -d migrationdb -c "select count(*) from  ten_millions_rows ;"
