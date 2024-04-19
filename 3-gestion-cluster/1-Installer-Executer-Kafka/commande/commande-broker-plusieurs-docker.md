# Quelques commandes à tester : 

# 1 - producer et consummer : 

 - docker exec -it -u root kafka1 /bin/bash
 - cd /usr/bin
 - kafka-console-producer --broker-list kafka1:9092,kafka2:9092,kafka3:9092 --topic topic1

 - docker exec -it -u root kafka2 /bin/bash
 - cd /usr/bin
 - kafka-console-consumer --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --topic topic1 --from-beginning

# 2 - Liste des topics : 
# Dans un broker
- docker exec -it -u root kafka1 /bin/bash
- cd /usr/bin
- kafka-topics --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 --list

# 3 - Décrire un Topic
- kafka-topics --bootstrap-server localhost:9092 --describe --topic topic1

# 4 - Modifier le nombre de partitions à 6:
- kafka-topics --bootstrap-server kafka1:9092 --alter --topic topic1 --partitions 6
kafka-topics --bootstrap-server kafka1:9092 --describe --topic topic1 // pour voir les modification -> Pas assez replication (facteur de replication à 1)


# 5 - Créer un topic avec un facteur de replication à 3 et 3 partitions.
- kafka-topics --create --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 --replication-factor 3 --partitions 3 --topic topic2
- kafka-topics --bootstrap-server localhost:9092 --describe --topic topic2 ou kafka-topics --describe --bootstrap-server kafka1:9092 --topic topic2

# 6 - Créer un topic avec un facteur de replication à 3 et 6 partitions.
 kafka-topics --create --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 --
replication-factor 3 --partitions 6 --topic topic3


# 7 - Supprimer un topic (topic2) : 
kafka-topics --bootstrap-server localhost:9092 --delete --topic topic2



