### 6.4_PostgreSQL
-------------------------------------------------------------------------------------------------
#### Задача 1: </br>
1) Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume: </br>
- `docker pull postgres:latest` </br>
- `docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -e POSTGRES_DB=netology -v /DATABASE/postgres-data:/var/lib/postgreql/data --name postgres_srv postgres` </br>
2) Подключитесь к БД PostgreSQL используя psql: </br>
- `psql -U user netology` (по умолчанию есть база template1, template0) </br>
3) Найдите и приведите управляющие команды для: </br>
- вывода списка БД: `\l` </br>
- подключения к БД: `\connect db_name` </br>
- вывода списка таблиц: `\dt` </br>
- вывода описания(подробное) содержимого таблиц: `\d+ table_name` </br>
- выхода из psql: `\q` либо `exit` </br>
- справка: `\?` </br>
- Документация по основным запросам: [shpargalka-po-osnovnym-komandam-postgresql](https://www.oslogic.ru/knowledge/598/shpargalka-po-osnovnym-komandam-postgresql/) </br>
#### Задача 2: </br>
1) Используя psql создайте БД test_database: `CREATE DATABASE test_database;`, `connect test_database` </br>
2) Восстановить бэкап БД в test_database: `psql -h localhost -U user -d test_database -f test_dump.sql` (Исправить ошибки: `create user postgres;`) </br>
3) Перейти в управляющую консоль psql внутри контейнера: `docker exec -it postgres_srv /bin/bash`, `psql -U user test_database` </br>
4) Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице: `analyze verbose orders;` </br>
5) В таблице pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах: </br>
- Список системных таблиц: `\dS` </br>
- Поля и столбцы таблицы pg_stats: `\dS pg_catalog.pg_stats` </br>
- Вывод среднего значения элементов: `SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders';` </br>
Вывод запроса: </br>
![Postgre_width](https://github.com/murzinvit/screen/blob/c2364650f668fcba913b4469fac34f6dde54941f/Postgres_avg_width_column.png) </br>
Документация по [pg_stats](https://postgrespro.ru/docs/postgresql/9.4/planner-stats) </br>
#### Задача 3: </br>
Документация по декларативному партиционированию: [https://postgrespro.ru/docs](https://postgrespro.ru/docs/postgresql/10/sql-createtable) </br>
[https://postgrespro.ru/docs/](https://postgrespro.ru/docs/postgresql/10/ddl-partitioning) </br>
1)Провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499): </br>
- Горизонтальный шардинг — это разделение одной таблицы на разные сервера </br>
- `CREATE TABLE orders_1 (like orders including all) INHERITS (orders);` </br>
- `ALTER TABLE orders_1 add constraint check_price CHECK(price>499);` </br>
- `CREATE TABLE orders_2 (like orders including all) INHERITS (orders);` </br>
- `ALTER TABLE orders_2 add constraint check_price CHECK(price<=499);` </br>
Далее нужно добавить функцию: </br>
`create function check_price() returns trigger as $$ begin if new.price>499 then insert into orders_1 select new.*;` <br>
`elsif new.price<=499 then insert into orders_2 select new.*;` </br>
`end if;` </br>
`return null;` </br>
`end; $$ language plpgsql;` </br>
Далее нужно добавить триггер: </br>
`create trigger price_check_ins before insert on orders for each row execute procedure check_price();` </br>
Документация по шардингу таблиц и триггерам: [sharding_tables](https://postgrespro.ru/blog/pgsql/17770) </br>

#### Задача 4: </br>
1) Используя утилиту pg_dump создайте бекап БД test_database: </br>
`pg_dump -U user -F c test_database > test_database.sql` </br>
 [test_database.sql](https://github.com/murzinvit/6.4_PostgreSQL/blob/1175d09ff42fb5a54ba5811b42534326ad967c17/test_database.sql) </br>
2) Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database? </br>
- Добавить к полю price атрибут - uniquie </br> 
- `alter table only orders add unique (title);` </br>
![screen](https://github.com/murzinvit/screen/blob/38a87be3ce8657ec19f12448f3a182c18c545ccd/Postrgres_title_unique.png) </br>
