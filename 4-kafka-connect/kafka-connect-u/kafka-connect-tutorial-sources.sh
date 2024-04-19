Voici la traduction en français du script Bash et des commentaires :

```bash
#!/bin/bash

# Assurez-vous de changer la variable ADV_HOST dans docker-compose.yml
# si vous utilisez Docker Toolbox

# 1) Connecteurs Source
# Démarrage de notre cluster Kafka
docker-compose up kafka-cluster
# Attendez 2 minutes pour que le cluster Kafka soit démarré

###############
# A) FileStreamSourceConnector en mode autonome
# Consultez le fichier source/demo-1/worker.properties et modifiez bootstrap
# Consultez le fichier source/demo-1/file-stream-demo.properties
# Consultez le fichier demo-file.txt

# Nous démarrons un outil hébergé, mappé sur notre code
# Linux / Mac
docker run --rm -it -v "$(pwd)":/tutorial --net=host landoop/fast-data-dev:cp3.3.0 bash
# Ligne de commande Windows:
docker run --rm -it -v %cd%:/tutorial --net=host landoop/fast-data-dev:cp3.3.0 bash
# PowerShell Windows:
docker run --rm -it -v ${PWD}:/tutorial --net=host landoop/fast-data-dev:cp3.3.0 bash

# nous lançons le connecteur Kafka en mode autonome :
cd /tutorial/source/demo-1
# créez le sujet sur lequel nous allons écrire avec 3 partitions
kafka-topics --create --topic demo-1-standalone --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Utilisation : connect-standalone worker.properties connector1.properties [connector2.properties connector3.properties]
connect-standalone worker.properties file-stream-demo-standalone.properties
# écrivez des données dans le fichier demo-file.txt !
# fermez le terminal lorsque vous avez terminé.
###############

###############
# B) FileStreamSourceConnector en mode distribué :
# créez le sujet sur lequel nous allons écrire
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic demo-2-distributed --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# vous pouvez maintenant fermer la nouvelle shell

# rendez-vous sur 127.0.0.1:3030 -> Connect UI
# Créez un nouveau connecteur -> Source de fichier
# Collez la configuration à source/demo-2/file-stream-demo-distributed.properties

# Maintenant que la configuration est lancée, nous devons créer le fichier demo-file.txt
docker ps
docker exec -it <containerId> bash
touch demo-file.txt
echo "hi" >> demo-file.txt
echo "hello" >> demo-file.txt
echo "from the other side" >> demo-file.txt

# Lisez les données du sujet
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-console-consumer --topic demo-2-distributed --from-beginning --bootstrap-server 127.0.0.1:9092
# observez que nous avons maintenant du json en sortie, même si l'entrée était du texte !
###############

###############
# C) TwitterSourceConnector en mode distribué :
# créez le sujet sur lequel nous allons écrire
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic demo-3-twitter --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Démarrez un consommateur console sur ce sujet
kafka-console-consumer --topic demo-3-twitter --bootstrap-server 127.0.0.1:9092

# Suivez les instructions à : https://github.com/Eneco/kafka-connect-twitter#creating-a-twitter-application
# Pour obtenir les clés nécessaires, visitez https://apps.twitter.com/ et créez une nouvelle application. Remplissez un nom d'application, une description, un site web et acceptez l'accord de développeur. Cliquez sur Créer mon jeton d'accès et remplissez un fichier twitter-source.properties avec la clé et le secret du consommateur, ainsi que le jeton d'accès et le secret du jeton en vous basant sur le fichier exemple pour commencer.

# Instructions de configuration pour le connecteur à : https://github.com/Eneco/kafka-connect-twitter#setup
# Remplissez les informations requises à demo-3/source