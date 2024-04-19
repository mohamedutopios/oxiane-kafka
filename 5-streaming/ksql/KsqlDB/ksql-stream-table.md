# Les commandes dans ksql >

## 1 - Creation Stream simple avec producer en ligne de commande : 

 - docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088

 - ksql> create stream users_stream (name VARCHAR, countrycode VARCHAR) WITH (KAFKA_TOPIC='USERS', VALUE_FORMAT='DELIMITED');

 - ksql> list streams; ou show STREAMS;


===> auto.offset.reset - Détermine la procédure à suivre lorsqu'il n'y a pas d'offset initial dans Apache Kafka ou si l'offset actuel n'existe pas sur le serveur. La valeur par défaut dans KSQL est latest, ce qui signifie que tous les sujets Kafka sont lus à partir du dernier offset disponible. Par exemple, pour le modifier en earliest en utilisant la ligne de commande KSQL :

 - ksql> SET 'auto.offset.reset'='earliest';
 - ksqm> select name, countrycode  from users_stream emit changes;
 - ksql> select name, countrycode  from users_stream emit changes limit 4;
 - ksql> select countrycode, count(*) from users_stream group by countrycode emit changes;
 - ksql> drop stream if exists users_stream delete topic; // cette commande supprime le flux users_stream si celui-ci existe dans ksqlDB, et elle supprime également le sujet Kafka associé à ce flux.




 ## 2 - Creation Stream simple avec producer avec Json :


a - At UNIX prompt : docker exec -it broker /bin/bash
```
kafka-topics --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic USERPROFILE

kafka-console-producer --broker-list localhost:9092 --topic USERPROFILE << EOF
{"userid": 1000, "firstname":"Alison", "lastname":"Smith", "countrycode":"GB", "rating":4.7}
EOF

kafka-console-producer --broker-list localhost:9092 --topic USERPROFILE << EOF
{"userid": 1001, "firstname":"Bob", "lastname":"Smith", "countrycode":"US", "rating":4.2}
EOF
```

b - At KSQL prompt : docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088
```
CREATE STREAM userprofile (userid INT, firstname VARCHAR, lastname VARCHAR, countrycode VARCHAR, rating DOUBLE) \
  WITH (VALUE_FORMAT = 'JSON', KAFKA_TOPIC = 'USERPROFILE');
```

```
SET 'auto.offset.reset'='earliest';

select firstname, lastname, countrycode, rating from userprofile emit changes;

Alison | Smith | GB | 4.7
```

## 3 - KSQL Datagen - Generating Streams : 

Premier prompt : 
At UNIX prompt
```
ksql-datagen schema=./datagen/userprofile.avro format=json topic=USERPROFILE key=userid msgRate=1 iterations=1000
```

Second prompt : 

At KSQL prompt : il faudra faire ksql comme commande -> 
```
-- Review a stream - every 5th row
print 'USERPROFILE' interval 5;
```

## 4 - Manipulate a Stream
At KSQL prompt

```
ksql> describe userprofile;

Name                 : USERPROFILE
 Field       | Type
-----------------------------------------
 USERID      | INTEGER
 FIRSTNAME   | VARCHAR(STRING)
 LASTNAME    | VARCHAR(STRING)
 COUNTRYCODE | VARCHAR(STRING)
 RATING      | DOUBLE


select rowtime, firstname from userprofile emit changes;
```

- Review _Scalar functions_ at https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html#scalar-functions
```

select  TIMESTAMPTOSTRING(rowtime, 'dd/MMM HH:mm') as createtime, firstname + ' ' + ucase(lastname)  as full_name
from userprofile emit changes;
```


## 5 - ksqlDB Tables
Create a table

At UNIX prompt
```
kafka-topics --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic COUNTRY-CSV

-- version 5.5 and later
kafka-console-producer --broker-list localhost:9092 --topic COUNTRY-CSV --property "parse.key=true"  --property "key.separator=:" << EOF
AU:Australia
IN:India
GB:UK
US:United States
EOF
```


At KSQL prompt

```
-- version 5.5 and later
CREATE TABLE COUNTRYTABLE  (countrycode VARCHAR PRIMARY KEY, countryname VARCHAR) WITH (KAFKA_TOPIC='COUNTRY-CSV', VALUE_FORMAT='DELIMITED');

show tables;

describe COUNTRYTABLE;

describe COUNTRYTABLE extended;

SET 'auto.offset.reset'='earliest';

select countrycode, countryname from countrytable emit changes;

-- Note the countryname is "UK"
select countrycode, countryname from countrytable where countrycode='GB' emit changes limit 1;

-- This does not exist
select countrycode, countryname from countrytable where countrycode='FR' emit changes;
```

### Update a table
One record updated (UK->United Kingdom), one record added (FR)

At UNIX prompt
```
kafka-console-producer --broker-list localhost:9092 --topic COUNTRY-CSV --property "parse.key=true"  --property "key.separator=:" << EOF
GB:United Kingdom
FR:France
EOF
```

At KSQL prompt
```
select countrycode, countryname from countrytable emit changes;

-- Note the countryname has changed to "United Kingdom"
select countrycode, countryname from countrytable where countrycode='GB' emit changes limit 1;

-- And now appears
select countrycode, countryname from countrytable where countrycode='FR' emit changes;
```