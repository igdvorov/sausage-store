# Sausage Store

### single
hostname - rc1a-5dd7qg0z5hoe1x3o.mdb.yandexcloud.net
port     - 6432
username - sausage-store-db-user
password - 4wzTVbsbklPl42Sj5xKZrG
db_name  - sausage-store-db
### cluster
hostname - rc1a-6s9np12pfl1emms4.mdb.yandexcloud.net
hostname - rc1b-02ykbvl7dw1hk2pu.mdb.yandexcloud.net
port     - 6432
username - sausage-store-db-user
password - 4wzTVbsbklPl42Sj5xKZrG
db_name  - sausage-store-db

![image](https://user-images.githubusercontent.com/9394918/121517767-69db8a80-c9f8-11eb-835a-e98ca07fd995.png)


## Technologies used

* Frontend – TypeScript, Angular.
* Backend  – Java 16, Spring Boot, Spring Data.
* Database – H2.

## Installation guide
### Backend

Install Java 16 and maven and run:

```bash
cd backend
mvn package
cd target
java -jar sausage-store-0.0.1-SNAPSHOT.jar
```

### Frontend

Install NodeJS and npm on your computer and run:

```bash
cd frontend
npm install
npm run build
npm install -g http-server
sudo http-server ./dist/frontend/ -p 80 --proxy http://localhost:8080
```

Then open your browser and go to [http://localhost](http://localhost)
