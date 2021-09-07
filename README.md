### 6.4_PostgreSQL
-------------------------------------------------------------------------------------------------
#### Задача 1: </br>
1) Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume: </br>
- `docker pull postgres:latest` </br>
- `docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -e POSTGRES_DB=netology -v /DATABASE/postgres-data:/var/lib/postgreql/data --name postgres_srv postgres` </br>
2) Подключитесь к БД PostgreSQL используя psql: </br>
- `psql -U user -W pass netology` </br>
- `su -l postgres`, `psql -U user template1` </br>
3) Найдите и приведите управляющие команды для: </br>
- вывода списка БД: `\l` </br>
- подключения к БД: `connect db_name` </br>
- вывода списка таблиц: `\dt` </br>
- вывода описания содержимого таблиц: `\d+ “table_name”` </br>
- выхода из psql: `\q` </br>
- справка: `\?` </br>
#### Задача 2: </br>
1) Используя psql создайте БД test_database: `CREATE DATABASE test_database;`, `connect test_database` </br>
2) Восстановить бэкап БД в test_database: `psql -h localhost -U user -d test_database -f test_dump.sql` (Исправить ошибки: `create user postgres;`) </br>
3) Перейти в управляющую консоль psql внутри контейнера: `docker exec -it postgres_srv /bin/bash`, `psql -U user test_database` </br>
4) Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице: `analyze verbose orders;` </br>
5) В таблице pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах: </br>
#### Задача 3: </br>
#### Задача 4: </br>
