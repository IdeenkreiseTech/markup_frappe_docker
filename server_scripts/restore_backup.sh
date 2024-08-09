# Restore Backup
db_password=xxx
site_name=markup.ideendevelopers.xyz
db_backup=20240808_124421-hybrid_localhost-database.sql.gz

cd ../
sudo docker cp server_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup --mariadb-root-password $db_password --force
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend
