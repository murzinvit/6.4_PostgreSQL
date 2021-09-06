### 6.4_PostgreSQL
-------------------------------------------------------------------------------------------------
#### Задача 1: </br>
1) Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume: </br>
- `docker pull postgres:latest` </br>
- `docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -e POSTGRES_DB=netology -v /DATABASE/postgres-data:/var/lib/postgreql/data -v --name postgres_srv postgres` </br>
2) Подключитесь к БД PostgreSQL используя psql: </br>
- `psql -U user -W pass netology` </br>
3) Найдите и приведите управляющие команды для: </br>
- вывода списка БД: `\l` </br>
- подключения к БД: </br>
- вывода списка таблиц: <>/br
- вывода описания содержимого таблиц: </br>
- выхода из psql: </br>
#### Задача 2: </br>
1) Используя psql создайте БД test_database: `CREATE DATABASE test_database;` </br>
2) Восстановите бэкап БД в test_database: </br>
#### Задача 3: </br>
#### Задача 4: </br>
