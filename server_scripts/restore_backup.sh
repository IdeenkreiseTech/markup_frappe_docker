# Restore Backup
db_password=xxx
site_name=hybrid.markuplearnings.com
db_backup=20240813_115418-markup_ideendevelopers_xyz-database.sql.gz
public_files=20240809_154140-hybrid_localhost-files.tar
private_files=20240809_154140-hybrid_localhost-private-files.tar

cd ../
sudo docker cp server_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
sudo docker cp server_scripts/backup/$public_files $(sudo docker compose ps -q backend):/tmp
sudo docker cp server_scripts/backup/$private_files $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup --with-private-files /tmp/$private_files --with-public-files /tmp/$public_files --mariadb-root-password $db_password --force
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend