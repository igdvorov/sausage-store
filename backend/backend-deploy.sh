#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса backend на ВМ для деплоя
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /var/jarservice/sausage-store.jar||true
#Переносим артефакт в нужную папку
curl -u $NEXUS_REPO_USER:$NEXUS_REPO_PASS -o sausage-store.jar $NEXUS_REPO_URL/sausage-store-dvorov-ivan-backend/com/yandex/practicum/devops/sausage-store/$VERSION/sausage-store-$VERSION.jar
sudo cp ./sausage-store.jar /var/jarservice/sausage-store.jar||true #"jar||true" говорит, если команда обвалится — продолжай
#Меняем владельца директории с root на jarservice:jarusers
sudo chown -R jarservice:jarusers /var/jarservice/
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис backend сосисочной
sudo systemctl restart sausage-store-backend.service