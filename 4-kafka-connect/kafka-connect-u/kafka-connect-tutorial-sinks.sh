#!/bin/bash

# Assurez-vous de changer la variable ADV_HOST dans docker-compose.yml
# si vous utilisez Docker Toolbox

# 1) Connecteurs Source
# Démarrage de notre cluster Kafka
docker-compose up kafka-cluster elasticsearch postgres
# Attendez 2 minutes pour que le cluster Kafka soit démarré

###############
# A) ElasticSearch Sink
# Informations ici : http://docs.confluent.io/3.2.0/connect/connect-elasticsearch/docs/elasticsearch_connector.html
# Nous nous assurons qu'Elasticsearch fonctionne. Remplacez 127.0.0.1 par 192.168.99.100 si nécessaire
http://127.0.0.1:9200/
# Allez à l'interface de connexion et appliquez la configuration à :
sink/demo-elastic/sink-elastic-twitter-distributed.properties
# Visualisez les données à :
http://127.0.0.1:9200/_plugin/dejavu
# http://docs.confluent.io/3.1.1/connect/connect-elasticsearch/docs/configuration_options.html
# Comptage du nombre de tweets :
http://127.0.0.1:9200/demo-3-twitter/_count
# Vous pouvez télécharger les données depuis l'interface pour voir à quoi elles ressemblent
# Nous pouvons interroger Elasticsearch pour les utilisateurs qui ont beaucoup d'amis, voir query-high-friends.json
###############

###############
# B) Démonstration de l'API REST
# Les exemples sont tirés d'ici : http://docs.confluent.io/3.2.0/connect/managing.html#common-rest-examples
# Voir le fichier sink/demo-rest-api/demo-rest-api.sh
###############

###############
# B) Démonstration du JDBC Sink
# Les exemples sont tirés d'ici : http://docs.confluent.io/3.2.0/connect/managing.html#common-rest-examples
# Voir le fichier sink/demo-rest-api/demo-rest-api.sh
###############

###############
# C) Démonstration de PostgreSQL
# Les exemples sont pris ici : http://docs.confluent.io/3.2.0/connect/connect-jdbc/docs/sink_connector.html#quickstart
