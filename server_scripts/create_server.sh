# Create Site and Install Application
db_password=xxx
admin_password=xxx
encryption_key=xxx
git_password=xxx
site_name=markup.ideendevelopers.xyz
cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker pull ghcr.io/ideenkreisetech/markup_app/markup_app:2.0.0
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name  --no-mariadb-socket --mariadb-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app erpnext
sudo docker compose exec backend bench --site $site_name install-app hybrid_90plus_app
sudo docker compose exec backend bench --site $site_name set-config backup_encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler
