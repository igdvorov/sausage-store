#!/bin/bash
mkdir -p sausage-compose || true
mv docker-compose.yaml sausage-compose || true
cd sausage-compose
docker-compose pull sausage-backend-reports sausage-backend sausage-frontend
docker-compose down
docker-compose stop sausage-backend || true
docker-compose rm -f sausage-backend || true
docker-compose stop sausage-backend-report || true
docker-compose rm -f sausage-backend-report || true
docker-compose stop sausage-frontend || true
docker-compose rm -f sausage-frontend || true
set -e
docker-compose up -d

cat <<EOF | docker exec -i vault ash
	sleep 10;
	vault login ${VAULT_TOKEN}
	vault secrets enable -path=sausage-store kv
	vault kv put secret/sausage-store spring.datasource.password=${PSQL_PASSWORD} spring.datasource.url=${PSQL_HOST} spring.datasource.username=${PSQL_USER} spring.data.mongodb.uri=${MONGO_DATA} 
EOF