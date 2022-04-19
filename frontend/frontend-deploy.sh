#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса frontend на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -f /var/www-data/dist/frontend/*||true
#Переносим артефакт в нужную папку
curl -u $NEXUS_REPO_USER:$NEXUS_REPO_PASS -o frontend.tar.gz $NEXUS_REPO_URL/sausage-store-dvorov-ivan-frontend/sausage-store/$VERSION/sausage-store-$VERSION.tar.gz
tar -xvf frontend.tar.gz sausage-store-$VERSION #Распаковка архива
mv sausage-store-$VERSION/public_html/* /var/www-data/dist/frontend/||true #"jar||true" говорит, если команда обвалится — продолжай
rm -rf 'sausage-store-1'* #Удаляем папку sausage-store
#Меняем владельца директории с root на front-user
sudo chown -R front-user:front-user /var/www-data/dist/frontend/
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис frontend сосисочной
sudo systemctl restart sausage-store-frontend.service