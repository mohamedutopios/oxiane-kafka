#!/bin/bash

# Chemin de base pour l'installation de Kafka
KAFKA_PATH=~/kafka_2.13-3.1.0

# Créer les répertoires de données pour ZooKeeper et Kafka
# mkdir -p $KAFKA_PATH/data/zookeeper
mkdir -p $KAFKA_PATH/data/kafka1
mkdir -p $KAFKA_PATH/data/kafka2
mkdir -p $KAFKA_PATH/data/kafka3

# Configurer ZooKeeper
#echo "dataDir=$KAFKA_PATH/data/zookeeper" >> $KAFKA_PATH/config/zookeeper.properties

# Démarrer ZooKeeper
zookeeper-server-start.sh $KAFKA_PATH/config/zookeeper.properties &
sleep 5

# Configuration de chaque broker Kafka
for i in 1 2 3
do
  cp $KAFKA_PATH/config/server.properties $KAFKA_PATH/config/server$i.properties
  echo "broker.id=$i" >> $KAFKA_PATH/config/server$i.properties
  echo "log.dirs=$KAFKA_PATH/data/kafka$i" >> $KAFKA_PATH/config/server$i.properties
  echo "listeners=PLAINTEXT://:909$i" >> $KAFKA_PATH/config/server$i.properties
  echo "zookeeper.connect=localhost:2181" >> $KAFKA_PATH/config/server$i.properties
done

# Démarrer chaque broker Kafka
for i in 1 2 3
do
  kafka-server-start.sh $KAFKA_PATH/config/server$i.properties &
done

echo "Brokers Kafka démarrés avec succès."
